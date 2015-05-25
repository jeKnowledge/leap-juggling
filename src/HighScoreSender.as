package  {
	
	import flash.events.*;
    import flash.net.*;
	
	public class HighScoreSender {
		
		private var url: String;
		
		public function HighScoreSender(url: String) {
			this.url = url;
		}
		
		public function sendScore(user: String, score: int, gameMode: String) {
			var loader: URLLoader = new URLLoader();
			var request: URLRequest = new URLRequest();

			var data: String = "?score=" + score.toString() + "&name=" + user + "&gameMode=" + gameMode;
			
			request.url = this.url + data;
			request.method = URLRequestMethod.POST;
 
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(request);
		}
		
		private function onComplete(e: Event): void {
			trace("Score sent.");
		}
		
	}
	
}
