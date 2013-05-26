package com.zyab.minesweeper.views{
	
	// Displayed when user loses the game
	public class GameOverView extends EndView{
		public function GameOverView(){
			this.text = "You die!";
			this.playAgain = "Resurrect and try again?";
			init();
		}
	}
	
}