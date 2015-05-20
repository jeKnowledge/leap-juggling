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
			
			textFields.createCustomTextField("menu", "Game developed by:\n@davidrfgomes \n@JBAmaro \n@TiagoBotelho9 \n[ESC] Go back to the menu.", 200, 200, 25);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
