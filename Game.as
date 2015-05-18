﻿package {

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

	public class Game extends MovieClip {

		private var currentState: State;
		
		public var resourceMap: Object;
		public var keyMap: Object;
		
		public var mouse: Object = { x: 0, y: 0, down: false };

		public function Game() {
			resourceMap = new Object();
			keyMap = new Object();
			
			var resourceURLs: Array = ["images/player.png", "images/ball.png", "images/hand.png", "images/heart.png"];
			
			for each (var resourceURL in resourceURLs) {
				var loader: Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.load(new URLRequest(resourceURL));
			}

			var soundURLs: Array = ["sounds/launch.mp3", "sounds/circus.mp3"];

			for each (var soundURL in soundURLs) {
				var s: Sound = new Sound();
				s.addEventListener(Event.COMPLETE, onSoundLoaded);
				var req:URLRequest = new URLRequest(soundURL);
				s.load(req);
			}

			currentState = new MenuState(this);
			currentState.setup();

			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, reportMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, reportMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, reportMouseMove);
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
		
		function reportKeyDown(event: KeyboardEvent): void {
			keyMap[event.keyCode] = true;
		}
		
		function reportKeyUp(event: KeyboardEvent): void {
			keyMap[event.keyCode] = false;
		}
		
		function reportMouseDown(event: MouseEvent): void {
			mouse.down = true;
		}

		function reportMouseUp(event: MouseEvent): void {
			mouse.down = false;
		}
		
		function reportMouseMove(event: MouseEvent): void {
			mouse.x = event.stageX;
			mouse.y = event.stageY;
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

	}

}