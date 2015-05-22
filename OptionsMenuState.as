package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class OptionsMenuState extends State {
		
		public function OptionsMenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("menu", "[ESC] Go back to the menu.\n[U] Volume Up.\n[D] Volume Down", 200, 200);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));
			} else if (game.keyMap[Keyboard.U]) {
				if (this.game.settings.volume < 1) {
					this.game.settings.volume += 0.1;
					trace(this.game.settings.volume);
					game.keyMap[Keyboard.U] = false;
				}
			} else if (game.keyMap[Keyboard.D]) {
				if(this.game.settings.volume > 0) {
					this.game.settings.volume -= 0.1;
					trace(this.game.settings.volume);
					game.keyMap[Keyboard.D] = false;
				}
			}
		}

	}
	
}
