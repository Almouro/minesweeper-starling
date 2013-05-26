package com.zyab.minesweeper
{    
    import com.zyab.minesweeper.events.EventsList;
    
    import com.zyab.minesweeper.facades.Game;
    
    import com.zyab.minesweeper.themes.MetalWorksMobileTheme;
    
    import com.zyab.minesweeper.models.RandomGameSettings;
    
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    
    import com.zyab.minesweeper.utils.GameSettingsStruct;
    import com.zyab.minesweeper.utils.ProgressBar;
    
    import com.zyab.minesweeper.views.GameOverView;
    import com.zyab.minesweeper.views.GameSettingsView;
    import com.zyab.minesweeper.views.MenuView;

    /** The Root class is the topmost display object in your game. It loads all the assets
     *  and displays a progress bar while this is happening. Later, it is responsible for
     *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
     *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
     *  controls the high level behaviour of your game. */
    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
		private var mActiveScene:Sprite;
		private var theme:MetalWorksMobileTheme;
		
		public static var settings:GameSettingsStruct;
        
        public function Root()
        {
            addEventListener(EventsList.START_GAME, onStartGame);
            //addEventListener(EventsList.GAME_OVER,  onGameOver);
			addEventListener(EventsList.SETTINGS,onSettings);
            
            // not more to do here -- Startup will call "start" immediately.
        }
        
        public function start(background:Texture, assets:AssetManager):void
        {
            // the asset manager is saved as a static variable; this allows us to easily access
            // all the assets from everywhere by simply calling "Root.assets"
            sAssets = assets;
            
            // The background is passed into this method for two reasons:
            // 
            // 1) we need it right away, otherwise we have an empty frame
            // 2) the Startup class can decide on the right image, depending on the device.
			
			// Load the feathers theme
			this.theme = new MetalWorksMobileTheme( this.stage );
            
            // The AssetManager contains all the raw asset data, but has not created the textures
            // yet. This takes some time (the assets might be loaded from disk or even via the
            // network), during which we display a progress indicator. 
            
            var progressBar:ProgressBar = new ProgressBar(175, 20);
            progressBar.x = (Constants.STAGE_WIDTH - progressBar.width)  / 2;
            progressBar.y = (Constants.STAGE_HEIGHT - progressBar.height) / 2;
            progressBar.y =Constants.STAGE_HEIGHT * 0.85;
            addChild(progressBar);
            
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                progressBar.ratio = ratio;
                
                // a progress bar should always show the 100% for a while,
                // so we show the main menu only after a short delay. 
                
                if (ratio == 1)
                    Starling.juggler.delayCall(function():void
                    {
                        progressBar.removeFromParent(true);
						// Load default settings for game
						settings = new RandomGameSettings();
						showScene(MenuView);
                    }, 0.05);
            });
        }
        
        private function onGameOver(event:Event, score:int):void
        {
            trace("Game Over! Score: " + score);
            addScene(GameOverView);
        }
        
        private function onStartGame(event:Event,newSettings:GameSettingsStruct = null):void
        {
            trace("Game starts");
			if(newSettings != null) settings = newSettings;
			showScene(Game);
        }
		
		private function onSettings(event:Event):void{
			showScene(GameSettingsView);
		}
        
        private function showScene(screen:Class):void
        {
            if (mActiveScene) mActiveScene.removeFromParent(true);
            mActiveScene = new screen();
            addChild(mActiveScene);
        }
		
		private function addScene(view:Class):void
		{
			mActiveScene.addChild(new view());
		}
        
        public static function get assets():AssetManager { return sAssets; }
    }
}