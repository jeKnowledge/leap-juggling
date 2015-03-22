package {
	import org.flixel.*;
	import com.leapmotion.leap.*;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.text.TextField;
	
	
	public class ProjectInterface extends Sprite implements Listener {
		public var statusText: TextField;
		private var controller: Controller;
		private var startTime: Number;
		private var currentTime: Number;
		private var framesNumber: int = 0;
		private var lastSwipe:int;
		public function ProjectInterface() {
			statusText.scrollV = statusText.maxScrollV;
			statusText.appendText("Creating Controller...\n");
			controller = new Controller();
			statusText.appendText("Setting listener...\n");
			controller.setListener(this);
			statusText.appendText("Controller setup...\n");
		}
		public function onInit(controller: Controller): void {
			trace("onInit");
			statusText.appendText("onInit\n");
		}
		public function onConnect(controller: Controller): void {
			trace("onConnect");
			statusText.appendText("onConnect\n");
			controller.enableGesture(Gesture.TYPE_SWIPE);
			controller.enableGesture(Gesture.TYPE_CIRCLE);
			controller.enableGesture(Gesture.TYPE_SCREEN_TAP);
			controller.enableGesture(Gesture.TYPE_KEY_TAP);
			startTime = getTimer();
		}
		public function onDisconnect(controller: Controller): void {
			trace("onDisconnect");
			statusText.appendText("onDisconnect\n");
		}
		public function onExit(controller: Controller): void {
			trace("onExit");
			statusText.appendText("onExit\n");
		}
		public function onFocusGained(controller: Controller): void {
			trace("onFocusGained");
			statusText.appendText("onFocusGained\n");
		}
		public function onFocusLost(controller: Controller): void {
			trace("onFocusLost");
			statusText.appendText("onFocusLost\n");
		}
		public function onFrame(controller: Controller, frame: Frame): void {
			currentTime = (getTimer() - startTime) / 1000;
			framesNumber++;
			if (currentTime > 1) {
				//trace("Data FPS: " + (Math.floor((framesNumber / currentTime) * 10.0) / 10.0));
				//statusText.appendText("Data FPS: " + (Math.floor((framesNumber / currentTime) * 10.0) / 10.0) + "\n");
				startTime = getTimer();
				framesNumber = 0;
			}
			trace("Frame id: " + frame.id + ", timestamp: " + frame.timestamp + ", hands: " + frame.hands.length + ", fingers: " + frame.fingers.length + ", tools: " + frame.tools.length + "\n");
			var now: int = getTimer();
			if (now - lastSwipe > 500) {
				var gestures: Vector.<Gesture> = frame.gestures();
				for each(var gesture: Gesture in gestures) {
					if (gesture is SwipeGesture && gesture.state == Gesture.STATE_STOP) {
						var swipe: SwipeGesture = gesture as SwipeGesture;
						if (Math.abs(swipe.direction.x) > Math.abs(swipe.direction.y)) {
							if (swipe.direction.x > 0) {
								super(320, 240, PlayState("swipe para a direita"), 2);
								//trace("swipe pa direita");
								statusText.appendText("swipe pa direita\n");
							} else {
								super(320, 240, PlayState("swipe para a direita"), 2)
								//trace("swipe pa esquerda");
								statusText.appendText("swipe pa esquerda\n");
							}
							lastSwipe = now;
							break;
						}
					}
				}
			}

		}
		public function onServiceConnect(controller: Controller): void {}
		public function onServiceDisconnect(controller: Controller): void {}
		public function onDeviceChange(controller: Controller): void {}
	}
}