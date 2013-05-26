package com.zyab.minesweeper.models
{
	import com.zyab.minesweeper.events.GameEvents;
	import com.zyab.minesweeper.utils.Coord;
	import com.zyab.minesweeper.utils.GameSettingsStruct;
	import com.zyab.minesweeper.utils.VectorElementRemover;
	
	import starling.events.EventDispatcher;
	
	//Contains all the data of the game
	
	public class GameModel extends EventDispatcher
	{
		private var settings:GameSettingsStruct;
		
		// What is done if you touch the map
		// 0 -> normal touch
		// 1 -> flag
		private var currentClickingState:int;
		private var nbClickingStates:int;
		public const clickingStates:Vector.<String> = new <String>["normalClick","putFlag"];
		
		// supposedNbMinesLeft = nbMines - nbFlags
		private var supposedNbMinesLeft:int;
		
		// when this reaches 0 the game is won
		private var nbTilesWithoutMineLeft:int;
		
		private var nbFlags:int;
		private var firstClick:Boolean;
		private var _isGameOver:Boolean;
		
		private var map:Vector.<Vector.<TileModel>>;
		
		private var listMines:Vector.<Coord>;
		private var listFlags:Vector.<Coord>;
		
		public function GameModel(settings:GameSettingsStruct)
		{
			this.settings = settings;
			
			nbFlags = 0;
			firstClick = true;
			_isGameOver = false;
			
			map = new Vector.<Vector.<TileModel>>();
			listFlags = new Vector.<Coord>;
			listMines = new Vector.<Coord>();
			
			currentClickingState = 0;
			nbClickingStates = clickingStates.length;
		}
		
		public function create():void{
			trace("Creating mapModel");
			for(var i:int = 0 ; i < settings.width ; i++){
				map[i] = new Vector.<TileModel>();
				for(var j:Number = 0 ; j < settings.height ; j++) {
					map[i][j] = new TileModel(i,j);
					//trace("Created tileModel "+i+"-"+j);
				}
			}
			trace("Created mapModel");
			dispatchEventWith(GameEvents.CREATE_MAP,false, settings);
			setSupposedNbMinesLeft(settings.nbMines);
			this.nbTilesWithoutMineLeft = settings.width*settings.height - settings.nbMines;
		}
		
		public function reveal(i:int,j:int):void{
			if(firstClick){
				placeMines(i,j);
				firstClick = false;
				reveal(i,j);
			}
			else{
				var tile:TileModel = map[i][j];
				if(tile.hidden){
					if(!tile.isMine) {
						nbTilesWithoutMineLeft--;
					}
					tile.hidden = false;
					dispatchEventWith(GameEvents.REVEAL_TILE,false,tile);
					//trace("Tile "+i+"//"+j+" revealed!");
					if(tile.minesAround == 0 && !tile.isMine){
						revealNeighboursAround(i,j);
					}
				}
			}
		}
		
		public function getNbTilesWithoutMineLeft():int{
			return this.nbTilesWithoutMineLeft;
		}
		
		public function revealAllMines():void{
			//for each is said to be a bit greedy so let's use an old-fashioned for
			var listMinesLength:int = this.listMines.length;
			for(var i:int = 0 ; i < listMinesLength ; i++){
				var coord:Coord = this.listMines[i];
				var mine:TileModel = map[coord.x][coord.y];
				reveal(coord.x,coord.y);
				if(mine.isFlagged)
					flagWasCorrect(coord);
			}
		}
		
		public function curseWrongFlags():void{
			var listFlagsLength:int = this.listFlags.length;
			for(var i:int = 0 ; i < listFlagsLength ; i++){
				var coord:Coord = listFlags.shift();
				dispatchEventWith(GameEvents.WRONG_FLAG,false,coord);
			}
		}
		
		private function flagWasCorrect(coord:Coord):void{
			dispatchEventWith(GameEvents.CORRECT_FLAG,false,coord);
			VectorElementRemover.remove(listFlags,coord);
		}
		
		public function gameOver():void{
			trace("Game Over!");
			_isGameOver = true;
			dispatchEventWith(GameEvents.GAME_OVER);
		}
		
		public function isMineAt(i:int,j:int):Boolean{
			return map[i][j].isMine;
		}
		
		private function placeMines(click_i:int,click_j:int):void{
			var remainingTiles:Vector.<Coord> = new Vector.<Coord>();
			
			//Initialize list of possible tiles for a main -> excluding 9 tiles around the first click
			//That way, player can't lose at first click!
			for(var i:int = 0 ; i < settings.width ; i++){
				for(var j:int = 0 ; j < settings.height ; j++) {
					var coord:Coord = new Coord(i,j);
					if( i < click_i-1 || i > click_i+1 || j < click_j-1 || j > click_j+1){
						remainingTiles.push(coord);
					}
				}
			}
			
			var nbRemainingTiles:int = remainingTiles.length;
			var numberMines:int = settings.nbMines;
			while(numberMines > 0){
				var index:int = int(Math.random()*nbRemainingTiles);
				coord = remainingTiles[index];
				map[coord.x][coord.y].isMine = true;
				//trace("Mine placed at "+coord.toString());
				notifyMineToTilesAround(coord.x,coord.y);
				remainingTiles.splice(index,1);
				numberMines--;
				nbRemainingTiles--;
				listMines.push(coord);			
			}
		}
		
		//If the tile has no mine around, then reveal its neighbours.
		public function revealNeighboursAround(i:int,j:int):void
		{			
			for(var k:Number = Math.max(0,i-1) ; k <= Math.min(settings.width-1,i+1) ; k++)
				for(var l:Number = Math.max(0,j-1) ; l <= Math.min(settings.height-1,j+1); l++)
					if(k != i || l != j)
						reveal(k,l);
		}
		
		// Whenever a mine is added somewhere, notify all its neighbours
		// Since a bit repetitive with notifyEmptyTiles previously seen, an event could solve the problem (used as if we passed a function as an argument)
		private function notifyMineToTilesAround(i:int,j:int):void{
			for(var k:Number = Math.max(0,i-1) ; k <= Math.min(settings.width-1,i+1) ; k++)
				for(var l:Number = Math.max(0,j-1) ; l <= Math.min(settings.height-1,j+1); l++)
					if(k != i || l != j)
						map[k][l].addMineAround();
		}
		
		public function isFlagged(coord:Coord):Boolean{
			return map[coord.x][coord.y].isFlagged;
		}
		
		public function removeFlag(coord:Coord):void
		{
			var tile:TileModel = map[coord.x][coord.y];
			if(tile.hidden){
				tile.isFlagged = !tile.isFlagged;
				dispatchEventWith(GameEvents.REMOVE_FLAG_TILE,false,coord);
				listFlags.splice(listFlags.indexOf(coord),1);
				setSupposedNbMinesLeft(this.supposedNbMinesLeft+1);
			}
		}
		
		//Hmm seems a bit repetitive... Would have to work on that
		public function putFlag(coord:Coord):void
		{
			if(firstClick) return;
			var tile:TileModel = map[coord.x][coord.y];
			if(tile.hidden){
				listFlags.push(coord);
				tile.isFlagged = !tile.isFlagged;
				dispatchEventWith(GameEvents.FLAG_TILE,false,coord);
				setSupposedNbMinesLeft(this.supposedNbMinesLeft-1);
			}
		}
		
		public function setSupposedNbMinesLeft(nbMines:int):void
		{
			this.supposedNbMinesLeft = nbMines;
			dispatchEventWith(GameEvents.CHANGE_SUPPOSED_NBMINESLEFT,false,this.supposedNbMinesLeft);
		}
		
		public function getClickingState():int{
			return this.currentClickingState;
		}
		
		public function changeClickingState():void
		{
			currentClickingState++;
			if(currentClickingState >= nbClickingStates)
				currentClickingState = 0;
			dispatchEventWith(GameEvents.CHANGE_CLICKING_ICON,false,currentClickingState);
		}
		
		public function isHidden(coord:Coord):Boolean{
			return this.map[coord.x][coord.y].hidden;
		}
		
		public function win():void
		{
			//Could dispatch score or time elapsed...
			dispatchEventWith(GameEvents.THIS_IS_A_WIN);
		}
		
		public function get isGameOver():Boolean
		{
			return _isGameOver;
		}
		
	}
	
}