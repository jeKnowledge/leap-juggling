package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Bitmap;

	public class Ball {

		public var sprite: Sprite;
		private var gameState: GameState;

		//limits of the window
		private var bounds: Rectangle;
		private var minX: Number;
		private var maxX: Number;
		private var minY: Number;
		private var maxY: Number;

		public var x: Number;
		public var y: Number;
		public var touched: Boolean = false;

		public var vx: Number = 3;
		public var vy: Number = 20;
		private var gravity: Number = 0.96;
		private var friction: Number = 0.98;

		public function Ball(gameState: GameState) {
			this.gameState = gameState;
			setBoundaries();
			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap["test2.png"].bitmapData));
			sprite.x = 550;
			sprite.y = Math.random() * maxY;
			gameState.game.addChild(sprite);
		}

		public function setBoundaries() {
			bounds = new Rectangle(0, 0, gameState.game.stage.width, gameState.game.stage.height);
			trace(bounds);
			minX = 0;
			minY = 0;
			maxX = gameState.game.stage.width;
			maxY = gameState.game.stage.height;
		}

		public function update(): void {
			if(((sprite.x - sprite.width) <= minX) && (vx < 0)) {
				vx = -vx;
			}
			
			if(((sprite.y - sprite.height) <= minY) && (vy < 0)) {
				vy = -vy;
			}
			
			vx*= friction;
			vy*= friction;
			
			vy+=gravity;
			
			sprite.x += vx;
			
			if((sprite.y + vy + (sprite.height)) > maxY) {
				sprite.y = maxY - (sprite.height);
			} else {
				sprite.y += vy;
			}
			//if(sprite.x + sprite.height > minX )
			/*if (vy > 2 && touched == false) {
				sprite.y -= vy;
				vy *= gravity;
				sprite.x += vx;
			} else {
				touched = true;
				sprite.y += vy;
				vy /= gravity;
				sprite.x += vx;
			}*/
		}
	}
}
