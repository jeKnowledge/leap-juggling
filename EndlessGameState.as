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
	
	public class EndlessGameState extends GameState {
		
		public function EndlessGameState(game: Game) {
			super(game);
			
			// Game Settings
			NUM_BALLS = 4;
		}

		public override function setup(): void {
			super.setup();
		}
		
		public override function update(): void {
			currentFrame ++;
			
			if (game.keyMap[Keyboard.R]) {
				game.highScoreSender.sendScore("manel", 12);
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
