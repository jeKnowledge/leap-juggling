package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class OptionsMenuState extends State {
		
		private var leapModeCheckBox: CheckBox;
		
		public function OptionsMenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("leap_mode", "Leap Motion Mode", 145, 100);
			textFields.createCustomTextField("volume", "[U] Volume Up.\n[D] Volume Down", 145, 160);
			textFields.createCustomTextField("menu", "[ESC] Go back to the menu.", 145, 240);
			
			leapModeCheckBox = new CheckBox(this, 100, 100);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.saveSettings();
				this.game.changeState(new MenuState(this.game));
			} else if (game.keyMap[Keyboard.U]) {
				if ((this.game.settings.volume + 0.1) <= 1) {
					this.game.settings.volume += 0.1;
					game.keyMap[Keyboard.U] = false;
				}
			} else if (game.keyMap[Keyboard.D]) {
				if((this.game.settings.volume - 0.1) >= 0) {
					this.game.settings.volume -= 0.1;
					game.keyMap[Keyboard.D] = false;
				}
			}
		}

	}
	
}
