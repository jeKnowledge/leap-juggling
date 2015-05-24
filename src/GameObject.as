package {

	import flash.events.KeyboardEvent;
	import flash.display.Sprite;

	public class GameObject {

		public var gameState: GameState;
		public var sprite: Sprite;
		public var textFields: CustomTextFields;
		
		public function GameObject(gameState: GameState) {
			this.gameState = gameState;
			this.sprite = new Sprite();
		}

		public function setup(): void { }
		public function update(): void { }

	}

}