package  {
	
	import flash.events.*;
    import flash.net.*;
	
	public class HighScoreSender {
		
		private var url: String;
		
		public function HighScoreSender(url: String) {
			this.url = url;
		}
		
		public function sendScore(user: String, score: int) {
			var loader: URLLoader = new URLLoader();
			var request: URLRequest = new URLRequest();

			var variables : URLVariables = new URLVariables();  
			variables.user = user;  
			variables.score = score;
			
			request.url = this.url;
			request.method = URLRequestMethod.POST;
			request.data = variables;
 
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;e
			loader.load(request);
		}
		
		private function onComplete(e: Event): void {
			trace("Score sent.");
		}
	}
	
}
