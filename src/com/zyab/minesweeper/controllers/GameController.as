package com.zyab.minesweeper.controllers
{
	import com.zyab.minesweeper.models.GameModel;
	import com.zyab.minesweeper.utils.Coord;
	
	import starling.events.Event;

	public class GameController
	{		
		private var gameModel:GameModel;
		
		public function GameController(gameModel:GameModel)
		{
			this.gameModel = gameModel;
		}
		
		public function init():void{
			gameModel.create();
		}
		
		public function gameOver():void{
			//Things to do
			//For instance stop timer...
			//Then end (for now, there is only end)
			trace("Game really over! (no kidding)");
		}
		
		public function changeState():void
		{
			trace("Changing clicking state in gameController");
			this.gameModel.changeClickingState();
		}
		
		public function onMapTouched(event:Event):void{
			var coord:Coord = event.data as Coord;
			if(gameModel.isGameOver)
				return;
			if(coord){
				trace("A click has been made. Current click state: "+gameModel.getClickingState());
				if(gameModel.getClickingState() == 0 && !gameModel.isFlagged(coord)){
					gameModel.reveal(coord.x,coord.y);
					if(gameModel.isMineAt(coord.x,coord.y)){
						gameModel.revealAllMines();
						gameModel.curseWrongFlags();
						gameModel.gameOver();
					}
					else if(gameModel.getNbTilesWithoutMineLeft() == 0){
						gameModel.win();
					}
				}
				else if(gameModel.getClickingState() == 1){
					if(gameModel.isFlagged(coord))
						gameModel.removeFlag(coord);
					else gameModel.putFlag(coord);
				}
			}
		}		
	}
}