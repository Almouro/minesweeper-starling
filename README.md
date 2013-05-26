Author: Alexandre Moureaux

AS3 MINESWEEPER GAME
BASED ON STARLING FRAMEWORK

Minesweeper game based on the small base application from Starling called "Scaffold_Mobile", using a bit of Feathers controls.
Of course, using Flash and Starling may be a bit greedy if it is just used for displaying a minesweeper game, but the point was to use new technologies, that FreshPlanet seems to use.



ARCHITECTURE: (scheme on readme.pdf)

The point was also to implement a strong architecture even if it is not really necessary for a small game such as a minesweeper game.
Here MVC pattern was chosen, at least for the game in itself.
(MVC pattern: the game is composed of 3 classes (model, view and controller) initialized by a façade).
the view displays results to the user and listens to user actions to dispatch appropriate events
the controller listens to the view and update the model accordingly to the events received
the model is updated by the controller and then notify changes to the view
In order to remain quite simple, abstract classes were not implemented. Only concrete classes for each part of the design pattern were implemented, according to all the events that can be dispatched (located in GameEvents), and eventslisteners are set by the façade. That way, each part is not entirely independent from one another, but the solution is simplest and easiest to implement.
Root is the top class which switch between scenes: game, menu or settings. 
Actually to simplify coding, menu is extending a class with a title and a button leading to settings and to game (re)starting. Menu is only composed by a view.
GameSettingsView could implement the MVC pattern, but the main focus in the program is the Game in itself, so to be simpler I chose not to.
I chose not to develop much the UI, since I do believe that was not the main concern here as well.

EXAMPLE OF SCENARIO “user click –>  it’s a mine – > game over – > start again”:

Game view detects click on the map from the user
Send to controller an event “MAP_NORMAL_TOUCH”
Controller checks in model the current clicking state, (corresponding to the small icon displayed bottom-right) -> returns 0, i.e. normal click
Controller asks model to reveal the tile
Model reveals tile and dispatch event REVEAL_TILE, so that the view can update its view
Then if it is a mine, controller asks model to reveal all mines.
The model will thus reveal all mines, sending events REVEAL_TILE, so that the view can update, and also sending events corresponding to every correct flags that were put.
The view will or will not add something to the map so that the user can notice which flag was correct.
The controller also asks the model to do check every wrong flags, so that the view can also display something, allowing the user to see that maybe he was wrong somewhere…
Then the controller says to the model that the game is over (the controller will not then block all click attempts except scrolling).
The view updates accordingly, displaying a GameOverView
The user clicks on start again button, the view dispatch a bubbling event “START_GAME”, which mean it will go up the tree previously seen, up to the root, so that the Root can switch between scenes and go to Game.
Game is launched with previous settings, stored by Root.





TO FIX/DO:
	- improve UI, using layouts or something else… Labels in some buttons are not entirely displayed.
	- displaying the tiles may not be optimum (with use of removechild and addchild, but I heard Sprite were better for performance than movie clips
	- performances are not so great actually and are likely to be optimizable
	- launched with background from scaffold_mobile but then Metal theme is loaded and does not really correspond
	- ability to scroll even if GameOverView is shown, just to check where we went wrong
	- zoom feature to implement
	- long press and/or double tap function to implement, to put a flag instead of a normal click and vice-versa
	- check what permissions are asked for during installation (I do believe internet access is asked for even if unnecessary)
	- testing, as it has not been so much tested, it is probable that a few bugs or uncaught exceptions remain
	- …

Thanks you for your attention, if you have any questions, don’t hesitate to ask!


