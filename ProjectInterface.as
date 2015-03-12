﻿package {	import com.leapmotion.leap.*;	import flash.display.Sprite;	import flash.utils.getTimer;	import flash.text.TextField;	public class ProjectInterface extends Sprite implements Listener {		public var statusText: TextField;		private var controller: Controller;		private var startTime: Number;		private var currentTime: Number;		private var framesNumber: int = 0;		public function ProjectInterface() {			statusText.appendText("Creating Controller...\n");			controller = new Controller();			statusText.appendText("Setting listener...\n");			controller.setListener(this);			statusText.appendText("Controller setup...\n");		}		public function onInit(controller: Controller): void {			trace("onInit");			statusText.appendText("onInit\n");		}		public function onConnect(controller: Controller): void {			trace("onConnect");			statusText.appendText("onConnect\n");			controller.enableGesture(Gesture.TYPE_SWIPE);			controller.enableGesture(Gesture.TYPE_CIRCLE);			controller.enableGesture(Gesture.TYPE_SCREEN_TAP);			controller.enableGesture(Gesture.TYPE_KEY_TAP);			startTime = getTimer();		}		public function onDisconnect(controller: Controller): void {			trace("onDisconnect");			statusText.appendText("onDisconnect\n");		}		public function onExit(controller: Controller): void {			trace("onExit");			statusText.appendText("onExit\n");		}		public function onFocusGained(controller: Controller): void {			trace("onFocusGained");			statusText.appendText("onFocusGained\n");		}		public function onFocusLost(controller: Controller): void {			trace("onFocusLost");			statusText.appendText("onFocusLost\n");		}		public function onFrame(controller: Controller, frame: Frame): void {			currentTime = (getTimer() - startTime) / 1000;			framesNumber++;			if (currentTime > 1) {				trace("Data FPS: " + (Math.floor((framesNumber / currentTime) * 10.0) / 10.0));				statusText.appendText("Data FPS: " + (Math.floor((framesNumber / currentTime) * 10.0) / 10.0) + "\n");				startTime = getTimer();				framesNumber = 0;			}						statusText.appendText( "Frame id: " + frame.id + ", timestamp: " + frame.timestamp + ", hands: " + frame.hands.length + ", fingers: " + frame.fingers.length + ", tools: " + frame.tools.length );		}		public function onServiceConnect(controller: Controller): void {		}		public function onServiceDisconnect(controller: Controller): void {		}		public function onDeviceChange(controller: Controller): void {		}	}}