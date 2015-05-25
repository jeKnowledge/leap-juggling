package {

	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Sprite;

	public class OptionsMenuState extends State {

		private var leapModeCheckBox: CheckBox;
		public var soundUp: Sprite;
		public var soundDown: Sprite;

		public function OptionsMenuState(game: Game) {
			super(game);

			useLeapPointer = true;
		}

		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);

			textFields.createCustomTextField("leap_mode", "Leap Motion Mode", 350, 100, 25);
			textFields.createCustomTextField("volume-index", "Volume", 350, 250, 25);
			textFields.createCustomTextField("volume", int(game.settings.volume * 100).toString() + "%" , 470, 250, 25);
			textFields.createCustomTextField("back", "Back", 350, 400, 20);
			
			soundUp = new Sprite();
			soundUp.addChild(game.resourceMap["assets/images/uparrow.png"]);
			soundUp.x = 500;
			soundUp.y = 200;
			soundUp.width = 40;
			soundUp.height = 40;
			game.addChild(soundUp);
			
			soundDown = new Sprite();
			soundDown.addChild(game.resourceMap["assets/images/downarrow.png"]);
			soundDown.x = 500;
			soundDown.y = 300;
			soundDown.width = 40;
			soundDown.height = 40;
			game.addChild(soundDown);

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
			} else if (game.checkBounds(soundUp) && game.leapMap[LeapPosition.SCREEN_TAP]) {

				if ((game.settings.volume + 0.1) <= 1) {
					game.settings.volume += 0.1;
					textFields.updateCustomTextField("volume", int(game.settings.volume * 100).toString() + "%");
					game.saveSettings();
					game.updateVolume();
				}
			} else if (game.checkBounds(soundDown) && game.leapMap[LeapPosition.SCREEN_TAP]) {

				if ((this.game.settings.volume - 0.1) >= 0) {
					this.game.settings.volume -= 0.1;
					textFields.updateCustomTextField("volume", int(game.settings.volume * 100).toString() + "%");
					game.saveSettings();
					game.updateVolume();
				}
			}
			game.leapMap[LeapPosition.SCREEN_TAP] = false;
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
				} else if (event.target == soundUp) {
					if ((game.settings.volume + 0.1) <= 1) {
						game.settings.volume += 0.1;
						textFields.updateCustomTextField("volume", int(game.settings.volume * 100).toString() + "%");
						game.saveSettings();
						game.updateVolume();
					}	
				} else if (event.target == soundDown) {
					if ((this.game.settings.volume - 0.1) >= 0) {
						this.game.settings.volume -= 0.1;
						textFields.updateCustomTextField("volume", int(game.settings.volume * 100).toString() + "%");
						game.saveSettings();
						game.updateVolume();
					}
				}
			}
		}

	}

}