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
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;

	public class Game extends MovieClip {

		// Current State
		private var currentState: State;
		
		// Resources
		public var resourceURLs: Array = [ "images/player.png", "images/ball.png", "images/left_hand.png",
										   "images/right_hand.png", "images/heart.png", "images/background_image.png",
										   "images/checkbox_checked.png", "images/checkbox_unchecked.png"];
		
		public var soundURLs: Array = [ "sounds/launch.mp3", "sounds/circus.mp3", "sounds/transition.mp3" ];
		
		public var soundChannel: SoundChannel;
		public var volumeAdjust: SoundTransform;

		// Maps
		public var resourceMap: Object;
		public var keyMap: Object;
		public var mouseDown: Boolean = false;
		
		// Leap Motion
		public var leapMap: Object;
		public var leapMotion: LeapListener;
		
		// Settings
		public var settings: Object;
		
		// Background Image
		public var backgroundImage: Sprite;
		
		// Server
		public var highScoreSender: HighScoreSender;

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
			highScoreSender = new HighScoreSender("http://malabarismo.herokuapp.com/new-score");
			
			// Sounds
			soundChannel = new SoundChannel();
			volumeAdjust = new SoundTransform();
			
			// Start game on the menu
			currentState = new LoadingState(this);
			currentState.setup();
		}
		
		public function checkBounds(minX: Number, maxX: Number, minY: Number, maxY: Number): Boolean {
			if(this.stage.mouseX >= minX && this.stage.mouseX <= maxX && this.stage.mouseY >= minY && this.stage.mouseY <= maxY) {
				return true;
			} else {
				return false;
			}
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
	}

}