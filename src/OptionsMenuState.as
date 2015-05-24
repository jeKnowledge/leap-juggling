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
			game.updateLeapPointer();
			
			if (game.checkBounds(textFields.getKeyValue("menu")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				
				game.changeState(new MenuState(this.game));
			} else if (game.keyMap[Keyboard.U]) {
				game.keyMap[Keyboard.U] = false;
				
				if ((game.settings.volume + 0.1) <= 1) {
					game.settings.volume += 0.1;
					
					game.saveSettings();
					game.updateVolume();
				}
			} else if (game.keyMap[Keyboard.D]) {
				game.keyMap[Keyboard.D] = false;
				
				if((this.game.settings.volume - 0.1) >= 0) {
					this.game.settings.volume -= 0.1;
					
					game.saveSettings();
					game.updateVolume();
				}
			} else if (game.checkBounds(textFields.getKeyValue("leap_mode")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				
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
