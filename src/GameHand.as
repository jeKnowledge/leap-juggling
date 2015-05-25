package  {
	
	import flash.display.Sprite;
	import flash.display.Bitmap;

	public class GameHand {
		private var gameState: GameState;
		public var state: String;
		
		public var sprite: Sprite;

		public function GameHand(gameState: GameState, xPosition: int, yPosition: int, imageName: String, state: String) {
			this.gameState = gameState;
			this.state = state;

			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap[imageName].bitmapData));
			sprite.x = xPosition;
			sprite.y = yPosition;
			sprite.width = 150;
			sprite.height = 150;
			gameState.game.addChild(sprite);
		}

	}

}
