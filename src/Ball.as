package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;

	public class Ball extends GameObject {

		// Velocities
		public var vx: Number = 10;
		public var vy: Number;
		
		// Constants
		public var GRAVITY: Number = 0.96;
		private static const FRICTION: Number = 0.98;
		
		// Aux Variables
		public var state: String = BallPosition.NONE;
		public var canCollide: Boolean = false;
		public var touched: Boolean = false;
		private var floor: Number;

		public function Ball(gameState: GameState) {
			super(gameState);
		}
		
		public function updateCanCollide(e: Event): void {
			canCollide = true;
		}

		public function handleCollision(e: Event): void {
			// Check if player should lose lives
			if (gameState.ballsInHand(gameState.player.leftHand).length > 1) {
				gameState.player.decreaseLives();
				gameState.resetBallPosition();
			}
			
			if (gameState.ballsInHand(gameState.player.rightHand).length > 1 && gameState.player.firstLaunch == false) {
				gameState.player.decreaseLives();
				gameState.resetBallPosition();
			}
			
			if (sprite.hitTestObject(gameState.player.leftHand.sprite) && canCollide) {
				touched = true;
				state = BallPosition.LEFT_HAND;
			} else if (sprite.hitTestObject(gameState.player.rightHand.sprite) && canCollide) {
				touched = true;
				state = BallPosition.RIGHT_HAND;
			} else {
				touched = false;
			}
		}

		public function launch(ballChargeBeginning: int): void {
			canCollide = false;
			state = BallPosition.NONE;

			var timer: Timer = new Timer(200, 1);
			timer.addEventListener("timer", updateCanCollide);
			timer.start();

			var force: int = (gameState.currentFrame - ballChargeBeginning);
			
			vx = 4 + (force * 0.5);
			if (vx > 10) {
				vx = 10;
			}

			vy = -(force * 4) - 15;
			if (vy < -35) {
				vy = -35;
			}
		}
		
		public override function setup(): void {
			this.state = BallPosition.RIGHT_HAND;
			
			floor = gameState.game.stage.height;
			
			sprite.addChild(new Bitmap(gameState.game.resourceMap["assets/images/ball.png"].bitmapData));
			gameState.game.addChild(sprite);

			sprite.addEventListener(Event.ENTER_FRAME, handleCollision);
		}

		public override function update(): void {
			if (state == BallPosition.LEFT_HAND) {
				sprite.x = gameState.player.leftHand.sprite.x;
				sprite.y = gameState.player.leftHand.sprite.y;
			} else if (state == BallPosition.RIGHT_HAND) {
				sprite.x = gameState.player.rightHand.sprite.x;
				sprite.y = gameState.player.rightHand.sprite.y - gameState.ballsInHand(gameState.player.rightHand).indexOf(this) * (0.8 * sprite.height);
			} else {
				if (touched == false) {
					vx *= FRICTION;
					vy *= FRICTION;

					vy += GRAVITY;

					sprite.x += vx;
					sprite.y += vy;

					if (sprite.y >= floor) {
						gameState.player.decreaseLives();
						gameState.resetBallPosition();
						this.state = BallPosition.RIGHT_HAND;
					}
				}
			}
		}
		
	}
	
}