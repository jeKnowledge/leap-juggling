package {

	import flash.events.KeyboardEvent;
	import flash.events.*;

	public class State {
		
		public var game: Game;
		public var textFields: CustomTextFields;
		
		public var useLeapPointer: Boolean;
		
		public function State(game: Game) {
			this.game = game;
			
			this.useLeapPointer = false;
			
			game.stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}

		public function setup(): void { }
		
		public function update(): void { }
		
		public function onMouseClick(event: MouseEvent): void { }
		
	}

}