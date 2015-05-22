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
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.media.Sound;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

	public class Game extends MovieClip {

		// Current State
		private var currentState: State;
		
		// Maps
		public var resourceMap: Object;
		public var keyMap: Object;
		public var mouseDown: Boolean = false;
		
		// Leap Motion
		public var leapMap: Object;
		public var leapMotion: LeapListener;
		
		// Settings
		public var settings: Object = { leapMode: false, volume: 50, windowSize: 'size' };

		public function Game() {
			resourceMap = new Object();
			keyMap = new Object();

			leapMotion = new LeapListener(this);
			leapMap = new Object();
			
			// Load Resources
			var resourceURLs: Array = [ "images/player.png", "images/ball.png", "images/left_hand.png",
										"images/right_hand.png", "images/heart.png" ];
			
			for each (var resourceURL in resourceURLs) {
				var loader: Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.load(new URLRequest(resourceURL));
			}

			var soundURLs: Array = [ "sounds/launch.mp3", "sounds/circus.mp3" ];

			for each (var soundURL in soundURLs) {
				var s: Sound = new Sound();
				s.addEventListener(Event.COMPLETE, onSoundLoaded);
				var req:URLRequest = new URLRequest(soundURL);
				s.load(req);
			}
			
			// Load Settings
			loadSettings();

			// Events
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, reportMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, reportMouseUp);
			
			// Start game on the menu
			currentState = new MenuState(this);
			currentState.setup();
		}

		private function onLoadComplete(e: Event): void {
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			
			var resourceName: String = loaderInfo.url.slice(5);
			var resourceExtension: String = resourceName.substring(resourceName.lastIndexOf(".") + 1, resourceName.length);
						
			if (resourceExtension == "png") {
				var loadedBitmap: Bitmap = loaderInfo.content as Bitmap;
				resourceMap[resourceName] = loadedBitmap;
			}

			trace("New object called " + resourceName + " has been added to resourceMap.");
		}
		
		private function onSoundLoaded(e: Event): void {
			var resourceName: String = e.target.url.slice(5);
			resourceMap[resourceName] = e.target as Sound;
						
			trace("New sound called " + resourceName + " has been added to resourceMap.");
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
		
		public function loadSettings(): void {
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaded);

			function onLoaded(e:Event):void {
				var array: Array = e.target.data.split(/\n/);
				
				for (var i: int = 0; i < array.length; i++) {
					if (i == 0) {
						settings.leapMode = array[i] as Boolean;
					} else if (i == 1) {
						settings.volume = Number(array[i]);
					} else if (i == 2) {
						settings.windowSize = array[i];
					}
				}
			}
			
			loader.load(new URLRequest("settings.txt"));
		}
	}

}