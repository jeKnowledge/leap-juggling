package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Sprite;
	
	public class MenuState extends State {
		
		public function MenuState(game: Game) {
			super(game);
			
			/*
				This is the first function called after the LoadingState. Global resources
				should be loaded here.
			*/

			// Background Image
			game.backgroundImage = new Sprite();
			game.backgroundImage.addChild(game.resourceMap["images/background_image.png"]);
			game.addChild(game.backgroundImage);
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("menu-play", "[1] Play", 200, 200);
			textFields.createCustomTextField("menu-options", "[2] Options", 200, 300);
			textFields.createCustomTextField("menu-credits", "[3] Credits", 200, 400);
		}
		
		override public function update(): void {
			if (game.keyMap[Keyboard.NUMBER_1]) {
				this.game.changeState(new GameMenuState(this.game));
				game.keyMap[Keyboard.NUMBER_1] = false;
				game.keyMap[Keyboard.NUMBER_2] = false;
			} else if (game.keyMap[Keyboard.NUMBER_2]) {
				this.game.changeState(new OptionsMenuState(this.game));
			} else if (game.keyMap[Keyboard.NUMBER_3]) {
				this.game.changeState(new CreditsState(this.game));
			}
		}

	}
	
}
