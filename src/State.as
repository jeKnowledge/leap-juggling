package {

	import flash.events.KeyboardEvent;

	public class State {

		public var game: Game;
		public var textFields: CustomTextFields;
		
		public function State(game: Game) {
			this.game = game;
		}

		public function setup(): void { }
		public function update(): void { }
		public function onMouseClick(): void { }

	}

}