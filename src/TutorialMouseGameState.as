package {

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

	public class TutorialMouseGameState extends GameState {

		private var currentLevel: int = 0;

		public function TutorialMouseGameState(game: Game) {
			super(game);

			// Game Settings
			NUM_BALLS = 1;
			this.name = "tutorial";
		}

		public override function setup(): void {
			super.setup();

			this.textFields.createCustomTextField("tutorial_text", "", 130, 250, 20);
		}

		public override function update(): void {
			currentFrame++;

			// Escape key
			if (game.keyMap[Keyboard.ESCAPE]) {
				game.keyMap[Keyboard.ESCAPE] = false;
				changePaused();
			}

			// Exit key
			if (game.keyMap[Keyboard.Q]) {
				game.changeState(new MenuState(game));
			}

			if (!paused) {
				if (currentLevel == 0) {
					this.textFields.updateCustomTextField("tutorial_text", "Press space to get the first ball to fly\n(the longer you press the higher it gets)");

					if (this.ballsInHand(player.leftHand).length == 1) {
						currentLevel++;
					}
				} else if (currentLevel == 1) {
					this.textFields.updateCustomTextField("tutorial_text", "  Now, click the left mouse button\nto pass the ball to your left hand");

					if (this.ballsInHand(player.rightHand).length == 1) {
						currentLevel++;
					}
				} else if (currentLevel == 2) {
					this.textFields.updateCustomTextField("tutorial_text", "Good job ! Now lets scale it up a bit. \n\n\t\t\t\ttwo balls now! \n\t\tPress enter to continue");

					this.addBalls(1);
					this.resetBallPosition();

					currentLevel++;
				} else if (currentLevel == 3) {
					if (game.keyMap[Keyboard.ENTER]) {
						game.keyMap[Keyboard.ENTER] = false;
						currentLevel++;
					}
				} else if (currentLevel == 4) {
					this.textFields.updateCustomTextField("tutorial_text", " Now try it with three balls and continue \nwhen you feel ready for the real challenge! \n\n\t\t\t\tPress enter to continue", 110);

					this.addBalls(1);
					this.resetBallPosition();

					currentLevel++;
				} else if (currentLevel == 5) {
					if (game.keyMap[Keyboard.ENTER]) {
						game.keyMap[Keyboard.ENTER] = false;
						game.changeState(new GameMenuState(game));
					}
				}

				// Update Player
				player.update();

				// Update Balls
				for each(var ball in balls) {
					ball.update();
				}

				// Check if the player lost
				if (player.lives.length == 0) {
					this.textFields.updateCustomTextField("tutorial_text", "\tUh Oh! You lost all your lives!\nPress Enter to Restart Tutorial.", 170);
					if(game.keyMap[Keyboard.ENTER]) {
						game.keyMap[Keyboard.ENTER] = false;
						game.changeState(new TutorialMouseGameState(this.game));
					}
				}
			}
		}
		
	}
	
}