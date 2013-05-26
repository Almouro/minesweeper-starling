package com.zyab.minesweeper.models
{
	import com.zyab.minesweeper.utils.GameSettingsStruct;
	
	public class RandomGameSettings extends GameSettingsStruct
	{
		public function RandomGameSettings()
		{
			var min:int = 3;
			var max:int = 30;
			var width:int = Math.random()*(max-min+1)+min;
			var height:int = Math.random()*(max-min)+min;
			var nbMines:int = Math.pow(Math.random(),1.5)*width*height;
			super(width, height, nbMines);
		}
	}
}