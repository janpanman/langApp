
--highscoreHandler = require("highscoreHandler")
local composer = require("composer")
scene = composer.newScene()

display.setStatusBar(display.HiddenStatusBar)


-- Globals
_W = display.contentWidth
_H = display.contentHeight


-- Locals 

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------
composer.gotoScene("mainmenu")
--composer.gotoScene("resolution")