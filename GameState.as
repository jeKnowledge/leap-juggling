package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;

	public class GameState extends State {
		
		// Game Settings
		private static const NUM_BALLS: int = 6;

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
		
		public function GameState(game: Game) {
			super(game);
		}
		
		override public function setup(): void {
			// Player
			player = new Player(this);
			player.setup();

			// Ball Sprites
			balls = new Vector.<Ball>();
			for (var i: int = 0; i < NUM_BALLS; i++) {
				var newBall: Ball = new Ball(this);
				newBall.setup();
				balls.push(newBall);
			}

			// Sounds
			launchSound = game.resourceMap["sounds/launch.mp3"];
			gameSound = game.resourceMap["sounds/circus.mp3"];
			
			var volumeAdjust:SoundTransform = new SoundTransform();
			volumeAdjust.volume = .5;
			
			gameSound.play(0, 1, volumeAdjust);
		}
		
		public function resetBallPosition(): void {
			for each (var ball in balls) {
				ball.sprite.x = player.rightHand.sprite.x;
				ball.sprite.y = player.rightHand.sprite.y - player.findBallsInRightHand().indexOf(ball) * (0.8 * ball.sprite.height);
				ball.state = BallPosition.RIGHT_HAND;
			}
		}
				
		override public function update(): void {
			currentFrame ++;
			
			// Restart and escape keys
			if (game.keyMap[Keyboard.R]) {
				game.changeState(new GameState(game));
			}
			
			if (game.keyMap[Keyboard.ESCAPE]) {
				game.changeState(new MenuState(game));
			}
			
			player.update();
			
			// Update Balls
			for each (var ball in balls) {
				ball.update();
			}
			
			// Check if game is lost
			if (player.lives.length == 0) {
				game.changeState(new GameOverState(game));
			}
		}

	}

}
