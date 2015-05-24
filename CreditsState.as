package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class CreditsState extends State {
		
		var myUrlLink: URLRequest;
		
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
			if (game.checkBounds(textFields.getKeyValue("david_twitter")) && this.game.mouseDown) {
				this.game.mouseDown = false;
				this.myUrlLink = new URLRequest("https://twitter.com/davidrfgomes");
				navigateToURL(myUrlLink, "_blank");
			} else if (game.checkBounds(textFields.getKeyValue("jb_twitter")) && this.game.mouseDown) {
				this.game.mouseDown = false;
				this.myUrlLink = new URLRequest("https://twitter.com/JBAmaro");
				navigateToURL(myUrlLink, "_blank");
			} else if (game.checkBounds(textFields.getKeyValue("tiago_twitter")) && this.game.mouseDown) {
				this.game.mouseDown = false;
				this.myUrlLink = new URLRequest("https://twitter.com/TiagoBotelho9");
				navigateToURL(myUrlLink, "_blank");
			} else if (game.checkBounds(textFields.getKeyValue("menu")) && this.game.mouseDown) {
				this.game.mouseDown = false;
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
