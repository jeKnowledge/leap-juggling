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
		protected var NUM_BALLS: int;

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
		public var transitionSound: Sound;

		public function GameState(game: Game) {
			super(game);
		}

		// Reset Ball Position
		public function resetBallPosition(): void {
			for each (var ball in balls) {
				ball.sprite.x = player.rightHand.sprite.x;
				ball.sprite.y = player.rightHand.sprite.y - ballsInHand(player.rightHand).indexOf(ball) * (0.8 * ball.sprite.height);
				ball.state = BallPosition.RIGHT_HAND;
				player.firstLaunch = true;
			}
		}

		// Get balls in passed hand
		public function ballsInHand(hand: GameHand): Vector.<Ball> {
			var ballsInHand: Vector.<Ball> = new Vector.<Ball>();

			for each (var ball in balls) {
				if (ball.state == hand.state) {
					ballsInHand.push(ball);
				}
			}

			return ballsInHand;
		}
		
		public function addBalls(numberOfBalls: int): void {
			NUM_BALLS += numberOfBalls; 
			for (var i: int = 0; i < numberOfBalls; i++) {
				var newBall: Ball = new Ball(this);
				newBall.setup();
				this.balls.push(newBall);
			}
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
			transitionSound = game.resourceMap["sounds/transition.mp3"];
			
			volumeAdjust = new SoundTransform();
			volumeAdjust.volume = game.settings.volume;
			
			gameSound.play(0, 1, volumeAdjust);
		}

		override public function update(): void { }
	}

}
