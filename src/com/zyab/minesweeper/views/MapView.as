package com.zyab.minesweeper.views
{		
	import com.zyab.minesweeper.models.TileModel;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	import com.zyab.minesweeper.utils.Coord;
	import com.zyab.minesweeper.utils.GameSettingsStruct;
	
	//Class "inside" GameView, corresponding only to the minesweeper map
	
	public class MapView extends Sprite
	{		
		private var map:Vector.<Vector.<TileView>>;
		
		public function MapView()
		{
			map = new Vector.<Vector.<TileView>>();
		}
		
		public function createMap(event:Event):void{
			var settings:GameSettingsStruct = event.data as GameSettingsStruct;
			if(settings){
			trace("Creating mapView");
			for(var i:int = 0 ; i < settings.width ; i++){
				map[i] = new Vector.<TileView>();
				for(var j:int = 0 ; j < settings.height ; j++){
					var tile:TileView = new TileView(i,j);
					map[i][j]=tile;
					addChild(map[i][j]);
					//trace("Created tileView "+i+"-"+j);
				}
			}
			trace("Created mapView");
			}
			else trace("Error: mapView not created because event data was sent was not appropriate");
		}
		
		public function flagWasCorrect(event:Event):void{
			trace("flag "+Coord(event.data).toString() + " was right");
			checkFlag(event,new Quad(GameView.TILE_SIZE/2,GameView.TILE_SIZE/2,Color.GREEN));
		}
		
		public function flagWasWrong(event:Event):void{
			trace("flag "+Coord(event.data).toString() + " was wrong");
			checkFlag(event,new Quad(GameView.TILE_SIZE/2,GameView.TILE_SIZE/2,Color.RED));
		}
		
		private function checkFlag(event:Event,img:DisplayObject):void{
			var coord:Coord = event.data as Coord;
			if(coord){
				map[coord.x][coord.y].addChild(img);
			}
		}
		
		public function revealTileHandler(event:Event):void{
			var tile:TileModel = event.data as TileModel;
			if(tile){
				revealTile(tile);
			}
		}
		
		public function revealTile(tileModel:TileModel):void{
			var tileView:TileView = map[tileModel.i][tileModel.j];
			tileView.removeChildren(0,-1,true);
			tileView.addRevealedBackground();
			//trace("View: Mines around: "+tileModel.minesAround);
			if(tileModel.isMine){tileView.addMineImage();}
			else if(tileModel.minesAround > 0){
				tileView.addText(tileModel.minesAround);
			}
		}
		
		public function flag(event:Event):void{
			var coord:Coord = event.data as Coord;
			if(coord) map[coord.x][coord.y].flag();
		}
		
		public function unflag(event:Event):void{
			var coord:Coord = event.data as Coord;
			if(coord) map[coord.x][coord.y].unflag();
		}
	}
}