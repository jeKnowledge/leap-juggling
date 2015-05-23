package  {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.*;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.events.IOErrorEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.media.Sound;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Timer;
	
	public class LoadingState extends State {

		public function LoadingState(game: Game) {
			super(game);

			for each (var resourceURL in game.resourceURLs) {
				var loader: Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.load(new URLRequest(resourceURL));
			}

			for each (var soundURL in game.soundURLs) {
				var s: Sound = new Sound();
				s.addEventListener(Event.COMPLETE, onSoundLoaded);
				var req:URLRequest = new URLRequest(soundURL);
				s.load(req);
			}
			
			// AS3
			var myTimer:Timer = new Timer(2000, 1); // 2 seconds
			myTimer.addEventListener(TimerEvent.TIMER, loadingOver);
			myTimer.start();
		}
		
		function loadingOver(event: TimerEvent):void {
			game.changeState(new MenuState(game));
		}
		
		private function onLoadComplete(e: Event): void {
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			
			var resourceName: String = loaderInfo.url.slice(5);
			var resourceExtension: String = resourceName.substring(resourceName.lastIndexOf(".") + 1, resourceName.length);
						
			if (resourceExtension == "png") {
				var loadedBitmap: Bitmap = loaderInfo.content as Bitmap;
				game.resourceMap[resourceName] = loadedBitmap;
			}

			trace("New object called " + resourceName + " has been added to resourceMap.");
		}
		
		private function onSoundLoaded(e: Event): void {
			var resourceName: String = e.target.url.slice(5);
			game.resourceMap[resourceName] = e.target as Sound;
						
			trace("New sound called " + resourceName + " has been added to resourceMap.");
		}
		
		public override function update(): void {
			
		}

	}

}
