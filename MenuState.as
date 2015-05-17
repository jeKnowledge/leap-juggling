package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class MenuState extends State {

		private var introTextField: TextField;
		
		public function MenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			introTextField = new TextField();
			introTextField.text = "Press ENTER to move on";
			this.game.addChild(introTextField);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ENTER]) {
				this.game.changeState(new GameState(this.game));
			}

		}

	}
	
}
