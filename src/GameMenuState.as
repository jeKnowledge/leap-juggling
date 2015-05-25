package {

	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.engine.TextBaseline;
	import flash.text.TextField;
	import flash.events.*;

	public class GameMenuState extends State {

		public function GameMenuState(game: Game) {
			super(game);

			useLeapPointer = true;
		}

		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);

			textFields.createCustomTextField("gamemenu-tutorial", "Tutorial", 350, 150);
			textFields.createCustomTextField("gamemenu-endless", "Endless", 350, 250);
			textFields.createCustomTextField("gamemenu-challenge", "Challenge", 350, 350);
			textFields.createCustomTextField("back", "Back", 350, 500, 20);
		}

		override public function update(): void {
			if (game.settings.leapMode) {
				game.updateLeapPointer();

				if (game.checkBounds(textFields.getKeyValue("gamemenu-tutorial")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					if (game.settings.leapMode) {
						this.game.changeState(new TutorialLeapGameState(this.game));
					} else {
						this.game.changeState(new TutorialMouseGameState(this.game));
					}
				} else if (game.checkBounds(textFields.getKeyValue("gamemenu-endless")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					this.game.changeState(new EndlessGameState(this.game));
				} else if (game.checkBounds(textFields.getKeyValue("gamemenu-challenge")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					this.game.changeState(new ChallengeGameState(this.game));
				} else if (game.checkBounds(textFields.getKeyValue("back")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					this.game.changeState(new MenuState(this.game));
				}

				game.leapMap[LeapPosition.SCREEN_TAP] = false;
			}
		}

		override public function onMouseClick(event: MouseEvent): void {
			if (!game.settings.leapMode) {
				if (event.target == textFields.getKeyValue("gamemenu-tutorial")) {
					if (game.settings.leapMode) {
						this.game.changeState(new TutorialLeapGameState(this.game));
					} else {
						this.game.changeState(new TutorialMouseGameState(this.game));
					}
				} else if (event.target == textFields.getKeyValue("gamemenu-endless")) {
					this.game.changeState(new EndlessGameState(this.game));
				} else if (event.target == textFields.getKeyValue("gamemenu-challenge")) {
					this.game.changeState(new ChallengeGameState(this.game));
				} else if (event.target == textFields.getKeyValue("back")) {
					this.game.changeState(new MenuState(this.game));
				}
			}
		}

	}

}