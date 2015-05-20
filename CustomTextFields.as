package  {
	
	import flash.text.*;
	
	public class CustomTextFields {
		
		public var game: Game;
		private var textFields: Object;
		
		public function CustomTextFields(game: Game) {
			this.game = game;
			this.textFields = new Object();
		}
		
		public function createCustomTextField(label: String, text: String, x: int = 0, y: int = 0, fontSize: int = 30): void {
			
			var textField: TextField = new TextField();
			textField.x = x;
			textField.y = y;
			textField.width = 800; // FIX: hardcoded value
			textField.defaultTextFormat = new TextFormat('Helvetica', fontSize, 0x000);
			textField.text = text;
			
			this.game.addChild(textField);
			this.textFields[label] = textField;
		}
		
		public function updateCustomTextField(label: String, text: String) {
			this.textFields[label].text = text;
		}
	}
	
}
