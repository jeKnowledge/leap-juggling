package  {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.display.Sprite;
	
	public class HighScoreState extends State {
		
		public var highScoresString: String;
		public var highScores: Object;
		public var url: String;
		public var gameMode: String

		public function HighScoreState(game: Game, url: String, gameMode: String) {
			super(game);
			this.url = url;
			this.gameMode = gameMode;
			this.useLeapPointer = true;
		}
		
		override public function setup(): void {
			textFields = new CustomTextFields(this.game);

			game.serverCommunicator.getHighScores(url);
			
			textFields.createCustomTextField("title", gameMode + " HighScores", 200, 100);
			textFields.createCustomTextField("highscores", "", 200, 200, 18);
			textFields.createCustomTextField("menu", "Back", 350, 500, 22);
		}

		
		override public function update(): void {
			this.highScores = game.serverCommunicator.highScores;
			if (this.highScores != null && highScoresString == null) {
				if (this.highScores.length == 0) {
					highScoresString = "There are no highscores";
				} else {
					for (var i: int = 0; i < this.highScores.length; i++) {
						highScoresString += highScores[i].name + ": " + highScores[i].score + " pts" + "\n";
					}
				}
				textFields.updateCustomTextField("highscores", highScoresString);
			} else if (game.checkBounds(textFields.getKeyValue("menu")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					this.game.changeState(new GameMenuState(this.game));
			}
		}
		
		override public function onMouseClick(event: MouseEvent): void {
			if (!game.settings.leapMode) {
				if (event.target == textFields.getKeyValue("menu")) {
					this.game.changeState(new GameMenuState(this.game));
				}
			}
		}

	}
	
}
