package com.zyab.minesweeper.views
{	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;

	import starling.utils.Color;
	import com.zyab.minesweeper.Root;
	
	public class TileView extends Sprite
	{
		
		//Names of textures:
		//Background of textures if tile is not revealed
		private const NOT_REVEALED_BACKGROUND:String = "notRevealedBackground";
		
		private const REVEALED_BACKGROUND:String = "revealedBackground";
		private const MINE:String = "mine";
		private const FLAG:String = "flag";
		
		//Colors for displaying number of mines around
		public static const COLORS:Vector.<uint> = Vector.<uint>([Color.BLUE,Color.GREEN,Color.RED,Color.FUCHSIA,Color.PURPLE,Color.MAROON,Color.GRAY,Color.BLACK]);
		
		public function TileView(i:int,j:int)
		{
			addImage(NOT_REVEALED_BACKGROUND);
			setPosition(i,j);
		}
		
		public function addText(minesAround:int):void{
			addChild(new TextField(GameView.TILE_SIZE, GameView.TILE_SIZE, ""+minesAround, "Arial", 24/32*GameView.TILE_SIZE, COLORS[minesAround-1]));
		}
		
		public function addMineImage():void{
			addImage(MINE);
		}
		
		public function setPosition(i:int,j:int):void{
			x = i*GameView.TILE_SIZE;
			y = j*GameView.TILE_SIZE;
		}
		
		public function flag():void{
			addChild(new Image(Root.assets.getTexture("flag")));	
		}
		
		public function unflag():void{
			trace("Flag removed");
			removeChildAt(this.numChildren-1);	
		}
		
		public function addRevealedBackground():void
		{
			addImage(REVEALED_BACKGROUND);	
		}
		
		private function addImage(textureName:String):void{
			var image:Image = new Image(Root.assets.getTexture(textureName));
			if(image) addChild(image);
		}
	}
}