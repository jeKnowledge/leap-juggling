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
		public var firstLaunch: Boolean = true;

		public function Player(gameState: GameState) {
			super(gameState);
		}
		
		private function updateCanLaunch(e: TimerEvent): void {
			this.canLaunch = true;
		}

		public function launchBall(): void {
			var ballsInRightHand: Vector.<Ball> = gameState.ballsInHand(rightHand);

			if (ballsInRightHand.length > 0 && canLaunch) {
				var ballToLaunch: Ball = gameState.ballsInHand(this.rightHand)[0];

				for each(var ball in gameState.ballsInHand(this.rightHand)) {
					if (ball.sprite.y < ballToLaunch.sprite.y) {
						ballToLaunch = ball;
					}
				}

				if (gameState.game.settings.leapMode) {
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
			// Sprite
			sprite.addChild(gameState.game.resourceMap["images/player.png"]);
			sprite.x = 800 / 2 - 150;
			sprite.y = 640 - 220;
			this.gameState.game.addChild(sprite);

			// Hands
			this.leftHand = new GameHand(this.gameState, 440, 520, "images/left_hand.png", HandType.LEFT_HAND);
			this.rightHand = new GameHand(this.gameState, 230, 520, "images/right_hand.png", HandType.RIGHT_HAND);

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
			if (gameState.game.settings.leapMode) {
				if (gameState.game.leapMotion.hands.rightX + 420 <= 600 && gameState.game.leapMotion.hands.rightX + 420 >= 400) {
					leftHand.sprite.x = gameState.game.leapMotion.hands.rightX + 420;
				}
			} else {
				if (gameState.game.stage.mouseX <= 600 && gameState.game.stage.mouseX >= 400) {
					leftHand.sprite.x = gameState.game.stage.mouseX;
				}
			}

			// Mouse Click / Leap Tap
			if (gameState.game.mouseDown || gameState.game.leapMap[LeapPosition.RIGHT_TAP]) {
				if (gameState.game.leapMap[LeapPosition.RIGHT_TAP]) {
					gameState.game.leapMap[LeapPosition.RIGHT_TAP] = false;
				}
				
				if (gameState.balls.length > 0) {
					var ballsInLeftHand: Vector.<Ball> = gameState.ballsInHand(leftHand);
					
					if (ballsInLeftHand.length > 0) {
						if (firstLaunch) {
							firstLaunch = false;
						}
						
						ballsInLeftHand[0].canCollide = false;
						ballsInLeftHand[0].vy = -10;
						ballsInLeftHand[0].vx = -0.05 * (leftHand.sprite.x - rightHand.sprite.x);
						ballsInLeftHand[0].state = BallPosition.NONE;

						var timer: Timer = new Timer(200, 1);
						timer.addEventListener("timer", ballsInLeftHand[0].updateCanCollide);
						timer.start();
						score++;
					}
				}
			}

			// Space Bar Click

			if (gameState.game.settings.leapMode) {
				if (gameState.game.leapMap[LeapPosition.SWIPE_UP]) {
					launchBall();
					gameState.game.leapMap[LeapPosition.SWIPE_UP] = false;
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

			textFields.updateCustomTextField("score", "Score: " + this.score.toString());
		}

	}

}