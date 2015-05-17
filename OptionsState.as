package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class OptionsState extends State {

		private var introTextField: TextField;
		
		public function OptionsState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			introTextField = new TextField();
			introTextField.width = 200;
			introTextField.text = "Press ESC to go back to the menu.";
			this.game.addChild(introTextField);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
