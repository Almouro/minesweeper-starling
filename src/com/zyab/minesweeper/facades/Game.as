package com.zyab.minesweeper.facades
{
	import com.zyab.minesweeper.Root;
	import com.zyab.minesweeper.controllers.GameController;
	import com.zyab.minesweeper.events.GameEvents;
	import com.zyab.minesweeper.models.GameModel;
	import com.zyab.minesweeper.utils.GameSettingsStruct;
	import com.zyab.minesweeper.views.GameView;
	
	import starling.display.Sprite;

	public class Game extends Sprite
	{		
		//Model-view-controller
		private var gameModel:GameModel;
		private var gameView:GameView;
		private var gameController:GameController;
		
		public function Game()
		{			
			var settings:GameSettingsStruct = Root.settings;
			
			gameView = new GameView();
			addChild(gameView);
			gameModel = new GameModel(settings);
			gameController = new GameController(gameModel);
			
			//Listeners
			
			//From model to view
			gameModel.addEventListener(GameEvents.GAME_OVER,gameView.showGameOver);
			gameModel.addEventListener(GameEvents.THIS_IS_A_WIN,gameView.showWin);
			gameModel.addEventListener(GameEvents.CHANGE_CLICKING_ICON,gameView.changeClickingState);
			gameModel.addEventListener(GameEvents.CHANGE_SUPPOSED_NBMINESLEFT,gameView.updateSupposedMinesLeft);
			gameModel.addEventListener(GameEvents.CREATE_MAP,gameView.map.createMap);
			gameModel.addEventListener(GameEvents.REVEAL_TILE,gameView.map.revealTileHandler);
			gameModel.addEventListener(GameEvents.CORRECT_FLAG,gameView.map.flagWasCorrect);
			gameModel.addEventListener(GameEvents.WRONG_FLAG,gameView.map.flagWasWrong);
			gameModel.addEventListener(GameEvents.FLAG_TILE,gameView.map.flag);
			gameModel.addEventListener(GameEvents.REMOVE_FLAG_TILE,gameView.map.unflag);
			
			//From controller to listener
			gameView.addEventListener(GameEvents.MAP_NORMAL_TOUCH,gameController.onMapTouched);
			gameView.addEventListener(GameEvents.MAP_ANTI_NORMAL_TOUCH,gameController.onMapTouched);
			gameView.addEventListener(GameEvents.CHANGE_CLICKING_STATE,gameController.changeState);
			
			gameController.init();
			gameModel.removeEventListeners(GameEvents.CREATE_MAP);
		}
		
		public function show():Sprite{
			return this.gameView;
		}
	}
}