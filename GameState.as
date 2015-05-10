package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.LoaderInfo;

	public class GameState extends MovieClip {

		private var player: Sprite;

		public function GameState() {
			trace("hello world");

			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest("test.png"));
		}


		private function onLoadComplete(e: Event): void {
			var loaderInfo: LoaderInfo = e.target as LoaderInfo;
			var loadedBitmap: Bitmap = loaderInfo.content as Bitmap;

			player = new Sprite();
			player.addChild(loadedBitmap);

			addChild(player);

			trace("hi");
			player.x = 100;
			player.y = 200;
			//so on

		}



	}

}