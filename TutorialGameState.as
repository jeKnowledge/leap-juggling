package  {
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	public class TutorialGameState extends GameState {
		
		private var currentLevel: Number = 0;
		
		public function TutorialGameState(game: Game) {
			super(game);

			// Game Settings
			NUM_BALLS = 1;
		}
		
		public override function setup(): void {
			super.setup();
			
			this.textFields = new CustomTextFields(this.game);
			this.textFields.createCustomTextField("tutorial_text", "", 0, 100);
		}
		
		public override function update(): void {
			currentFrame ++;
			
			if (currentLevel == 0) {
				this.textFields.updateCustomTextField("tutorial_text", "Press Space key to send the ball flying !");
				if (this.ballsInHand(player.leftHand).length == 1) {
					currentLevel++;
				}
			} else if (currentLevel == 1) {
				this.textFields.updateCustomTextField("tutorial_text", "Click the left mouse button to pass \n\tthe ball to your right hand");
				if (this.ballsInHand(player.rightHand).length == 1) {
					currentLevel++;
				}
			} else if (currentLevel == 2) {
				this.textFields.updateCustomTextField("tutorial_text", "Good Job now lets scale it up a bit!\n\t\t\t2 balls now!");
				this.addBalls(1);
				this.resetBallPosition();
				currentLevel++;
			} else if (currentLevel == 3) {
				if(game.keyMap[Keyboard.ENTER]) {
					currentLevel++;
					game.keyMap[Keyboard.ENTER] = false;
				}
			} else if (currentLevel == 4) {
				this.textFields.updateCustomTextField("tutorial_text", "Now try it with three balls and continue when \n\tyou feel ready for the real challenge!");
				this.addBalls(1);
				this.resetBallPosition();
				currentLevel++;
			} else if (currentLevel == 5) {
				if (game.keyMap[Keyboard.ENTER]) {
					game.keyMap[Keyboard.ENTER] = false;
					game.changeState(new GameMenuState(game));
				}
			}
			
			// Escape key
			if (game.keyMap[Keyboard.ESCAPE]) {
				game.changeState(new MenuState(game));
			}
			
			// Update Player
			player.update();
			
			// Update Balls
			for each (var ball in balls) {
				ball.update();
			}
			
			// Check if the player lost
			if (player.lives.length == 0) {
				game.changeState(new GameOverState(game, player.score, this));
			}
		}

	}
	
}
