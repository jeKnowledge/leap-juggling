package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class GameOverState extends State {

		private var score: int;
		private var lastState: State;
		
		public function GameOverState(game: Game, score: int, lastState: State) {
			super(game);
			this.score = score;
			this.lastState = lastState;
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			var text: String = "Game Over\nYou got " + this.score.toString() + " points.\nPress [ENTER] to play again\nPress [ESC] to go back to menu";
			textFields.createCustomTextField("menu", text, 200, 200);
			
			// Send score to server
			game.highScoreSender.sendScore("user", this.score);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ENTER]) {
				this.game.changeState(this.lastState);
			} else if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));	
			}
		}

	}
	
}
