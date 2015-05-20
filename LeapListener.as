package  {
	import com.leapmotion.leap.*;
	import com.leapmotion.leap.events.*;
	import com.leapmotion.leap.util.*;
	
	public class LeapListener implements Listener {
		
		public var controller: Controller;
		public var hand: Hand;
		public var game: Game;

		public function LeapListener(game: Game) {
			this.game = game;
			controller = new Controller();
			controller.setListener(this);
		}
		
		public function onInit(controller: Controller): void {
			trace("Initialized");
		}
		
		public function onFocusGained(controller: Controller): void {
			trace("Gained Focus");
		}
		
		public function onFocusLost(controller: Controller): void {
			trace("Lost Focus");
		}
		
		public function onServiceConnect(controller: Controller): void {
			trace("Service Connected");
		}
		
		public function onServiceDisconnect(controller: Controller): void {
			trace("Service Disconnected");
		}
		
		public function onDeviceChange(controller: Controller): void {
			trace("Device Changed");
		}
		
		public function onConnect(controller: Controller): void {
			trace("Connected");
			controller.enableGesture(Gesture.TYPE_SWIPE);
			controller.enableGesture(Gesture.TYPE_CIRCLE);
			controller.enableGesture(Gesture.TYPE_SCREEN_TAP);
			controller.enableGesture(Gesture.TYPE_KEY_TAP);
			controller.setPolicyFlags(Controller.POLICY_IMAGES);
		}
		
		public function onDisconnect(controller: Controller): void {
			trace("Disconnected");
		}
		
		public function onExit(controller: Controller): void {
			trace("Exited");
		}
		
		public function foundHand(controller: Controller, frame: Frame): void {
			
		}
		
		public function onFrame(controller: Controller, frame:Frame): void {
			var hands: Object = game.myLeapMotion.leapHands;
			var frameHands: Vector.<Hand> = frame.hands;
			if (frameHands.length == 2) {
				hands = {right: true, left: true};
				
				if (frame.hands[0].isLeft == true) {
					hands = {rightX: frameHands[1].palmPosition.x, rightY: frameHands[1].palmPosition.y,
							 leftX: frameHands[0].palmPosition.x, leftY: frameHands[0].palmPosition.y};
					
				} else {
					hands = {rightX: frameHands[0].palmPosition.x, rightY: frameHands[0].palmPosition.y,
							 leftX: frameHands[1].palmPosition.x, leftY: frameHands[1].palmPosition.y};
				}
				trace("Right Hand: " + hands.rightX);
				trace("Left Hand: " + hands.leftX);
			} else if (frameHands.length == 1) {
				if (frame.hands[0].isLeft == true) {
					hands = {right: false, left: true, 
							 leftX: frameHands[0].palmPosition.x, leftY: frameHands[0].palmPosition.y};
				} else {
					hands = {right: true, left: false, 
							 rightX: frameHands[0].palmPosition.x, rightY: frameHands[0].palmPosition.y};
				}
				trace("Right Hand: " + hands.rightX);
				trace("Left Hand: " + hands.leftX);
			}
		
			//trace("Hands: " + frame.hands.length + ", Fingers: " + frame.fingers.length + ", Gestures: " + frame.gestures().length);
			if (frame.hands.length > 0) {
				hand = frame.hands[0];
				//trace(hand);
				var fingers:Vector.<Finger> = hand.fingers;
				if(hand.isLeft == true) {
					//trace("Palm Position: " + hand.palmPosition.x);
				}
				var normal: Vector3  = hand.palmNormal;
				var direction: Vector3 = hand.direction;
			}
			
			var gestures: Vector.<Gesture> = frame.gestures();
			for (var i: int = 0; i < gestures.length; i++) {
				var gesture: Gesture = gestures[i];
				
				switch(gesture.type) {
					case Gesture.TYPE_SWIPE:
						var swipe: SwipeGesture = SwipeGesture(gesture);
						//trace("Swipe Direction: " + swipe.direction);
						break;
					
					case Gesture.TYPE_SCREEN_TAP:
						var screenTap: ScreenTapGesture = ScreenTapGesture(gesture);
						trace("Tapped Screen");
						break;
					
					case Gesture.TYPE_KEY_TAP:
						var keyTap: KeyTapGesture = KeyTapGesture(gesture);
						trace("Key Tapped");
						break;
				}
			}
		}
	}
	
}
