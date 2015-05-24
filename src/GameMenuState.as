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
			
			textFields.createCustomTextField("gamemenu-tutorial", "Tutorial", 280, 100);
			textFields.createCustomTextField("gamemenu-endless", "Endless", 280, 200);
			textFields.createCustomTextField("gamemenu-challenge", "Challenge", 280, 300);
			textFields.createCustomTextField("menu", "Back", 350, 500);
			
		}
		
		override public function update(): void {
			game.updateLeapPointer();
			
			if (game.checkBounds(textFields.getKeyValue("gamemenu-tutorial")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				if (game.settings.leapMode) {
					this.game.changeState(new TutorialLeapGameState(this.game));
				} else {
					this.game.changeState(new TutorialMouseGameState(this.game));
				}
			} else if (game.checkBounds(textFields.getKeyValue("gamemenu-endless")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				this.game.changeState(new EndlessGameState(this.game));
			} else if (this.game.checkBounds(textFields.getKeyValue("gamemenu-challenge")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				this.game.changeState(new ChallangeGameState(this.game));
			} else if (this.game.checkBounds(textFields.getKeyValue("menu")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
				game.leapMap[LeapPosition.SCREEN_TAP] = false;
				this.game.changeState(new MenuState(this.game));
			}
		}

	}
	
}
