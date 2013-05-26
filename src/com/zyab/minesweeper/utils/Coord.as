package com.zyab.minesweeper.utils
{
	//Structure Point but with int and not numbers
	
	public class Coord
	{
		public var x:int;
		public var y:int;
		
		public function Coord(x:int,y:int)
		{
			this.x = x;
			this.y = y;
		}
		
		public function toString():String{
			return "("+x+","+y+")";
		}
		
		public function equals(coord:Coord):Boolean{
			return this.x == coord.x && this.y == coord.y;
		}
	}
}