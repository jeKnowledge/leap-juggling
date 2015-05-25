package {

	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.*;

	public class GameOverState extends State {

		private var score: int;
		private var lastState: GameState;
		public var inputField: TextField;
		private static var randomNames: Array = ["Tiago", "Jason", "David", "Inês", "Margarida", "João", "Marie", "Alex", "Jordan", "André"];

		public function GameOverState(game: Game, score: int, lastState: GameState) {
			super(game);

			this.score = score;
			this.lastState = lastState;
			
			useLeapPointer = true;
		}

		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);

			textFields.createCustomTextField("game-over", "GAME OVER", 300, 150);
			textFields.createCustomTextField("username", "Enter your username", 190, 200);
			textFields.createCustomTextField("challenge-highscores", "Challenge\nHighScores", 200, 300, 18);
			textFields.createCustomTextField("endless-highscores", "Endless\nHighScores", 500, 300, 18);
			textFields.createCustomTextField("restart", "Restart", 200, 400);
			textFields.createCustomTextField("menu", "Menu", 500, 400);

			// Player name input field
			this.inputField = new TextField();
			this.game.addChild(inputField);
			this.inputField.defaultTextFormat = new TextFormat('pixelmix', 30, 0x000);
			this.inputField.type = TextFieldType.INPUT;
			this.inputField.border = true;
			this.inputField.width = 400;
			this.inputField.height = 40;
			this.inputField.x = 200;
			this.inputField.y = 250;
		}

		// Sends the User score to the Server
		public function sendHighScore(): void {
			if (inputField.text == "") {
				var randomNumber: int = int(randomNames.length * Math.random());
				game.serverCommunicator.sendScore("http://malabarismo.herokuapp.com/new-score", randomNames[randomNumber], score, lastState.name);
			} else {
				game.serverCommunicator.sendScore("http://malabarismo.herokuapp.com/new-score", inputField.text, score, lastState.name);
			}
		}

		override public function update(): void {
			if (game.settings.leapMode) {
				game.updateLeapPointer();

				if (game.checkBounds(textFields.getKeyValue("restart")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					sendHighScore();
					this.game.changeState(this.lastState);
				} else if (game.checkBounds(textFields.getKeyValue("menu")) && game.leapMap[LeapPosition.SCREEN_TAP]) {
					sendHighScore();
					this.game.changeState(new MenuState(this.game));
				}

				game.leapMap[LeapPosition.SCREEN_TAP] = false;
			} else {
				if (game.keyMap[Keyboard.ENTER]) {
					sendHighScore();
					this.game.changeState(new MenuState(this.game));
				}
			}
		}

		override public function onMouseClick(event: MouseEvent): void {
			if (!game.settings.leapMode) {
				if (event.target == textFields.getKeyValue("restart")) {
					sendHighScore();
					this.game.changeState(this.lastState);
				} else if (event.target == textFields.getKeyValue("menu")) {
					sendHighScore();
					this.game.changeState(new MenuState(this.game));
				} else if (event.target == textFields.getKeyValue("challenge-highscores")) {
					this.game.changeState(new HighScoreState(this.game, "http://malabarismo.herokuapp.com/top-challenge", "Challenge"));
				} else if (event.target == textFields.getKeyValue("endless-highscores")) {
					this.game.changeState(new HighScoreState(this.game, "http://malabarismo.herokuapp.com/top-endless", "Endless"));
				}
			}
		}

	}

}