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

	public class Game extends MovieClip {

		private var currentState: State;
		
		public var resourceMap: Object;

		public function Game() {
			resourceMap = new Object();
			
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest("test.png"));
			
			currentState = new MenuState(this);
			currentState.setup();

			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
		}

		private function onLoadComplete(e: Event): void {
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			var loadedBitmap: Bitmap = loaderInfo.content as Bitmap;
			
			var resourceName: String = loaderInfo.url.slice(5);
			
			resourceMap[resourceName] = loadedBitmap;
			trace("New object called " + resourceName + " has been added to resourceMap.");
		}
		
		function reportKeyDown(event: KeyboardEvent): void {
			currentState.handleKeyDown(event);
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