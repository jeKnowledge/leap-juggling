package  {
	
	import flash.display.Sprite;
	import flash.display.Bitmap;

	public class Hand {
		private var gameState: GameState;
		
		public var sprite: Sprite;

		public function Hand(gameState: GameState, xPosition: int, yPosition: int) {
			this.gameState = gameState;

			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap["images/hand.png"].bitmapData));
			sprite.x = xPosition;
			sprite.y = yPosition;
			gameState.game.addChild(sprite);
		}

	}

}
