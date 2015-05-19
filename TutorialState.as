package  {
	
	public class TutorialState extends GameState {
		
		public function TutorialState(game: Game) {
			super(game);
		}
		
		public override function setup(): void {
			player = new Player(this);
			player.setup();
			
		}
		
		public override function update(): void {
			player.update();
		}

	}
	
}
