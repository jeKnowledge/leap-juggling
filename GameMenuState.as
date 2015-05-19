package  {
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.text.engine.TextBaseline;
	import flash.text.TextField;
	
	public class GameMenuState extends State {
		
		private var gameMenuTextField: TextField;

		public function GameMenuState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			gameMenuTextField = new TextField();
			gameMenuTextField.x = 200;
			gameMenuTextField.y = 200;
			gameMenuTextField.width = 800;
			gameMenuTextField.defaultTextFormat = new TextFormat('Helvetica', 30, 0x000);
			gameMenuTextField.text = "[1] Tutorial\n[2] Endless";
			
			this.game.addChild(gameMenuTextField);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.NUMBER_1]) {
				this.game.changeState(new GameState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_2]) {
				this.game.changeState(new GameState(this.game));
			}
		}

	}
	
}
