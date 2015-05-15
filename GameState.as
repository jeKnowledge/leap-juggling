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

	public class GameState extends State {
		private var player: Sprite;
		private var playerScore: int;
		private var playerSpeed: int = 10;

		private var scoreTextField: TextField;
		
		public function GameState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			scoreTextField = new TextField();
			this.game.addChild(scoreTextField);
			
			player = new Sprite();
			player.addChild(this.game.resourceMap["player.png"]);
			this.game.addChild(player);
			player.x = 800 / 2 - 150;
			player.y = 640 - 220;
			
			var myBall: Ball = new Ball(this);
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
