package com.zyab.minesweeper.views
{
	import com.zyab.minesweeper.Constants;
	import com.zyab.minesweeper.Root;
	import com.zyab.minesweeper.events.EventsList;
	import com.zyab.minesweeper.events.GameEvents;
	import com.zyab.minesweeper.utils.Coord;
	
	import flash.geom.Point;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameView extends Sprite
	{
		private const BUTTON_SIZE:int = Constants.STAGE_HEIGHT/10;
		private var stateButton:StateButtonView;
		private var labelSupposedNbMinesLeft:Label;
		private var settingsButton:Button;
		private var _map:MapView;
		private var isScrolling:Boolean;
		
		//I do not know why but when the map is initialized the container dispatches event.scroll even if we do not touch the mouse
		// This this variable used in the event listener of the event event.scroll of the container
		private var firstScrolling:Boolean;
		
		public static const TILE_SIZE:int = 32;
		
		public function GameView()
		{	
			_map = new MapView();
			initMapInContainer();
			initStateButton();
			initLabelSupposedNbMinesLeft();
			initSettingsButton();
			firstScrolling = true;
		}
		
		public function initMapInContainer():void{
			//Init listeners
			map.addEventListener(TouchEvent.TOUCH,this.onMapNormalTouch);
			
			//Container
			var container:ScrollContainer = new ScrollContainer();
			map.x=0;
			map.y = 0;
			container.addChild(map);
			container.width = Constants.STAGE_WIDTH;
			container.height = Constants.STAGE_HEIGHT-BUTTON_SIZE*2;
			container.x = 0;
			container.y = BUTTON_SIZE;
			container.addEventListener(Event.SCROLL,function(e:Event):void{
				if(firstScrolling)
					firstScrolling = false;
				else isScrolling = true;
			});
			container.addEventListener(FeathersEventType.SCROLL_COMPLETE,function(e:Event):void{trace("Ending scrolling");isScrolling = false});
			isScrolling = false;
			this.addChild( container );
		}
		
		public function initSettingsButton():void{
			settingsButton = new Button();
			settingsButton.x = Constants.STAGE_WIDTH/2;
			settingsButton.label = "Settings";
			settingsButton.addEventListener(TouchEvent.TOUCH,onSettingsButton);
			addChild(settingsButton);
		}
		
		private function onSettingsButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
			if (touch){
				dispatchEventWith(EventsList.SETTINGS,true);
			}
		}
		
		public function initStateButton():void{
			var statesIcon:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			statesIcon.push(new Image(Root.assets.getTexture("mine")),new Image(Root.assets.getTexture("flag")));
			stateButton = new StateButtonView(statesIcon);
			stateButton.validate();
			stateButton.x = (Constants.STAGE_WIDTH-BUTTON_SIZE);
			stateButton.y = (Constants.STAGE_HEIGHT-BUTTON_SIZE);
			addChild(stateButton);
			stateButton.addEventListener(TouchEvent.TOUCH,onButtonTouch);
		}

		public function initLabelSupposedNbMinesLeft():void{
			labelSupposedNbMinesLeft = new Label();
			labelSupposedNbMinesLeft.x = 0;
			labelSupposedNbMinesLeft.y = 0;
			this.addChild(labelSupposedNbMinesLeft);
		}
		
		private function  onMapNormalTouch (event:TouchEvent):void{
			
			var touch:Touch = event.getTouch(this.map, TouchPhase.ENDED);
			if (touch && !isScrolling)
			{
				var coord:Point = touch.getLocation(this.map);
				var i:int = coord.x/TILE_SIZE;
				var j:int = coord.y/TILE_SIZE;
				dispatchEventWith(GameEvents.MAP_NORMAL_TOUCH,false,new Coord(i,j));
			}
		}
		
		public function changeClickingState(event:Event):void{
			var state:int = event.data as int;
			trace("GameView changing icon state to " + state );
			stateButton.changeState(state);
		}
		
		public function showGameOver(event:Event):void{
			// Display a game over view which could change, according to score, etc.
			removeChild(this.settingsButton,true);
			var gameOverView:GameOverView = new GameOverView();
			addChild(gameOverView);
		}
		
		public function showWin(event:Event):void{
			removeChild(this.settingsButton,true);
			var winView:WinView = new WinView();
			addChild(winView);
		}
		
		public function updateSupposedMinesLeft(event:Event):void{
			var supposedNbMinesLeft:int = event.data as int;
			if(supposedNbMinesLeft){
				labelSupposedNbMinesLeft.text = ""+supposedNbMinesLeft;
			}
		}
		
		private function onButtonTouch(event:TouchEvent):void{
			var touch:Touch = event.getTouch(this.stateButton, TouchPhase.ENDED);
			if (touch){
				trace("Click on the state button");
				dispatchEventWith(GameEvents.CHANGE_CLICKING_STATE);
			}
		}

		public function get map():MapView
		{
			return _map;
		}

	}
}