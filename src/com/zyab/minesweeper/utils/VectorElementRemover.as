package com.zyab.minesweeper.utils
{
	//I do not know yet how to make <T> parameters like in Java to generalize
	public class VectorElementRemover
	{
		public static function remove(vector:Vector.<Coord>,element:Coord):void{
			var length:int = vector.length;
			for(var i:int = 0 ; i < length ; i++){
				if(vector[i].equals(element)){
					vector.splice(i,1);
					return;
				}
			}			
		}
	}
}