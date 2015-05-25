package {

	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Sprite;

	public class OptionsMenuState extends State {

		private var leapModeCheckBox: CheckBox;

		public function OptionsMenuState(game: Game) {
			super(game);

			useLeapPointer = true;
		}

		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);

			textFields.createCustomTextField("leap_mode", "Leap Motion Mode", 350, 100, 25);
			textFields.createCustomTextField("volume_up", "Press U to higher the volume", 350, 150, 25);
			textFields.createCustomTextField("volume_down", "Press D to lower the volume", 350, 200, 25);
			textFields.createCustomTextField("back", "Back", 350, 400, 20);

			leapModeCheckBox = new CheckBox(this, 560, 100, game.settings.leapMode);
		}

		override public function update(): void {
			if (game.settings.leapMode) {
				game.updateLeapPointer();

				if (game.checkBounds(textFields.getKeyValue("back")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					game.changeState(new MenuState(this.game));
				} else if ((game.checkBounds(textFields.getKeyValue("leap_mode")) || game.checkBounds(leapModeCheckBox.sprite)) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					leapModeCheckBox.check();

					if (game.settings.leapMode) {
						game.settings.leapMode = false;
						game.removeChild(game.pointer);
					} else {
						game.settings.leapMode = true;
					}

					game.saveSettings();
				}

				game.leapMap[LeapPosition.SCREEN_TAP] = false;
			}

			if (game.keyMap[Keyboard.U]) {
				game.keyMap[Keyboard.U] = false;

				if ((game.settings.volume + 0.1) <= 1) {
					game.settings.volume += 0.1;

					game.saveSettings();
					game.updateVolume();
				}
			} else if (game.keyMap[Keyboard.D]) {
				game.keyMap[Keyboard.D] = false;

				if ((this.game.settings.volume - 0.1) >= 0) {
					this.game.settings.volume -= 0.1;

					game.saveSettings();
					game.updateVolume();
				}
			}
		}

		override public function onMouseClick(event: MouseEvent): void {
			if (!game.settings.leapMode) {
				if (event.target == textFields.getKeyValue("back")) {
					game.changeState(new MenuState(this.game));
				} else if (event.target == textFields.getKeyValue("leap_mode") || event.target == leapModeCheckBox.sprite) {
					leapModeCheckBox.check();
					if (game.settings.leapMode) {
						game.settings.leapMode = false;
						game.removeChild(game.pointer);
					} else {
						game.settings.leapMode = true;

						game.pointer = new Sprite();
						game.pointer.addChild(game.resourceMap["assets/images/point.png"]);
						game.addChild(game.pointer);
					}

					game.saveSettings();
				}
			}
		}

	}

}