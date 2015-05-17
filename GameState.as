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
		public var currentFrame: int;
		private var playerSpeed: int = 10;
		
		public var leftHand: Hand;
		public var rightHand: Hand;
		
		private var ballChargeBeginning: int;
		private var ballCharging: Boolean = false;
		public var balls: Vector.<Ball>;
		
		public function GameState(game: Game) {
			super(game);

			balls = new Vector.<Ball>();
		}
		
		override public function setup(): void {
			scoreTextField = new TextField();
			scoreTextField.width = 200;
			this.game.addChild(scoreTextField);

			player = new Sprite();
			player.addChild(this.game.resourceMap["images/player.png"]);
			this.game.addChild(player);
			
			leftHand = new Hand(this, 440, 520);
			rightHand = new Hand(this, 230, 520);

			player.x = 800 / 2 - 150;
			player.y = 640 - 220;
		}

		public function createBall(): void {
			if (balls.length < 5) {
				var newBall: Ball = new Ball(this, currentFrame - ballChargeBeginning);
				balls.push(newBall);
			}
		}
		
		private function findBallInLeftHand(): Ball {
			for each (var ball in balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					return ball;
				}
			}
			
			return null;
		}
		
		public function findBallsInRightHand(): Vector.<Ball> {
			var ballsInRightHand: Vector.<Ball> = new Vector.<Ball>();
			
			for each (var ball in balls) {
				if (ball.state == BallPosition.RIGHT_HAND) {
					ballsInRightHand.push(ball);
				}
			}
			
			return ballsInRightHand;
		}
				
		override public function update(): void {
			currentFrame++;

			leftHand.sprite.x = game.mouse.x;
			
			if (game.mouse.down) {
				if (balls.length > 0) {
					var ballInLeftHand: Ball = findBallInLeftHand();
					
					if (ballInLeftHand) {
						ballInLeftHand.state = BallPosition.RIGHT_HAND;
					}
				}
			}

			if (game.keyMap[Keyboard.SPACE]) {
				if (!ballCharging) {
					ballChargeBeginning = currentFrame;
					ballCharging = true;
				}
			} else {
				if (ballCharging) {
					createBall();
					ballCharging = false;
				}
			}
			
			for each (var ball in balls) {
				ball.update();
			}
		}

	}

}
