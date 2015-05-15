package  {
	import flash.display.Sprite;
	
	public class Ball {

		private var sprite: Sprite;
		private var gameState: GameState;
		
		public var x: Number;
		public var y: Number;

		public var vx: Number;
		public var vy: Number;
		
		public function Ball(gameState: GameState) {
			this.gameState = gameState;
			sprite = new Sprite();
			sprite.addChild(gameState.game.resourceMap["test2.png"]);
			sprite.x = 200;
			sprite.y = 350;
			gameState.game.addChild(sprite);
		}
		
		public function update(): void {
			x += vx;
			y += vy;
		}

	}
	
}
