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

		public function Game() {
			var gameState: GameState = new GameState(this);
			currentState = gameState;
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
		}

		function reportKeyDown(event: KeyboardEvent): void {
			currentState.handleKeyDown(event);
		}

		protected function enterFrameHandler(event: Event): void {
			currentState.update();
		}
	}

}