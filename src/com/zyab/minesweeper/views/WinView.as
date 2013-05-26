package com.zyab.minesweeper.views
{
	// Displayed when user win the game!
	
	public class WinView extends EndView
	{
		public function WinView()
		{
			this.text = "You live!";
			this.playAgain = "Try your luck again?";
			init();
		}
	}
}