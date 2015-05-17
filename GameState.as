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
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class GameState extends State {

		private var scoreTextField: TextField;	
		public var timer: Timer;
		
		private var player: Sprite;
		public var playerScore: int;
		private var playerSpeed: int = 10;
		
		public var force: Number;
		
		public var balls: Vector.<Ball>;
		
		public function GameState(game: Game) {
			super(game);

			balls = new Vector.<Ball>();
			
			force = -1;
		}
		
		override public function setup(): void {
			scoreTextField = new TextField();
			scoreTextField.width = 200;
			this.game.addChild(scoreTextField);

			player = new Sprite();
			player.addChild(this.game.resourceMap["player.png"]);
			this.game.addChild(player);

			player.x = 800 / 2 - 150;
			player.y = 640 - 220;
		}

		public function createBall(): void {
			if (force == -1) {
				force = playerScore;
			}
			
			if (balls.length < 5) {
				var newBall: Ball = new Ball(this);
				balls.push(newBall);
			}
		}
				
		override public function update(): void {
			playerScore ++;
			scoreTextField.text = "Frame number (player score): " + playerScore;
			
			if (game.keyMap[Keyboard.SPACE]) {
				createBall();
				game.keyMap[Keyboard.SPACE] = false;
			}
			
			for each (var ball in balls) {
				ball.update();
			}
		}

	}

}
