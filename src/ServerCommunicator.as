package  {
	
	import flash.events.*;
    import flash.net.*;
	
	public class ServerCommunicator {
		
		public function ServerCommunicator() { }
		
		public function sendScore(url: String, user: String, score: int, gameMode: String) {
			var loader: URLLoader = new URLLoader();
			var request: URLRequest = new URLRequest();

			var data: String = "?score=" + score.toString() + "&name=" + user + "&gameMode=" + gameMode;
			
			request.url = url + data;
			request.method = URLRequestMethod.POST;
 
			loader.addEventListener(Event.COMPLETE, sendScoreComplete);
			loader.load(request);
		}
		
		public function getHighScores(url: String, gameMode: String) {
			var loader: URLLoader = new URLLoader();
			var request: URLRequest = new URLRequest();
			
			request.url = url;
			request.method = URLRequestMethod.GET;
 
			loader.addEventListener(Event.COMPLETE, getHighScoresComplete);
			loader.load(request);
		}
		
		private function sendScoreComplete(e: Event): void {
			trace("Score sent.");
		}
		
		private function getHighScoresComplete(e: Event): void {
			trace(e.target.data);
		}
		
	}
	
}
