﻿package {

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

		private var scoreTextField: TextField;
		public var timer: Timer;
		
		private var player: Sprite;
		public var currentFrame: int;
		private var playerSpeed: int = 10;
		
		public var leftHand: Hand;
		public var rightHand: Hand;
		
		private var ballChargeBeginning: int;
		private var ballCharging: Boolean = false;
		public var balls: Vector.<Ball>;
		public var lives: Vector.<Sprite>;
		
		private var launchSound: Sound;
		private var gameSound: Sound;
		
		public function GameState(game: Game) {
			super(game);

			balls = new Vector.<Ball>();
			lives = new Vector.<Sprite>();
		}
		
		override public function setup(): void {
			scoreTextField = new TextField();
			scoreTextField.width = 200;
			this.game.addChild(scoreTextField);

			player = new Sprite();
			player.addChild(this.game.resourceMap["images/player.png"]);
			this.game.addChild(player);
			
			/* Creates the hitpoints*/
			for(var i: Number = 0; i < 5; i++) {
				var live: Sprite = new Sprite();
				live.addChild(new Bitmap(this.game.resourceMap["images/heart.png"].bitmapData));
				live.x = (i + 1) * 20;
				live.y = 10;
				this.game.addChild(live);
				lives.push(live);
			}
			
			leftHand = new Hand(this, 440, 520);
			rightHand = new Hand(this, 230, 520);

			for (i = 0; i < 4; i++) {
				var newBall: Ball = new Ball(this, BallPosition.RIGHT_HAND);
				balls.push(newBall);
			}

			launchSound = game.resourceMap["sounds/launch.mp3"];
			gameSound = game.resourceMap["sounds/circus.mp3"];
			
			var volumeAdjust:SoundTransform = new SoundTransform();
			volumeAdjust.volume = .5;

			gameSound.play(0, 1, volumeAdjust);

			player.x = 800 / 2 - 150;
			player.y = 640 - 220;
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
					if (ball.sprite.y < ballToLaunch.y) {
						ballToLaunch = ball;
					}
				}

				ballToLaunch.launch(ballChargeBeginning);
			}
		}
		
		private function findBallInLeftHand(): Ball {
			for each (var ball in balls) {
				if (ball.state == BallPosition.LEFT_HAND) {
					return ball;
				}
			}
			
			return null;
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
			currentFrame++;

			leftHand.sprite.x = game.mouse.x;
			
			if (game.mouse.down) {
				if (balls.length > 0) {
					var ballInLeftHand: Ball = findBallInLeftHand();
					
					if (ballInLeftHand) {
						ballInLeftHand.canCollide = false;
						ballInLeftHand.vy = -10;
						ballInLeftHand.vx = -0.05 * (leftHand.sprite.x - rightHand.sprite.x);
						ballInLeftHand.state = BallPosition.NONE;

						var timer: Timer = new Timer(200, 1);
						timer.addEventListener("timer", ballInLeftHand.updateCanCollide);
						timer.start();
					}
				}
			}

			if (game.keyMap[Keyboard.R]) {
				game.changeState(new GameState(game));
			}
			
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
			
			for each (var ball in balls) {
				ball.update();
			}
			
			if(lives.length == 0) {
				game.changeState(new GameOverState(game));
			}
		}

	}

}
