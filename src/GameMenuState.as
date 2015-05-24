package  {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.engine.TextBaseline;
	import flash.text.TextField;
	import flash.events.*;
	
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
		
		override public function onMouseClick(event: MouseEvent): void {
			if (event.target == textFields.getKeyValue("gamemenu-tutorial")) {
				if (game.settings.leapMode) {
					this.game.changeState(new TutorialLeapGameState(this.game));
				} else {
					this.game.changeState(new TutorialMouseGameState(this.game));
				}
			} else if (event.target == textFields.getKeyValue("gamemenu-endless")) {
				this.game.changeState(new EndlessGameState(this.game));
			} else if (event.target == textFields.getKeyValue("gamemenu-challenge")) {
				this.game.changeState(new ChallangeGameState(this.game));
			} else if (event.target == textFields.getKeyValue("menu")) {
				this.game.changeState(new MenuState(this.game));
			}
		}
	}
	
}
