package com.zyab.minesweeper.views
{	
	import com.zyab.minesweeper.events.EventsList;
	import com.zyab.minesweeper.utils.GameSettingsStruct;
	import com.zyab.minesweeper.utils.NbSelectorView;
	
	import feathers.controls.Button;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	
	// Displays 3 selectors to choose a custom game settings
	
	public class CustomGameSettingsView extends Sprite
	{
		private const widthSelectText:String = "Width ";
		private const heightSelectText:String = "Height ";
		private const nbMinesSelectText:String = "Mines ";
		private const startGame:String = "Start Game";
		
		private var widthSelector:NbSelectorView;
		private var heightSelector:NbSelectorView;
		private var minesSelector:NbSelectorView
		private var startButton:Button;
		
		public function CustomGameSettingsView()
		{
			init();
		}
		
		public function setSize(width:int,height:int):void{
			startButton.x = width/2;
			startButton.y = height*0.85;
			widthSelector.y = 0.05*height;
			heightSelector.y = widthSelector.y+0.25*height;
			minesSelector.y = heightSelector.y+0.25*height;
		}
		
		private function init():void
		{
			widthSelector = new NbSelectorView(widthSelectText,3,30);
			widthSelector.addEventListener(NbSelectorView.NB_SELECTOR_CHANGE,settingsSelectorChange);
			addChild(widthSelector);
			
			heightSelector = new NbSelectorView(heightSelectText,3,30);
			heightSelector.addEventListener(NbSelectorView.NB_SELECTOR_CHANGE,settingsSelectorChange);
			addChild(heightSelector);
			
			var nbMinesMax:int = widthSelector.getValue()*heightSelector.getValue() - 9;
			
			minesSelector = new NbSelectorView(nbMinesSelectText,0,nbMinesMax);
			addChild(minesSelector);
			
			startButton = new Button();
			startButton.label = startGame;
			startButton.addEventListener(TouchEvent.TOUCH,onStartButton);
			addChild(startButton);
		}
		
		private function onStartButton(event:TouchEvent):void{
			var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
			if(touch){
				var settings:GameSettingsStruct = new GameSettingsStruct(widthSelector.getValue(),heightSelector.getValue(),minesSelector.getValue());
				dispatchEventWith(EventsList.START_GAME,true,settings);
			}
		}
		
		public function setSettings (settings:GameSettingsStruct):void{
			widthSelector.setValue(settings.width);
			heightSelector.setValue(settings.height);
			modifyNbMinesMax();
			minesSelector.setValue(settings.nbMines);
		}
		
		private function settingsSelectorChange(event:Event):void{
			modifyNbMinesMax();
		}
		
		private function modifyNbMinesMax():void{
			var nbMinesMax:int = widthSelector.getValue()*heightSelector.getValue() - 9;
			minesSelector.setMaximum(nbMinesMax);
			minesSelector.checkValue();
		}
	}
}