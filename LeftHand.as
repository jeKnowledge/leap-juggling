package  {
	import flash.display.Sprite;
	import flash.display.Bitmap;

	public class LeftHand {
		private var gameState: GameState;

		public var sprite: Sprite;

		public function LeftHand(gameState: GameState) {
			this.gameState = gameState;

			sprite = new Sprite();
			sprite.addChild(new Bitmap(gameState.game.resourceMap["images/lefthand.png"].bitmapData));

			sprite.x = 400;
			sprite.y = 550;
			gameState.game.addChild(sprite);
		}

	}

}
