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
	
	public class ChallangeGameState extends GameState {
		
		// Game Settings
		private var NUM_BALLS: int = 5;
		
		public function ChallangeGameState(game: Game) {
			super(game);
		}
		
		public override function setup(): void {
			player = new Player(this);
			player.setup();
		}
		
		public override function update(): void {
			currentFrame ++;
			
			// Restart and escape keys
			if (game.keyMap[Keyboard.R]) {
				game.changeState(new GameState(game));
			}
			
			if (game.keyMap[Keyboard.ESCAPE]) {
				game.changeState(new MenuState(game));
			}
			
			// Update Player
			player.update();
		}

	}
	
}
