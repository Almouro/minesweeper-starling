package com.zyab.minesweeper.views
{
	import feathers.controls.Button;
	
	import starling.display.DisplayObject;
	
	// State button displaying current clicking state (normal click, flag...)
	
	public class StateButtonView extends Button
	{
		private var statesIcon:Vector.<DisplayObject>;
		private var currentState:int;
		private var numberStates:int;
		
		public function StateButtonView(statesIcon:Vector.<DisplayObject>)
		{
			this.statesIcon = statesIcon;
			this.numberStates = this.statesIcon.length;
			currentState = 0;
			setIcon();
		}
		
		public function changeState(state:int):void{
			currentState = state;
			if(currentState >= numberStates)
				currentState = numberStates-1;
			trace("StateButton icon changed to icon number " + this.currentState);
			setIcon();
		}
		
		private function setIcon():void{
			this.defaultIcon = statesIcon[currentState];
		}
	}
}