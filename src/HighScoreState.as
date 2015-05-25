package  {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Sprite;
	
	public class HighScoreState extends State {
		
		private var highScores: String;
		private var rawHighScores: Object;
		private var url: String;
		private var gameMode: String
		private var lastState: GameOverState;

		public function HighScoreState(game: Game, url: String, gameMode: String, lastState: GameOverState) {
			super(game);
			
			this.useLeapPointer = true;
			
			this.url = url;
			this.gameMode = gameMode;
			this.lastState = lastState;
		}
		
		override public function setup(): void {
			textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("title", gameMode + " HighScores", 200, 100);
			textFields.createCustomTextField("highscores", "", 200, 200, 18);
			textFields.createCustomTextField("menu", "Back", 350, 500, 22);
			
			game.serverCommunicator.getHighScores(url);
		}

		
		override public function update(): void {
			rawHighScores = game.serverCommunicator.highScores;
			
			if (rawHighScores != null && highScores == null) {
				if (rawHighScores.length == 0) {
					highScores = "There are no highscores";
				} else {
					for (var i: int = 0; i < rawHighScores.length; i++) {
						highScores += rawHighScores[i].name + ": " + rawHighScores[i].score + " pts\n";
					}
				}
				
				textFields.updateCustomTextField("highscores", highScores);
			} else if (game.checkBounds(textFields.getKeyValue("menu")) && game.leapMap[LeapPosition.SCREEN_TAP] && game.settings.leapMode) {
					this.game.changeState(lastState);
			}
		}
		
		override public function onMouseClick(event: MouseEvent): void {
			if (!game.settings.leapMode) {
				if (event.target == textFields.getKeyValue("menu")) {
					this.game.changeState(lastState);
				}
			}
		}

	}
	
}
