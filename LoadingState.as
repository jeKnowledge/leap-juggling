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
	import flash.display.Shape;
	import flash.utils.getTimer;
	
	public class LoadingState extends State {
		
		private var loadingRectangle: Shape;
		private var loadingSeconds: int = 2000; // 2 seconds
		private var loadingWidth: int;
		
		private var startState: Number;
		private var myTimer: Timer;

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
			myTimer = new Timer(loadingSeconds, 1);
			myTimer.addEventListener(TimerEvent.TIMER, loadingOver);
			myTimer.start();
			startState = getTimer();
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

		public override function setup(): void {
			loadingWidth = 500;

			var loadingRectangleBorder: Shape = game.getRectangleBorder(150, 250, loadingWidth, 30, 8);
			game.addChild(loadingRectangleBorder);
			
			loadingRectangle = new Shape;
			loadingRectangle.graphics.beginFill(0xF00);
			loadingRectangle.graphics.drawRect(150, 250, 0, 30);
			loadingRectangle.graphics.endFill();
			game.addChild(loadingRectangle);
			
		}
		
		public override function update(): void {
			trace(getTimer() / loadingSeconds * 500);
			
			loadingRectangle.graphics.beginFill(0xF00);
			loadingRectangle.graphics.drawRect(150, 250, (getTimer() - startState) / loadingSeconds * 500, 30);
			loadingRectangle.graphics.endFill();
		}

	}

}
