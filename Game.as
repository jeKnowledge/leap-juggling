package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.events.IOErrorEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.media.Sound;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;

	public class Game extends MovieClip {

		// Current State
		private var currentState: State;
		
		// Resources
		public var resourceURLs: Array = [ "assets/images/player.png", "assets/images/ball.png", "assets/images/left_hand.png",
										   "assets/images/right_hand.png", "assets/images/heart.png", "assets/images/background_image.png",
										   "assets/images/checkbox_checked.png", "assets/images/checkbox_unchecked.png", "assets/images/point.png"];
		
		public var soundURLs: Array = [ "assets/sounds/launch.mp3", "assets/sounds/circus.mp3", "assets/sounds/transition.mp3" ];
		
		public var soundChannel: SoundChannel;
		public var volumeAdjust: SoundTransform;

		// Maps
		public var resourceMap: Object;
		public var keyMap: Object;
		public var mouseDown: Boolean = false;
		
		// Leap Motion
		public var leapMap: Object;
		public var leapMotion: LeapListener;
		public var pointer: Sprite;
		
		// Settings
		public var settings: Object;
		
		// Background Image
		public var backgroundImage: Sprite;
		
		// Server
		public var serverCommunicator: ServerCommunicator;

		public function Game() {
			// Maps
			resourceMap = new Object();
			keyMap = new Object();

			// Leap Motion
			leapMotion = new LeapListener(this);
			leapMap = new Object();
			
			// Load Settings
			settings = new Object();
			loadSettings();
			
			// Events
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, reportMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, reportMouseUp);
			
			// Server
			serverCommunicator = new ServerCommunicator();
			
			// Sounds
			soundChannel = new SoundChannel();
			volumeAdjust = new SoundTransform();
			
			// Start game on the menu
			currentState = new LoadingState(this);
			currentState.setup();
		}
		
		public function reportKeyDown(event: KeyboardEvent): void {
			keyMap[event.keyCode] = true;
		}
		
		public function reportKeyUp(event: KeyboardEvent): void {
			keyMap[event.keyCode] = false;
		}
		
		public function reportMouseDown(event: MouseEvent): void {
			mouseDown = true;
		}

		public function reportMouseUp(event: MouseEvent): void {
			mouseDown = false;
		}
		
		protected function enterFrameHandler(event: Event): void {
			currentState.update();
		}
		
		private function clearStage() {
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		
		public function changeState(newState: State) {
			clearStage();

			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			newState.setup();
			currentState = newState;
			
			// Add background image again
			this.backgroundImage = new Sprite();
			this.backgroundImage.addChild(this.resourceMap["assets/images/background_image.png"]);
			this.backgroundImage.width = this.stage.stageWidth;
			this.backgroundImage.height = this.stage.stageHeight;
			this.addChild(this.backgroundImage);
			this.setChildIndex(this.backgroundImage, 0);
			
			if (settings.leapMode && currentState.useLeapPointer) {
				pointer = new Sprite();
				pointer.addChild(resourceMap["assets/images/point.png"]);
				this.addChild(pointer);
			}
		}
		
		private function stringToBoolean(string: String): Boolean {
			if (string == "true") {
				return true;
			} else {
				return false;
			}
		}
		
		public function loadSettingsFromTextFileAsArray(array: Array) {
			for (var i: int = 0; i < array.length; i++) {
				if (i == 0) {
					settings.leapMode = stringToBoolean(array[i]);
				} else if (i == 1) {
					settings.volume = Number(array[i]);
				} else if (i == 2) {
					settings.windowSize = array[i];
				}
			}
		}
		
		public function loadSettings(): void {
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);

			/* Called when the settings file fails to load (does not exist) */
			function onLoadError(e: Event): void {
				var pathToFile: String = File.applicationDirectory.resolvePath("settings.txt").nativePath;
				var file: File = new File(pathToFile);

				var stream: FileStream = new FileStream();
				stream.open(file, FileMode.WRITE);
				stream.writeUTFBytes("false\n0.5\nwindowSize\n");
				stream.close();
				
				loadSettingsFromTextFileAsArray(["false", "0.5", "windowSize"]);
			}
			
			function onLoaded(e: Event): void {
				var array: Array = e.target.data.split(/\n/);
				loadSettingsFromTextFileAsArray(array);
			}
			
			loader.load(new URLRequest("settings.txt"));
		}
		
		public function saveSettings(): void {
			var pathToFile: String = File.applicationDirectory.resolvePath("settings.txt").nativePath;
			var file: File = new File(pathToFile);

			var stream: FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(settings.leapMode.toString() + "\n" +
								 settings.volume.toString() + "\n" + 
								 settings.windowSize + "\n");
			stream.close();
		}
		
		public function getRectangleBorder(x: int, y: int, width: int, height: int, thickness: int): Shape {
			var rectBorder: Shape = new Shape;
			rectBorder.graphics.lineStyle(thickness, 0x000, 1);
			rectBorder.graphics.moveTo(x, y); 
			rectBorder.graphics.lineTo(x + width, y);
			rectBorder.graphics.lineTo(x + width, y + height);
			rectBorder.graphics.lineTo(x, y + height);
			rectBorder.graphics.lineTo(x, y);
			return rectBorder;
		}
		
		public function updateVolume(): void {
			volumeAdjust.volume = settings.volume;
			soundChannel.soundTransform = volumeAdjust;
		}
		
		public function updateLeapPointer(): void {
			if (this.settings.leapMode) {
				this.pointer.x = this.leapMotion.hands.rightX + 250;
				this.pointer.y = -this.leapMotion.hands.rightY + 500;
			}
		}
		
		public function checkBounds(object: DisplayObject): Boolean {
			if (this.leapMotion.hands.rightX + 250 >= object.x &&
				this.leapMotion.hands.rightX + 250 <= object.x + object.width && 
				-this.leapMotion.hands.rightY + 500 >= object.y &&
				-this.leapMotion.hands.rightY + 500 <= object.y + object.height) {
				return true;
			} else {
				return false;
			}
		}
		
	}

}