package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class CreditsState extends State {
		
		public var url: URLRequest;
		
		public function CreditsState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("info", "Game developed by:", 250, 100, 25);
			textFields.createCustomTextField("david_twitter", "@davidrfgomes", 250, 200, 25);
			textFields.createCustomTextField("jb_twitter", "@JBAmaro", 250, 250, 25);
			textFields.createCustomTextField("tiago_twitter", "@TiagoBotelho9", 250, 300, 25);
			textFields.createCustomTextField("menu", "Back", 350, 500);
		}
		
		override public function update(): void {
			if (game.checkBounds(textFields.getKeyValue("david_twitter")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				
				url = new URLRequest("https://twitter.com/davidrfgomes");
				navigateToURL(url, "_blank");
			} else if (game.checkBounds(textFields.getKeyValue("jb_twitter")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				
				url = new URLRequest("https://twitter.com/JBAmaro");
				navigateToURL(url, "_blank");
			} else if (game.checkBounds(textFields.getKeyValue("tiago_twitter")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				
				url = new URLRequest("https://twitter.com/TiagoBotelho9");
				navigateToURL(url, "_blank");
			} else if (game.checkBounds(textFields.getKeyValue("menu")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
