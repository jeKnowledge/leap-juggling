package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class MenuState extends State {
		
		public function MenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("menu", "[1] Play \n[2] Options\n[3] Credits", 200, 200);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.NUMBER_1]) {
				this.game.changeState(new GameMenuState(this.game));
				game.keyMap[Keyboard.NUMBER_1] = false;
				game.keyMap[Keyboard.NUMBER_2] = false;
			} else if (game.keyMap[Keyboard.NUMBER_2]) {
				this.game.changeState(new OptionsMenuState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_3]) {
				this.game.changeState(new CreditsState(this.game));
			}
		}

	}
	
}
