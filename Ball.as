package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;

	public class Ball {

		private var sprite: Sprite;
		private var gameState: GameState;
		private var canvas: DisplayObjectContainer;

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

		public function Ball(gameState: GameState) {
			this.gameState = gameState;
			sprite = new Sprite();
			sprite.addChild(gameState.game.resourceMap["test2.png"]);
			sprite.x = 50;
			sprite.y = 600;
			gameState.game.addChild(sprite);
		}

		public function beginBallAction(): void {
			sprite.addEventListener(Event.ENTER_FRAME, update);
		}

		public function setBoundries() {

		}

		public function update(e: Event): void {
			trace(gameState.game.stage.width);
			if(vy > 2 && touched == false) {
				sprite.y -= vy;
				vy*=gravity;
				sprite.x += vx;
				trace(sprite.x);
			} else {
				touched = true;
				sprite.y += vy;
				vy/=gravity;
				sprite.x += vx;
			}
		}
	}
}
