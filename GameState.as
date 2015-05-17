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
		private var player: Sprite;
		private var playerScore: int;
		private var playerSpeed: int = 10;
		public var timer: Timer;
		public var velocity: Number;
		public var spacePressed: Boolean = false; // botelho burro muito mas muito mau nome de variavel wtf
		
		public var force: Number;
		
		public var balls: Vector.<Ball>;
		
		private var scoreTextField: TextField;
		
		public function GameState(game: Game) {
			super(game);

			balls = new Vector.<Ball>();
		}
		
		override public function setup(): void {
			scoreTextField = new TextField();
			this.game.addChild(scoreTextField);

			player = new Sprite();
			player.addChild(this.game.resourceMap["player.png"]);
			this.game.addChild(player);

			player.x = 800 / 2 - 150;
			player.y = 640 - 220;
		}
		
		public function startCounting(): void {
			if (spacePressed == false) {
				force = playerScore;
				spacePressed = true;
			}
		}

		public function ballCreate(): void {
			if (spacePressed) {
				velocity = (playerScore - force) * 0.50; // botelho burro isto devia ser calculado na Ball

				if (balls.length < 3) {
					var newBall: Ball = new Ball(this, velocity);
					balls.push(newBall);
				}

				spacePressed = false;
			}
		}
				
		override public function update(): void {
			if (game.keyMap[Keyboard.SPACE]) {
				startCounting();
			} else {
				ballCreate();
			}

			playerScore++;
			scoreTextField.text = "frame nr" + playerScore;
						
			var i: int = 0;
			for each (var ball in balls) {
				ball.update();
			}
		}

	}

}
