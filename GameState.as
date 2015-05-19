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
		public static const NUM_BALLS: int = 3;

		// Player
		public var player: Player;
		
		// Balls
		private var ballChargeBeginning: int;
		private var ballCharging: Boolean = false;
		public var balls: Vector.<Ball>;
		
		// Lives
		public var lives: Vector.<Sprite>;
		
		// Aux Variables
		public var currentFrame: int;

		// Sounds
		private var launchSound: Sound;
		private var gameSound: Sound;
		
		public function GameState(game: Game) {
			super(game);

			balls = new Vector.<Ball>();
			lives = new Vector.<Sprite>();
		}
		
		override public function setup(): void {
			// Player
			player = new Player(this);
			player.setup();
			
			// Lives Sprites
			for(var i: Number = 0; i < 5; i++) {
				var live: Sprite = new Sprite();
				live.addChild(new Bitmap(this.game.resourceMap["images/heart.png"].bitmapData));
				live.x = (i + 1) * 20;
				live.y = 10;
				this.game.addChild(live);
				lives.push(live);
			}

			// Ball Sprites
			for (i = 0; i < NUM_BALLS; i++) {
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
		
		public function decreaseLives(): void {
			var live: Sprite = lives.pop();
			this.game.removeChild(live);
		}

		public function launchBall(): void {
			var ballsInRightHand: Vector.<Ball> = findBallsInRightHand();
			
			if (ballsInRightHand.length > 0) {
				var ballToLaunch: Ball = ballsInRightHand[0];
	
				for each (var ball in ballsInRightHand) {
					if (ball.sprite.y < ballToLaunch.sprite.y) {
						ballToLaunch = ball;
					}
				}

				ballToLaunch.launch(ballChargeBeginning);
			}
		}
		
		public function resetBallPosition(): void {
			for each (var ball in balls) {
				ball.sprite.x = player.rightHand.sprite.x;
				ball.sprite.y = player.rightHand.sprite.y - this.findBallsInRightHand().indexOf(ball) * (0.8 * ball.sprite.height);
				ball.state = BallPosition.RIGHT_HAND;
			}
		}
		
		private function findFirstBallInLeftHand(): Ball {
			for each (var ball in balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					return ball;
				}
			}
			
			return null;
		}
		
		public function findBallsInLeftHand(): Vector.<Ball> {
			var ballsInLeftHand: Vector.<Ball> = new Vector.<Ball>();
			
			for each (var ball in balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					ballsInLeftHand.push(ball);
				}
			}
			
			return ballsInLeftHand;
		}
		
		public function findBallsInRightHand(): Vector.<Ball> {
			var ballsInRightHand: Vector.<Ball> = new Vector.<Ball>();
			
			for each (var ball in balls) {
				if (ball.state == BallPosition.RIGHT_HAND) {
					ballsInRightHand.push(ball);
				}
			}
			
			return ballsInRightHand;
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

			// Mouse Track Left Hand
			player.leftHand.sprite.x = game.mouse.x;
			if (game.mouse.x <= 550 && game.mouse.x >= 350) {
				player.leftHand.sprite.x = game.mouse.x; 
			}
			
			// Mouse Click
			if (game.mouse.down) {
				if (balls.length > 0) {
					var ballInLeftHand: Ball = findFirstBallInLeftHand();
					
					if (ballInLeftHand) {
						ballInLeftHand.canCollide = false;
						ballInLeftHand.vy = -10;
						ballInLeftHand.vx = -0.05 * (player.leftHand.sprite.x - player.rightHand.sprite.x);
						ballInLeftHand.state = BallPosition.NONE;

						var timer: Timer = new Timer(200, 1);
						timer.addEventListener("timer", ballInLeftHand.updateCanCollide);
						timer.start();
					}
				}
			}

			// Space Bar Click			
			if (game.keyMap[Keyboard.SPACE]) {
				if (!ballCharging) {
					ballChargeBeginning = currentFrame;
					ballCharging = true;
				}
			} else {
				if (ballCharging) {
					launchSound.play();
					launchBall();
					ballCharging = false;
				}
			}
			
			// Update Balls
			for each (var ball in balls) {
				ball.update();
			}
			
			// Check if should lose a live
			if (findBallsInLeftHand().length > 1) {
				resetBallPosition();
				decreaseLives();
			}
			
			// Check if game is lost
			if (lives.length == 0) {
				game.changeState(new GameOverState(game));
			}
		}

	}

}
