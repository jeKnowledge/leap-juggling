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
			introTextField.text = "Press SPACE to move on";
			this.game.addChild(introTextField);
		}
		
		override public function handleKeyDown(event: KeyboardEvent): void {
			if (event.keyCode == Keyboard.SPACE) {
				this.game.changeState(new GameState(this.game));
			}
		}

	}
	
}
