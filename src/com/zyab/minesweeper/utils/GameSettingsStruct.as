package com.zyab.minesweeper.utils
{
	public class GameSettingsStruct
	{
		public var width:int;
		public var height:int;
		public var nbMines:int;
		
		public function GameSettingsStruct(width:int,height:int,nbMines:int){
			this.height = height;
			this.width = width;
			this.nbMines = nbMines;
		}
	}
}