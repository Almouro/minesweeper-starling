package com.zyab.minesweeper.views
{
	public class MenuView extends EndView
	{
		public function MenuView()
		{
			this.text = "Minesweeper";
			this.playAgain = "Start";
			
			//playAgain will start game with random settings or with previous settings
			
			init();
			//Can't get it to the middle, grrr...
		}
	}
}