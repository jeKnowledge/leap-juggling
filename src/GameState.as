﻿package {

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
		public var name: String;

		// Player
		public var player: Player;

		// Balls
		public var ballChargeBeginning: int;
		public var ballCharging: Boolean = false;
		public var balls: Vector.<Ball>;

		// Aux Variables
		public var currentFrame: int;
		public var paused: Boolean;

		// Sounds
		public var launchSound: Sound;
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
		
		protected function changePaused(): void {
			if (paused) {
				paused = false;
				textFields.updateCustomTextField("pause", "");
			} else {
				paused = true;
				textFields.updateCustomTextField("pause", "  Game paused\nPress Q to quit");
			}
		}

		override public function setup(): void {
			// Player
			player = new Player(this);
			player.setup();
			
			this.useLeapPointer = false;
			// Ball Sprites
			balls = new Vector.<Ball>();
			for (var i: int = 0; i < NUM_BALLS; i++) {
				var newBall: Ball = new Ball(this);
				newBall.setup();
				balls.push(newBall);
			}

			// Sounds
			launchSound = game.resourceMap["assets/sounds/launch.mp3"];
			transitionSound = game.resourceMap["assets/sounds/transition.mp3"];
			
			// TextFields
			textFields = new CustomTextFields(game);
			textFields.createCustomTextField("pause", "", 350, 100);
		}

		override public function update(): void { }
	}

}
