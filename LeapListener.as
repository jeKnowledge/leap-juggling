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
			
			if (frame.hands.length == 2) {
				game.myLeapMotion.leapHands.right = true;
				game.myLeapMotion.leapHands.left = true;
				
				if (frame.hands[0].isLeft == true) {
					game.myLeapMotion.leapHands.rightX = frame.hands[1].direction.x;
					game.myLeapMotion.leapHands.rightY = frame.hands[1].direction.y;
					game.myLeapMotion.leapHands.leftX = frame.hands[0].direction.x;
					game.myLeapMotion.leapHands.leftY = frame.hands[0].direction.y;
					trace(game.myLeapMotion.leapHands.leftX);
				} else {
					game.myLeapMotion.leapHands.rightX = frame.hands[0].direction.x;
					game.myLeapMotion.leapHands.rightY = frame.hands[0].direction.y;
					game.myLeapMotion.leapHands.leftX = frame.hands[1].direction.x;
					game.myLeapMotion.leapHands.leftY = frame.hands[1].direction.y;
				}
			} else if (frame.hands.length == 1) {
				if (frame.hands[0].isLeft == true) {
					game.myLeapMotion.leapHands.left = true;
					game.myLeapMotion.leapHands.right = false;
					game.myLeapMotion.leapHands.leftX = frame.hands[0].direction.x;
					game.myLeapMotion.leapHands.leftY = frame.hands[0].direction.y;
				} else {
					game.myLeapMotion.leapHands.left = false;
					game.myLeapMotion.leapHands.right = true;
					game.myLeapMotion.leapHands.rightX = frame.hands[0].direction.x;
					game.myLeapMotion.leapHands.rightY = frame.hands[0].direction.y;
				}
			}
		
			//trace("Hands: " + frame.hands.length + ", Fingers: " + frame.fingers.length + ", Gestures: " + frame.gestures().length);
			if (frame.hands.length > 0) {
				hand = frame.hands[0];
				trace(hand);
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
