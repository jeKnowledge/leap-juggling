package  {
	
	import flash.display.Sprite;
	import flash.display.Bitmap;

	public class Hand {
		private var gameState: GameState;
		
		public var sprite: Sprite;

		public function Hand(gameState: GameState, xPosition: int, yPosition: int, imageName: String) {
			this.gameState = gameState;

			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap[imageName].bitmapData));
			sprite.x = xPosition;
			sprite.y = yPosition;
			gameState.game.addChild(sprite);
		}

	}

}
