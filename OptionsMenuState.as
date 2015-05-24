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
			textFields.createCustomTextField("volume", "[U] Volume Up\n[D] Volume Down", 145, 160);
			textFields.createCustomTextField("menu", "Back", 350, 500);
			
			leapModeCheckBox = new CheckBox(this, 500, 105, game.settings.leapMode);
		}
		
		override public function update(): void {
			if (game.checkBounds(textFields.getKeyValue("menu")) && game.mouseDown) {
				game.mouseDown = false;
				
				game.changeState(new MenuState(this.game));
			} else if (game.keyMap[Keyboard.U]) {
				if ((game.settings.volume + 0.1) <= 1) {
					game.settings.volume += 0.1;
					game.keyMap[Keyboard.U] = false;
					game.saveSettings();
				}
			} else if (game.keyMap[Keyboard.D]) {
				if((this.game.settings.volume - 0.1) >= 0) {
					this.game.settings.volume -= 0.1;
					game.keyMap[Keyboard.D] = false;
					game.saveSettings();
				}
			} else if ((game.checkBounds(textFields.getKeyValue("leap_mode")) || game.checkBounds(leapModeCheckBox.sprite)) && game.mouseDown) {
				game.mouseDown = false;
				
				leapModeCheckBox.check();
				if (game.settings.leapMode) {
					game.settings.leapMode = false;
				} else {
					game.settings.leapMode = true;
				}
				
				game.saveSettings();
			}
		}

	}
	
}
