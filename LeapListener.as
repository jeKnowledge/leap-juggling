package  {
	import com.leapmotion.leap.*;
	import com.leapmotion.leap.events.*;
	import com.leapmotion.leap.util.*;
	
	public class LeapListener {
		
		public var controller: Controller;

		public function LeapListener() {
			controller = new Controller();
			controller.addEventListener(LeapEvent.LEAPMOTION_INIT, onInit);
			controller.addEventListener(LeapEvent.LEAPMOTION_CONNECTED, onConnect);
			controller.addEventListener(LeapEvent.LEAPMOTION_DISCONNECTED, onDisconnect);
			controller.addEventListener(LeapEvent.LEAPMOTION_EXIT, onExit);
			controller.addEventListener(LeapEvent.LEAPMOTION_FRAME, onFrame);
		}
		
		private function onInit(event: LeapEvent): void {
			trace("Initialized");
		}
		
		private function onConnect(event: LeapEvent): void {
			trace("Connected");
			controller.enableGesture(Gesture.TYPE_SWIPE);
			controller.enableGesture(Gesture.TYPE_CIRCLE);
			controller.enableGesture(Gesture.TYPE_SCREEN_TAP);
			controller.enableGesture(Gesture.TYPE_KEY_TAP);
			controller.setPolicyFlags(Controller.POLICY_IMAGES);
		}
		
		private function onDisconnect(event: LeapEvent): void {
			trace("Disconnected");
		}
		
		private function onExit(event: LeapEvent): void {
			trace("Exited");
		}
		
		private function onFrame(event: LeapEvent): void {
			var hand: com.leapmotion.leap.Hand;
			var frame: Frame = event.frame;
			trace( "Frame id: " + frame.id + ", timestamp: " + frame.timestamp + ", hands: " + frame.hands.length + ", fingers: " + frame.fingers.length + ", tools: " + frame.tools.length);
			
			if(frame.hands.length > 0) {
				hand = frame.hands[0];
				
				var fingers: Vector.<Finger> = hand.fingers;
				if(fingers.length > 0) {
					var avgPos: Vector3 = Vector3.zero();
					for each (var finger: Finger in fingers) {
						avgPos = avgPos.plus(finger.tipPosition);
					}
					
					avgPos = avgPos.divide(fingers.length);
					trace("Hand has " + fingers.length + " fingers, average finger tip position: " + avgPos);
				}
				
				trace("Hand sphere radius: " + hand.sphereRadius + " mm, palm position: " + hand.palmPosition);
				
				var normal: Vector3 = hand.palmNormal;
				var direction: Vector3 = hand.direction;
				
				trace("Hand pitch: " + LeapUtil.toDegrees(direction.pitch) + " degrees, " + "roll: " + LeapUtil.toDegrees(normal.roll) + " degrees, " + "yaw: " + LeapUtil.toDegrees(direction.yaw) + " degrees\n");
			}
		}
	}
	
}
