package  {
	
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	
	public class PlayState extends FlxState{
		public String swipe;
		
		public PlayState(String word) {
			this.swipe = word;
		}

		override public function create():void {
			add(new FlxText(0, 0, 100, swipe));
		}

	}
	
}
