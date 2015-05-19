package {

	import flash.events.KeyboardEvent;

	public class Player extends GameObject {
		
		public var leftHand: Hand;
		public var rightHand: Hand;
		
		public function Player(gameState: GameState) {
			super(gameState);
		}

		public override function setup(): void {
			sprite.addChild(gameState.game.resourceMap["images/player.png"]);
			sprite.x = 800 / 2 - 150;
			sprite.y = 640 - 220;
			this.gameState.game.addChild(sprite);
			
			this.leftHand = new Hand(this.gameState, 440, 520);
			this.rightHand = new Hand(this.gameState, 230, 520);
		}
		
		public override function update(): void { }

	}

}