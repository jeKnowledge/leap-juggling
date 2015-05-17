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
		public var leftHand: LeftHand;
		
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
			leftHand = new LeftHand(this);
			

			player.x = 800 / 2 - 150;
			player.y = 640 - 220;
		}

		public function createBall(): void {
			if (balls.length < 5) {
				var newBall: Ball = new Ball(this, currentFrame - ballChargeBeginning);
				balls.push(newBall);
			}
		}
				
		override public function update(): void {
			currentFrame++;

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
