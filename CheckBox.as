package {

	import flash.events.KeyboardEvent;
	import flash.display.Sprite;

	public class CheckBox {

		public var state: State;
		public var sprite: Sprite;
		private var checked: Boolean = false;
		
		public function CheckBox(state: State, x: int, y: int) {
			this.state = state;
			
			sprite = new Sprite();
			sprite.addChild(state.game.resourceMap["images/checkbox_unchecked.png"]);
			sprite.x = x;
			sprite.y = y;
			sprite.height = 35;
			sprite.width = 35;
			this.state.game.addChild(sprite);
		}
		
		public function check(): void {
			if (checked) {
				checked = false;
				
				sprite.removeChild(state.game.resourceMap["images/checkbox_checked.png"]);
				sprite.addChild(state.game.resourceMap["images/checkbox_unchecked.png"]);
			} else {
				checked = true;
				
				sprite.removeChild(state.game.resourceMap["images/checkbox_unchecked.png"]);
				sprite.addChild(state.game.resourceMap["images/checkbox_checked.png"]);
			}
		}
		
		public function getChecked(): Boolean {
			return checked;
		}
	}

}