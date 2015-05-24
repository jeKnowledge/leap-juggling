package {

	import flash.events.KeyboardEvent;
	import flash.events.*;

	public class State {

		public var game: Game;
		public var textFields: CustomTextFields;
		
		public function State(game: Game) {
			this.game = game;
			
			game.stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}

		public function setup(): void { }
		
		public function update(): void { }
		
		public function onMouseClick(event: MouseEvent): void { }
	}

}