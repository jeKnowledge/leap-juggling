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

	public class GameState extends MovieClip {

		private var scoreTextField: TextField;
		private var player: Sprite;
		private var playerScore: int;
		private var playerSpeed: int;

		public function GameState() {
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest("test.png"));

			scoreTextField = new TextField();
			addChild(scoreTextField);

			addEventListener(Event.ENTER_FRAME, enterFrameHandler);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);

			playerSpeed = 10;
		}

		function reportKeyDown(event: KeyboardEvent): void {
			if (event.keyCode == Keyboard.RIGHT) {
				player.x += playerSpeed;
			}

			if (event.keyCode == Keyboard.UP) {
				player.y -= playerSpeed;
			}

			if (event.keyCode == Keyboard.DOWN) {
				player.y += playerSpeed;
			}

			if (event.keyCode == Keyboard.LEFT) {
				player.x -= playerSpeed;
			}
		}

		protected function enterFrameHandler(event: Event): void {
			playerScore++;
			scoreTextField.text = playerScore.toString();

			scoreTextField.x = 10;
			scoreTextField.y = 10;
		}

		private function onLoadComplete(e: Event): void {
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			var loadedBitmap: Bitmap = loaderInfo.content as Bitmap;

			player = new Sprite();
			player.addChild(loadedBitmap);

			addChild(player);

			player.x = 100;
			player.y = 200;
		}
	}

}