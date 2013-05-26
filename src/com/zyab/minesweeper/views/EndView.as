package com.zyab.minesweeper.views
{	
	import com.zyab.minesweeper.events.EventsList;
	
	import feathers.controls.Button;

	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import com.zyab.minesweeper.Constants;
	
	//Basic view displaying a title, a button with start game event, and another with settings event
	
	public class EndView extends Sprite
	{
		protected var text:String;
		protected var playAgain:String;
		protected var settings:String = "Settings";
		protected var playAgainButton:Button;
		protected var settingsButton:Button;
		
		protected function init():void{
			var textField:TextField = new TextField(300, 300,text, 
				"Desyrel", BitmapFont.NATIVE_SIZE, 0xffffff);
			textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
			textField.y = 50;
			addChild(textField);
			
			playAgainButton = new Button();
			playAgainButton.label = playAgain;
			playAgainButton.x = Constants.STAGE_WIDTH*0.1;
			playAgainButton.y = Constants.STAGE_HEIGHT*0.70;
			playAgainButton.addEventListener(TouchEvent.TOUCH,playAgainButtonTouch);
			addChild(playAgainButton);
			
			settingsButton = new Button();
			settingsButton.label = settings;
			settingsButton.addEventListener(TouchEvent.TOUCH,onSettingsButton);
			settingsButton.y = playAgainButton.y;
			settingsButton.x = Constants.STAGE_WIDTH*0.6;
			addChild(settingsButton);
		}
		
		private function onSettingsButton(event:TouchEvent):void {
			if (event.getTouch(this, TouchPhase.ENDED)){
				dispatchEventWith(EventsList.SETTINGS, true);
			}
		}
		
		private function playAgainButtonTouch(event:TouchEvent):void {
			if (event.getTouch(this, TouchPhase.ENDED)){
				dispatchEventWith(EventsList.START_GAME, true);
			}
		}
	}
}