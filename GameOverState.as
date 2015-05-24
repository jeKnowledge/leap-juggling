package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class GameOverState extends State {

		private var score: int;
		private var lastState: State;
		public var inputField: TextField;
		private static var randomNames: Array = ["Tiago", "Jason", "David", "Inês", "Margarida", "joão", "Marie", "Alex", "Jordan", "André"];
		
		public function GameOverState(game: Game, score: int, lastState: State) {
			super(game);
			this.score = score;
			this.lastState = lastState;
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
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
					
			textFields.createCustomTextField("game-over", "GAME OVER", 300, 150);
			textFields.createCustomTextField("username", "Enter your Username", 190, 200);
			textFields.createCustomTextField("restart", "Restart", 200, 400);
			textFields.createCustomTextField("menu", "Menu", 500, 400);
		}
		
		// Sends the User score to the Server
		public function sendHighScore(): void {
			if(inputField.text == "") {
				var randomNumber: int = int(randomNames.length * Math.random());
				game.highScoreSender.sendScore(randomNames[randomNumber], score);
			} else {
				game.highScoreSender.sendScore(inputField.text, score);
			}
		}
		
		override public function update(): void {
			if (game.checkBounds(textFields.getKeyValue("restart")) && game.mouseDown) {
				game.mouseDown = false;
				
				sendHighScore();
				this.game.changeState(this.lastState);
			} else if (game.checkBounds(textFields.getKeyValue("menu")) && game.mouseDown) {
				game.mouseDown = false;
				
				sendHighScore();
				this.game.changeState(new MenuState(this.game));	
			}
		}

	}
	
}
