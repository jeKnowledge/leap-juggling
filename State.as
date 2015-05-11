package  {

	import flash.events.KeyboardEvent;

	public class State {

		public var game: Game;
		
		public function State(game: Game) {
			this.game = game;
		}

		public function handleKeyDown(event: KeyboardEvent): void { }
		public function update(): void { }

	}

}
