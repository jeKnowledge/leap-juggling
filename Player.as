package {

	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;

	import com.leapmotion.leap.*;
	import com.leapmotion.leap.events.*;
	import com.leapmotion.leap.util.*;

	public class Player extends GameObject {

		// Player Settings
		private var NUM_LIVES: int = 3;

		// Hands
		public var leftHand: GameHand;
		public var rightHand: GameHand;

		// Lives
		public var lives: Vector.<Sprite> ;

		// Score
		public var score: int = 0;
		
		// Aux Variables
		private var canLaunch: Boolean = true;

		public function Player(gameState: GameState) {
			super(gameState);
		}

		private function findFirstBallInLeftHand(): Ball {
			for each(var ball in gameState.balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					return ball;
				}
			}

			return null;
		}

		public function findBallsInLeftHand(): Vector.<Ball> {
			var ballsInLeftHand: Vector.<Ball> = new Vector.<Ball>();

			for each(var ball in gameState.balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					ballsInLeftHand.push(ball);
				}
			}

			return ballsInLeftHand;
		}

		public function findBallsInRightHand(): Vector.<Ball> {
			var ballsInRightHand: Vector.<Ball> = new Vector.<Ball>();

			for each(var ball in gameState.balls) {
				if (ball.state == BallPosition.RIGHT_HAND) {
					ballsInRightHand.push(ball);
				}
			}

			return ballsInRightHand;
		}
		
		private function updateCanLaunch(e: TimerEvent): void {
			this.canLaunch = true;
		}

		public function launchBall(): void {
			var ballsInRightHand: Vector.<Ball> = findBallsInRightHand();

			if (ballsInRightHand.length > 0 && canLaunch) {
				var ballToLaunch: Ball = ballsInRightHand[0];

				for each(var ball in ballsInRightHand) {
					if (ball.sprite.y < ballToLaunch.sprite.y) {
						ballToLaunch = ball;
					}
				}

				if (gameState.game.leapMode) {
					ballToLaunch.launch(10);
					canLaunch = false;
					var timer: Timer = new Timer(200, 1);
					timer.addEventListener("timer", this.updateCanLaunch);
					timer.start();
				} else {
					ballToLaunch.launch(gameState.ballChargeBeginning);
				}
				gameState.launchSound.play(0, 1, gameState.volumeAdjust);
			}
		}

		public function decreaseLives(): void {
			var live: Sprite = lives.pop();
			this.gameState.game.removeChild(live);
		}

		public override function setup(): void {
			sprite.addChild(gameState.game.resourceMap["images/player.png"]);
			sprite.x = 800 / 2 - 150;
			sprite.y = 640 - 220;
			this.gameState.game.addChild(sprite);

			this.leftHand = new GameHand(this.gameState, 440, 520, "images/left_hand.png");
			this.rightHand = new GameHand(this.gameState, 230, 520, "images/right_hand.png");

			// Lives Sprites
			lives = new Vector.<Sprite>();
			for (var i: Number = 0; i < NUM_LIVES; i++) {
				var live: Sprite = new Sprite();
				live.addChild(new Bitmap(gameState.game.resourceMap["images/heart.png"].bitmapData));
				live.x = (i + 1) * 20;
				live.y = 20;
				gameState.game.addChild(live);
				lives.push(live);
			}

			// Text Fields
			this.textFields = new CustomTextFields(this.gameState.game);
			textFields.createCustomTextField("score", "Score: " + this.score.toString(), 700, 20, 20);
		}

		public override function update(): void {
			// Mouse/Leap Track Left Hand
			if (gameState.game.leapMode) {
				if (gameState.game.leapMotion.hands.rightX + 420 <= 600 && gameState.game.leapMotion.hands.rightX + 420 >= 400) {
					leftHand.sprite.x = gameState.game.leapMotion.hands.rightX + 420;
				}
			} else {
				if (gameState.game.mouse.x <= 600 && gameState.game.mouse.x >= 400) {
					leftHand.sprite.x = gameState.game.stage.mouseX;
				}
			}

			// Mouse Click / Leap Swipe
			if (gameState.game.mouse.down || gameState.game.leapMap[LeapPosition.RIGHT_TAP]) {
				if (gameState.game.leapMap[Gesture.TYPE_KEY_TAP]) {
					gameState.game.leapMap[Gesture.TYPE_KEY_TAP] = false;
				}
				
				if (gameState.balls.length > 0) {
					var ballInLeftHand: Ball = findFirstBallInLeftHand();

					if (ballInLeftHand) {
						ballInLeftHand.canCollide = false;
						ballInLeftHand.vy = -10;
						ballInLeftHand.vx = -0.05 * (leftHand.sprite.x - rightHand.sprite.x);
						ballInLeftHand.state = BallPosition.NONE;

						var timer: Timer = new Timer(200, 1);
						timer.addEventListener("timer", ballInLeftHand.updateCanCollide);
						timer.start();
						score++;
					}
				}
			}


			// Space Bar Click
			if (gameState.game.leapMode) {
				if (gameState.game.leapMap[LeapPosition.LEFT_TAP]) {
					gameState.game.leapMap[LeapPosition.LEFT_TAP] = false;
					launchBall();
				}
			} else {
				if (gameState.game.keyMap[Keyboard.SPACE]) {
					if (!gameState.ballCharging) {
						gameState.ballChargeBeginning = gameState.currentFrame;
						gameState.ballCharging = true;
					}
				} else {
					if (gameState.ballCharging) {
						launchBall();
						gameState.ballCharging = false;
					}
				}
			}

			// Check if should lose a live
			if (findBallsInLeftHand().length > 1) {
				gameState.resetBallPosition();
				decreaseLives();
			}

			textFields.updateCustomTextField("score", "Score: " + this.score.toString());
		}

	}

}