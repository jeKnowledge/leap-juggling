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
		private var ballFactory:SpriteFactory;
		
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

			ballFactory = new SpriteFactory();
			ballFactory.loadBitmap("ball", "test2.png");

			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, ballCreate);
			timer.start();

			//var newBall: Ball = new Ball(this, ballFactory.newSprite("ball"));
			//balls.push(newBall);
		}

		public function ballCreate(e: Event): void {
			trace("comprimento = " + balls.length);
			trace("numero de children no stage = " + game.numChildren);
			
			var newBall: Ball = new Ball(this, ballFactory.newSprite("ball"));
			balls.push(newBall);
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
				trace("ball number " + (i++) + "is at x = " + ball.sprite.x);
				ball.update();
			}
		}

	}

}
