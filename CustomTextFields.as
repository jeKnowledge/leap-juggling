package  {
	
	import flash.text.*;
	import flash.display.DisplayObject;
	
	public class CustomTextFields {
		
		public var game: Game;
		private var textFields: Object;
		
		public function CustomTextFields(game: Game) {
			this.game = game;
			this.textFields = new Object();
		}
		
		public function createCustomTextField(key: String, text: String, x: int = 0, y: int = 0, fontSize: int = 30): void {
			var textField: TextField = new TextField();
			textField.x = x;
			textField.y = y;
			textField.width = this.game.stage.stageWidth - x;
			textField.height = this.game.stage.stageHeight - y;
			textField.defaultTextFormat = new TextFormat('pixelmix', fontSize, 0x000);
			textField.text = text;
			
			this.game.addChild(textField);
			this.textFields[key] = textField;
		}
		
		public function updateCustomTextField(key: String, text: String): void {
			this.textFields[key].text = text;
		}
		
		public function getKeyValue(key: String): DisplayObject {
			return this.textFields[key];
		}
	}
	
}
