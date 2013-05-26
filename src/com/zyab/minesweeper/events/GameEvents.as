package com.zyab.minesweeper.events
{
	public class GameEvents
	{
		//Events from model to view
		public static const CREATE_MAP:String = "createMap";
		public static const REVEAL_TILE:String = "revealTile";
		public static const GAME_OVER:String = "clickOnAMine";
		public static const THIS_IS_A_WIN:String = "weAreTheChampions";
		public static const  FLAG_TILE:String = "flagTile";
		public static const  REMOVE_FLAG_TILE:String = "removeFlagTile";
		public static const CORRECT_FLAG:String = "correctFlag";
		public static const WRONG_FLAG:String = "wrongFlag";
		public static const CHANGE_CLICKING_ICON:String = "changeClickingState";
		public static const CHANGE_SUPPOSED_NBMINESLEFT:String = "changeSupposedNbMinesLeft";
		
		//Event view to controller
		public static const MAP_NORMAL_TOUCH:String = "normalTouchOnMap";
		public static const MAP_ANTI_NORMAL_TOUCH:String = "antiNormalTouch";
		public static const CHANGE_CLICKING_STATE:String = "changeState";
	}
}