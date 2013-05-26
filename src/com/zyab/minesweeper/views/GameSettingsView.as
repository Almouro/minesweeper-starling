package com.zyab.minesweeper.views
{
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	
	import com.zyab.minesweeper.models.RandomGameSettings;
	
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import com.zyab.minesweeper.Constants;
	import com.zyab.minesweeper.Root;
	
	public class GameSettingsView extends Sprite
	{
		private const BEGINNER:String = "You cannot lose...";
		private const INTERMEDIATE:String = "You can win!";
		private const EXPERT:String = "Hasta la vista, baby!";
		private const LEVELS:Vector.<String> = new <String>[BEGINNER,INTERMEDIATE,EXPERT];
		private const DEFINED_LEVELS_TEXT:String = "Choose a predefined level:";
		private const CUSTOM_LEVEL_TEXT:String = "Or choose custom settings:";
		private var chooseLevelButton:Vector.<Button>;
		private var nbLevels:int;
		private var customSettingsView:CustomGameSettingsView;
		private const RANDOM_SETTINGS_TEXT:String = "Randomize";
		
		public function GameSettingsView()
		{
			customSettingsView = new CustomGameSettingsView();
			customSettingsView.setSettings(Root.settings);
			customSettingsView.setSize(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT/2);
			customSettingsView.setSize(Constants.STAGE_WIDTH,Constants.STAGE_HEIGHT/2);
			customSettingsView.y = Constants.STAGE_HEIGHT/2;
			addChild(customSettingsView);
			
			var definedLevelsLabel:Label = new Label();
			definedLevelsLabel.text = DEFINED_LEVELS_TEXT;
			addChild(definedLevelsLabel);
			definedLevelsLabel.x = 0;
			definedLevelsLabel.y = 0;
			
			var customLevelsLabel:Label = new Label();
			customLevelsLabel.text = CUSTOM_LEVEL_TEXT;
			addChild(customLevelsLabel);
			customLevelsLabel.x = 0;
			
			nbLevels = LEVELS.length;
			chooseLevelButton = new Vector.<Button>();
			for(var i:int = 0 ; i < nbLevels ; i++){
				var button:Button = new Button();
				button.x = Constants.STAGE_WIDTH/2;
				button.y = Constants.STAGE_HEIGHT*(0.05+0.10*i);
				
				button.label = LEVELS[i];
				button.addEventListener(TouchEvent.TOUCH,onLevelButton);
				this.chooseLevelButton[i] = button;
				addChild(button);
			}
			var randomButton:Button = new Button();
			randomButton.label = RANDOM_SETTINGS_TEXT;
			randomButton.x = Constants.STAGE_WIDTH/2;
			randomButton.y = Constants.STAGE_HEIGHT*(0.05+0.10*3);
			randomButton.addEventListener(TouchEvent.TOUCH,onRandomButton);
			addChild(randomButton);
			
			customLevelsLabel.y = Constants.STAGE_HEIGHT*0.10+randomButton.y;
			
		}
		
		private function onRandomButton(event:TouchEvent):void{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED);
			if(touch) {
				customSettingsView.setSettings(new RandomGameSettings());
			}
		}
		
		private function onLevelButton(event:TouchEvent):void{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED);
			if(touch) {
				var button:Button = event.currentTarget as Button;
				if(button) customSettingsView.setSettings(Constants.LEVELS_SETTINGS[LEVELS.indexOf(button.label)]);
			}
			
			
		}
	}
}