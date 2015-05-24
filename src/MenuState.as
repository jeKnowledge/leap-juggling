package {
	
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Sprite;
	import flash.events.*;
	
	public class MenuState extends State {
		
		public function MenuState(game: Game) {
			super(game);
			
			/*
				This is the first function called after the LoadingState. Global resources
				should be loaded here.
			*/
		}
		
		override public function setup(): void {
			this.textFields = new CustomTextFields(this.game);
			
			textFields.createCustomTextField("menu-play", "Play", 280, 200);
			textFields.createCustomTextField("menu-options", "Options", 280, 300);
			textFields.createCustomTextField("menu-credits", "Credits", 280, 400);
			
			game.updateVolume();
			
			// Background Image
			game.backgroundImage = new Sprite();
			game.backgroundImage.addChild(game.resourceMap["assets/images/background_image.png"]);
			game.backgroundImage.width = game.stage.stageWidth;
			game.backgroundImage.height = game.stage.stageHeight;
			game.addChild(game.backgroundImage);
			game.setChildIndex(game.backgroundImage, 0);
		}

		override public function onMouseClick(event: MouseEvent): void {
			if (event.target == textFields.getKeyValue("menu-play")) {
				this.game.changeState(new GameMenuState(this.game));
			} else if (event.target == textFields.getKeyValue("menu-options")) {
				this.game.changeState(new OptionsMenuState(this.game));
			} else if (event.target == textFields.getKeyValue("menu-credits")) {
				this.game.changeState(new CreditsState(this.game));
			}
		}
		
	}
	
}
