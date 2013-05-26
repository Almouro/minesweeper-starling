package com.zyab.minesweeper.models
{
	import com.zyab.minesweeper.utils.Coord;
	
	//Contains all the data from a single tile
	
	public class TileModel
	{
		private var _minesAround:int;
		private var _isMine:Boolean;
		private var _isFlagged:Boolean;
		private var _hidden:Boolean;
		private var _positionOnMap:Coord;
		private var _i:int,_j:int;
		
		public function TileModel(i:int,j:int)
		{
			isFlagged = false;
			isMine = false;
			hidden = true;
			_minesAround = 0;
			this._i = i;
			this._j = j;
		}

		public function get isFlagged():Boolean
		{
			return _isFlagged;
		}

		public function set isFlagged(value:Boolean):void
		{
			_isFlagged = value;
		}

		public function get isMine():Boolean
		{
			return _isMine;
		}

		public function set isMine(value:Boolean):void
		{
			_isMine = value;
		}

		public function get minesAround():int
		{
			return _minesAround;
		}

		public function addMineAround():void
		{
			_minesAround ++;
		}

		public function get hidden():Boolean
		{
			return _hidden;
		}
		
		
		public function set hidden(value:Boolean):void
		{
			_hidden = value;
		}

		public function get positionOnMap():Coord
		{
			return _positionOnMap;
		}

		public function set positionOnMap(value:Coord):void
		{
			_positionOnMap = value;
		}

		public function get j():int
		{
			return _j;
		}

		public function set j(value:int):void
		{
			_j = value;
		}

		public function get i():int
		{
			return _i;
		}

		public function set i(value:int):void
		{
			_i = value;
		}


	}
}