package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	
	public class Ball {
		private var gameState: GameState;
		public var sprite: Sprite;
		
		public var state: String = BallPosition.NONE;
		
		public var x: Number;
		public var y: Number;
		public var touched: Boolean = false;

		public var vx: Number = 10;
		public var vy: Number;
		private var gravity: Number = 0.96;
		private var friction: Number = 0.98;
		
		public var canCollide: Boolean = false;

		public function Ball(gameState: GameState, state: String) {
			this.gameState = gameState;
			
			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap["images/ball.png"].bitmapData));
			sprite.x = 200;
			sprite.y = 300;                      
			gameState.game.addChild(sprite);        
			
			sprite.addEventListener(Event.ENTER_FRAME, handleCollision);
			
			this.state = state;
		}
		
		public function updateCanCollide(e: Event): void {
			canCollide = true;
		}
		
		public function handleCollision(e: Event): void {
			if (sprite.hitTestObject(gameState.leftHand.sprite) && canCollide) {
				touched = true;
				state = BallPosition.LEFT_HAND;
			} else if (sprite.hitTestObject(gameState.rightHand.sprite) && canCollide) {
				touched = true;
				state = BallPosition.RIGHT_HAND;
			} else {
				touched = false;
			}
		}

		public function launch(ballChargeBeginning: int): void {
			canCollide = false;
			state = BallPosition.NONE;

			var timer: Timer = new Timer(500, 1);
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
		
		public function update(): void {
			if (state == BallPosition.LEFT_HAND) {
				sprite.x = gameState.leftHand.sprite.x;
				sprite.y = gameState.leftHand.sprite.y;
			} else if (state == BallPosition.RIGHT_HAND) {
				sprite.x = gameState.rightHand.sprite.x;
				sprite.y = gameState.rightHand.sprite.y - gameState.findBallsInRightHand().indexOf(this) * (0.8 * sprite.height);
			} else {
				if (touched == false) {
					vx *= friction;
					vy *= friction;
				
					vy += gravity;
				
					sprite.x += vx;
					sprite.y += vy;		
				}
			}
		}
	}
}
