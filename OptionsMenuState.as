﻿package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class OptionsMenuState extends State {

		private var introTextField: TextField;
		
		public function OptionsMenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("menu", "[ESC] Go back to the menu.", 200, 200);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.ESCAPE]) {
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
