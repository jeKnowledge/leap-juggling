﻿package  {

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
	import Math;
	
	public class ChallangeGameState extends GameState {
		
		// Game Settings
		private var NUM_BALLS: int = 5;
		
		// Random Gravitites
		private var randomGravities: Array = [0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95];
		
		public function ChallangeGameState(game: Game) {
			super(game);
		}
		
		public override function setup(): void {
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
			
			volumeAdjust = new SoundTransform();
			volumeAdjust.volume = game.settings.volume;
			
			gameSound.play(0, 1, volumeAdjust);			
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
			
			// Update Balls
			for each (var ball in balls) {
			    var randomValue: int = int(randomGravities.length * Math.random());
				ball.GRAVITY = randomGravities[randomValue];
				ball.update();
			}
			
			// Check if the player lost
			if (player.lives.length == 0) {
				game.changeState(new GameOverState(game, player.score, this));
			}
		}

	}
	
}
