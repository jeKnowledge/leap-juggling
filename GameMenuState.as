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
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("menu", "[1] Tutorial\n[2] Endless\n[3] Challenge", 200, 200);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.NUMBER_1]) {
				this.game.changeState(new TutorialGameState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_2]) {
				this.game.changeState(new NormalGameState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_3]) {
				this.game.changeState(new ChallangeGameState(this.game));
			}
		}

	}
	
}
