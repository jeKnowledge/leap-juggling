package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class GameOverState extends State {

		private var introTextField: TextField;
		private var finalScore: int;
		
		public function GameOverState(game: Game, finalScore: int) {
			super(game);
			this.finalScore = finalScore;
		}
		
		override public function setup(): void {
			introTextField = new TextField();
			introTextField.x = 200;
			introTextField.y = 200;
			introTextField.width = 800;
			introTextField.defaultTextFormat = new TextFormat('Helvetica', 30, 0x000);
			introTextField.text = "Game Over\nYou got " + this.finalScore.toString() + " points.\nPress [ENTER] to play again\nPress [ESC] to go back to menu";

			this.game.addChild(introTextField);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ENTER]) {
				this.game.changeState(new GameState(this.game));
			} else if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));	
			}
		}

	}
	
}
