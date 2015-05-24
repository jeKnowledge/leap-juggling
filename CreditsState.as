package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class CreditsState extends State {
		
		public function CreditsState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("info", "Game developed by:\n@davidrfgomes \n@JBAmaro \n@TiagoBotelho9", 250, 200, 25);
			textFields.createCustomTextField("menu", "Back", 350, 500);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
