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
	
	public class TutorialLeapGameState extends GameState {
		
		private var currentLevel: int = 0;

		public function TutorialLeapGameState(game: Game) {
			super(game);
			
			// Game settings
			NUM_BALLS = 1;
		}
		
		public override function setup(): void {
			super.setup();
			
			this.textFields = new CustomTextFields(this.game);
			this.textFields.createCustomTextField("tutorial_text", "", 20, 80, 18);
		}
		
		public override function update(): void {
			currentFrame ++;
			
			if (currentLevel == 0) {
				this.textFields.updateCustomTextField("tutorial_text", "Make a tapping movement with the left hand to get the \nfirst ball flying");
				
				// FIX: Image missing
				
				if (this.ballsInHand(player.leftHand).length == 1) { currentLevel++; }
			} else if (currentLevel == 1) {
				this.textFields.updateCustomTextField("tutorial_text", "Now, make a tapping movemnt with right hand to pass \nthe ball to your left hand");
				
				// FIX: Image Missing
				
				if (this.ballsInHand(player.rightHand).length == 1) { currentLevel++;}
			} else if (currentLevel == 2) {
				this.textFields.updateCustomTextField("tutorial_text", "Good job ! Now lets scale it up a bit.\n2 balls now !\n Do the same gestures to play");
				
				this.addBalls(1);
				this.resetBallPosition();
				
				currentLevel++;
			} else if (currentLevel == 3) {
				if(game.leapMap[LeapPosition.SCREEN_TAP]) {
					game.leapMap[LeapPosition.SCREEN_TAP] = false;
					currentLevel++;
				}
			} else if (currentLevel == 4) {
				this.textFields.updateCustomTextField("tutorial_text", "Now try it with three balls and continue when \nyou feel ready for the real challenge !\n Do a screen tap gesture to continue");
				
				this.addBalls(1);
				this.resetBallPosition();
				
				currentLevel++;
			} else if (currentLevel == 5) {
				if (game.leapMap[LeapPosition.SCREEN_TAP]) {
					game.leapMap[LeapPosition.SCREEN_TAP] = false;
					game.changeState(new GameMenuState(game));
				}
			}
			
			// Aux key
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
	
