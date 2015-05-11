package  {

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

	public class GameState extends State {
		private var player: Sprite;
		private var playerScore: int;
		private var playerSpeed: int = 10;

		private var scoreTextField: TextField;
		
		public function GameState(game: Game) {
			super(game);
			
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest("test.png"));
			
			scoreTextField = new TextField();
			this.game.addChild(scoreTextField);
			
			playerScore = 0;
		}

		private function onLoadComplete(e: Event): void {
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			var loadedBitmap: Bitmap = loaderInfo.content as Bitmap;

			player = new Sprite();
			player.addChild(loadedBitmap);

			this.game.addChild(player);

			player.x = 100;
			player.y = 200;
		}		
		
		override public function handleKeyDown(event: KeyboardEvent): void {
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
		
		override public function update(): void {
			playerScore++;
			scoreTextField.text = "frame nr" + playerScore;
		}
		
	}

}
