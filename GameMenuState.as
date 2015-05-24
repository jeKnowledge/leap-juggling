package  {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.engine.TextBaseline;
	import flash.text.TextField;
	
	public class GameMenuState extends State {

		public function GameMenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("gamemenu-tutorial", "[1] Tutorial", 280, 200);
			textFields.createCustomTextField("gamemenu-endless", "[2] Endless", 280, 300);
			textFields.createCustomTextField("gamemenu-challange", "[3] Challenge", 280, 400);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.NUMBER_1]) {
				if (game.settings.leapMode) {
					this.game.changeState(new TutorialLeapGameState(this.game));
				} else {
					this.game.changeState(new TutorialMouseGameState(this.game));
				}
			} else if (game.keyMap[Keyboard.NUMBER_2]) {
				this.game.changeState(new EndlessGameState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_3]) {
				this.game.changeState(new ChallangeGameState(this.game));
			}
		}

	}
	
}
