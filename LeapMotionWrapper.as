package  {
	import com.leapmotion.leap.Hand;
	import com.leapmotion.leap.*;
	import com.leapmotion.leap.util.*;
	import com.leapmotion.leap.events.*;
	
	public class LeapMotionWrapper {
		
		//public var gestures: Vector.<Gestures>;
		public var leapHands: Object = {rightX: 0, rightY: 0, leftX: 0, leftY: 0, left: false, right: false};

		public function LeapMotionWrapper() { }
		
		public function leapMotionRightUp(): void {
			leapHands.right = true;
		}
		
		public function leapMotionRightDown(): void {
			leapHands.right = false;
		}
		
		public function leapMotionLeftUp(): void {
			leapHands.left = true;
		}
		
		public function leapMotionLeftDown(): void {
			leapHands.left = false;
		}

	}
	
}
