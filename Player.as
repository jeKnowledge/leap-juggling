package {

	import flash.events.KeyboardEvent;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Player extends GameObject {
		
		// Hands
		public var leftHand: Hand;
		public var rightHand: Hand;
		
		// Lives
		public var lives: Vector.<Sprite>;
		
		public function Player(gameState: GameState) {
			super(gameState);
		}
		
		private function findFirstBallInLeftHand(): Ball {
			for each (var ball in gameState.balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					return ball;
				}
			}
			
			return null;
		}
		
		public function findBallsInLeftHand(): Vector.<Ball> {
			var ballsInLeftHand: Vector.<Ball> = new Vector.<Ball>();
			
			for each (var ball in gameState.balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					ballsInLeftHand.push(ball);
				}
			}
			
			return ballsInLeftHand;
		}
		
		public function findBallsInRightHand(): Vector.<Ball> {
			var ballsInRightHand: Vector.<Ball> = new Vector.<Ball>();
			
			for each (var ball in gameState.balls) {
				if (ball.state == BallPosition.RIGHT_HAND) {
					ballsInRightHand.push(ball);
				}
			}
			
			return ballsInRightHand;
		}
		
		public function launchBall(): void {
			var ballsInRightHand: Vector.<Ball> = findBallsInRightHand();
			
			if (ballsInRightHand.length > 0) {
				var ballToLaunch: Ball = ballsInRightHand[0];
	
				for each (var ball in ballsInRightHand) {
					if (ball.sprite.y < ballToLaunch.sprite.y) {
						ballToLaunch = ball;
					}
				}

				ballToLaunch.launch(gameState.ballChargeBeginning);
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
			
			this.leftHand = new Hand(this.gameState, 440, 520);
			this.rightHand = new Hand(this.gameState, 230, 520);
			
			// Lives Sprites
			lives = new Vector.<Sprite>();
			for(var i: Number = 0; i < 5; i++) {
				var live: Sprite = new Sprite();
				live.addChild(new Bitmap(gameState.game.resourceMap["images/heart.png"].bitmapData));
				live.x = (i + 1) * 20;
				live.y = 10;
				gameState.game.addChild(live);
				lives.push(live);
			}
		}
		
		public override function update(): void {
			// Mouse Track Left Hand
			leftHand.sprite.x = gameState.game.mouse.x;
			if (gameState.game.mouse.x <= 550 && gameState.game.mouse.x >= 350) {
				leftHand.sprite.x = gameState.game.mouse.x; 
			}
			
			// Mouse Click
			if (gameState.game.mouse.down) {
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
					}
				}
			}
			
			// Space Bar Click			
			if (gameState.game.keyMap[Keyboard.SPACE]) {
				if (!gameState.ballCharging) {
					gameState.ballChargeBeginning = gameState.currentFrame;
					gameState.ballCharging = true;
				}
			} else {
				if (gameState.ballCharging) {
					gameState.launchSound.play();
					launchBall();
					gameState.ballCharging = false;
				}
			}
			
			// Check if should lose a live
			if (findBallsInLeftHand().length > 1) {
				gameState.resetBallPosition();
				decreaseLives();
			}
		}

	}

}