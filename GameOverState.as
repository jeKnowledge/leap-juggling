package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class GameOverState extends State {

		private var introTextField: TextField;
		
		public function GameOverState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			introTextField = new TextField();
			introTextField.x = 400;
			introTextField.y = 400;
			introTextField.width = 800;
			introTextField.defaultTextFormat = new TextFormat('Helvetica', 30, 0x000);
			introTextField.text = "Game Over - Press [ENTER] To Play Again";

			this.game.addChild(introTextField);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ENTER]) {
				this.game.changeState(new GameState(this.game));
			}
		}

	}
	
}
