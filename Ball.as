package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;	
	
	public class Ball {
		private var gameState: GameState;
		public var sprite: Sprite;
		
		public var state: String = BallPosition.NONE;

		// Limits of the window
		private var bounds: Rectangle;
		private var minX: Number;
		private var maxX: Number;
		private var minY: Number;
		private var maxY: Number;

		public var x: Number;
		public var y: Number;
		public var touched: Boolean = false;

		public var vx: Number = 10;
		public var vy: Number;
		private var gravity: Number = 0.96;
		private var friction: Number = 0.98;

		public function Ball(gameState: GameState, force: int) {
			this.gameState = gameState;

			setBoundaries();
			
			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap["images/ball.png"].bitmapData));
			sprite.x = 200;
			sprite.y = 300;                      
			gameState.game.addChild(sprite);        
			
			sprite.hitTestObject(gameState.leftHand.sprite);
			sprite.addEventListener(Event.ENTER_FRAME, handleCollision);
			
			vy = -(force * 2);
		}
		
		public function handleCollision(e: Event): void {
			if (sprite.hitTestObject(gameState.leftHand.sprite)) {
				touched = true;
				state = BallPosition.LEFT_HAND;
			} else {
				touched = false;
			}
		}

		public function setBoundaries() {
			bounds = new Rectangle(0, 0, gameState.game.stage.width, gameState.game.stage.height);

			minX = 0;
			minY = 0;
			maxX = gameState.game.stage.width;
			maxY = gameState.game.stage.height;
		}

		public function update(): void {
			if (state == BallPosition.LEFT_HAND) {
				sprite.x = gameState.leftHand.sprite.x;
				sprite.y = gameState.leftHand.sprite.y;
			} else if (state == BallPosition.RIGHT_HAND) {
				sprite.x = gameState.rightHand.sprite.x;
				sprite.y = gameState.rightHand.sprite.y;
			} else {
				if (touched == false) {
					if ((sprite.x - sprite.width <= minX) && vx < 0) {
						vx = -vx;
					}
				
					if ((sprite.y - sprite.height <= minY) && vy < 0) {
						vy = -vy;
					}
				
					vx *= friction;
					vy *= friction;
				
					vy += gravity;
				
					sprite.x += vx;
				
					if (sprite.y + vy + sprite.height > maxY) {
						sprite.y = maxY - sprite.height;
					} else {
						sprite.y += vy;
					}
				}
			}
		}
	}
}
