package  {
	
	import com.leapmotion.leap.*;
	import com.leapmotion.leap.events.*;
	import com.leapmotion.leap.util.*;
	
	public class LeapListener implements Listener {
		
		public var controller: Controller;
		public var hands: Object;
		public var game: Game;

		public function LeapListener(game: Game) {
			this.game = game;
			
			this.hands = new Object();
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
		
		public function onFrame(controller: Controller, frame: Frame): void {
			var frameHands: Vector.<Hand> = frame.hands;
			var gestures: Vector.<Gesture> = frame.gestures();
			
			if (frameHands.length == 2) {
				hands = { right: true, left: true };
				
				if (frame.hands[0].isLeft == true) {
					hands = { rightX: frameHands[1].palmPosition.x, rightY: frameHands[1].palmPosition.y,
							  leftX: frameHands[0].palmPosition.x, leftY: frameHands[0].palmPosition.y };
					
				} else {
					hands = { rightX: frameHands[0].palmPosition.x, rightY: frameHands[0].palmPosition.y,
							  leftX: frameHands[1].palmPosition.x, leftY: frameHands[1].palmPosition.y };
				}
			} else if (frameHands.length == 1) {
				if (frame.hands[0].isLeft == true) {
					hands = { right: false, left: true, 
							  leftX: frameHands[0].palmPosition.x, leftY: frameHands[0].palmPosition.y };
				} else {
					hands = { right: true, left: false, 
							  rightX: frameHands[0].palmPosition.x, rightY: frameHands[0].palmPosition.y };
				}
			}
			
			for (var i: int = 0; i < gestures.length; i++) {
				var gesture: Gesture = gestures[i];
				var auxHands: Vector.<Hand> = gesture.hands;
				
				var j: int;
				if (gesture.type == Gesture.TYPE_KEY_TAP) {
					for (j = 0; j < auxHands.length; j++) {
						if (auxHands[j].isRight) {
							game.leapMap[LeapPosition.RIGHT_TAP] = true;
						}
					}
				} else if (gesture.type == Gesture.TYPE_SWIPE) {
					for (j = 0; j < auxHands.length; j++) {
						if (auxHands[j].isLeft) {
							game.leapMap[LeapPosition.SWIPE_UP] = true;
						}
					}
				} else if (gesture.type == Gesture.TYPE_SCREEN_TAP) {
					trace("Tapped Screen");
					for (j = 0; j < auxHands.length; j++) {
						if (auxHands[j].isRight) {
							game.leapMap[LeapPosition.SCREEN_TAP] = true;
						}
					}
				}
			}
		}
	}
	
}
