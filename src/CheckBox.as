package {

	import flash.events.KeyboardEvent;
	import flash.display.Sprite;

	public class CheckBox {

		public var state: State;
		public var sprite: Sprite;
		private var checked: Boolean = false;
		
		public function CheckBox(state: State, x: int, y: int, checked: Boolean) {
			this.state = state;
			this.checked = checked;
			
			sprite = new Sprite();
			if (checked) {
				sprite.addChild(state.game.resourceMap["assets/images/checkbox_checked.png"]);
			} else {
				sprite.addChild(state.game.resourceMap["assets/images/checkbox_unchecked.png"]);
			}
			sprite.x = x;
			sprite.y = y;
			sprite.height = 35;
			sprite.width = 35;
			this.state.game.addChild(sprite);
		}
		
		public function check(): void {
			if (checked) {
				checked = false;
				
				sprite.removeChild(state.game.resourceMap["assets/images/checkbox_checked.png"]);
				sprite.addChild(state.game.resourceMap["assets/images/checkbox_unchecked.png"]);
			} else {
				checked = true;
				
				sprite.removeChild(state.game.resourceMap["assets/images/checkbox_unchecked.png"]);
				sprite.addChild(state.game.resourceMap["assets/images/checkbox_checked.png"]);
			}
		}
		
		public function getChecked(): Boolean {
			return checked;
		}
		
	}

}