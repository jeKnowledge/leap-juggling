﻿package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class MenuState extends State {

		private var introTextField: TextField;
		
		public function MenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			introTextField = new TextField();
			introTextField.x = 400;
			introTextField.y = 400;
			introTextField.width = 800;
			introTextField.defaultTextFormat = new TextFormat('Arial', 30, 0x000);
			introTextField.text = "Press 1 for Game \nPress 2 for Options";

			this.game.addChild(introTextField);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.NUMBER_1]) {
				this.game.changeState(new GameState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_2]) {
				this.game.changeState(new OptionsState(this.game));
			}
		}

	}
	
}
