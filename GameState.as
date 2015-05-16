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
		public var spacePressed: Boolean = false;
		
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
			this.game.stage.addEventListener(KeyboardEvent.KEY_DOWN, startCounting);
			this.game.stage.addEventListener(KeyboardEvent.KEY_UP, ballCreate);

		}
		
		public function startCounting(event: KeyboardEvent): void {
			if(event.keyCode == Keyboard.SPACE && spacePressed == false) {
				force = playerScore;
				trace("Force: " + force);
				spacePressed = true;
			}
		}

		public function ballCreate(event: KeyboardEvent): void {
			trace("Player Score: " + playerScore);
			velocity = (playerScore - force) * 1.1;
			trace(velocity);
			if(event.keyCode == Keyboard.SPACE) {
				trace("space clicked");
				if(balls.length < 3) {
					var newBall: Ball = new Ball(this, velocity);
					balls.push(newBall);
				}
				spacePressed = false;
			}
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
						
			var i: int = 0;
			for each (var ball in balls) {
				ball.update();
			}
		}

	}

}
