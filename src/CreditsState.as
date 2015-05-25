package {

	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.*;

	public class CreditsState extends State {

		public var url: URLRequest;

		public function CreditsState(game: Game) {
			super(game);

			useLeapPointer = true;
		}

		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);

			textFields.createCustomTextField("info", "Game developed by:", 350, 100, 25);
			textFields.createCustomTextField("david_twitter", "@davidrfgomes", 350, 200, 25);
			textFields.createCustomTextField("jb_twitter", "@JBAmaro", 350, 250, 25);
			textFields.createCustomTextField("tiago_twitter", "@TiagoBotelho9", 350, 300, 25);
			textFields.createCustomTextField("back", "Back", 350, 400, 20);
		}

		override public function update(): void {
			if (game.settings.leapMode) {
				game.updateLeapPointer();

				if (game.checkBounds(textFields.getKeyValue("david_twitter")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					url = new URLRequest("https://twitter.com/davidrfgomes");
					navigateToURL(url, "_blank");
				} else if (game.checkBounds(textFields.getKeyValue("jb_twitter")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					url = new URLRequest("https://twitter.com/JBAmaro");
					navigateToURL(url, "_blank");
				} else if (game.checkBounds(textFields.getKeyValue("tiago_twitter")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					url = new URLRequest("https://twitter.com/TiagoBotelho9");
					navigateToURL(url, "_blank");
				} else if (game.checkBounds(textFields.getKeyValue("back")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					this.game.changeState(new MenuState(this.game));
				}

				game.leapMap[LeapPosition.SCREEN_TAP] = false;
			}
		}

		override public function onMouseClick(event: MouseEvent): void {
			if (!game.settings.leapMode) {
				if (event.target == textFields.getKeyValue("david_twitter")) {
					url = new URLRequest("https://twitter.com/davidrfgomes");
					navigateToURL(url, "_blank");
				} else if (event.target == textFields.getKeyValue("jb_twitter")) {
					url = new URLRequest("https://twitter.com/JBAmaro");
					navigateToURL(url, "_blank");
				} else if (event.target == textFields.getKeyValue("tiago_twitter")) {
					url = new URLRequest("https://twitter.com/TiagoBotelho9");
					navigateToURL(url, "_blank");
				} else if (event.target == textFields.getKeyValue("back")) {
					this.game.changeState(new MenuState(this.game));
				}
			}
		}

	}

}