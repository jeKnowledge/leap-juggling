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

	public class GameState extends State {
		
		// Game Settings
		private var NUM_BALLS: int;

		// Player
		public var player: Player;
		
		// Balls
		public var ballChargeBeginning: int;
		public var ballCharging: Boolean = false;
		public var balls: Vector.<Ball>;
		
		// Aux Variables
		public var currentFrame: int;

		// Sounds
		public var launchSound: Sound;
		public var gameSound: Sound;
		public var volumeAdjust: SoundTransform;
		
		public function GameState(game: Game) {
			super(game);
		}
		
		public function resetBallPosition(): void {
			for each (var ball in balls) {
				ball.sprite.x = player.rightHand.sprite.x;
				ball.sprite.y = player.rightHand.sprite.y - player.findBallsInRightHand().indexOf(ball) * (0.8 * ball.sprite.height);
				ball.state = BallPosition.RIGHT_HAND;
			}
		}
		
		override public function setup(): void { }
				
		override public function update(): void { }
	}

}
