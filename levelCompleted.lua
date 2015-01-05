
--highscoreHandler = require("highscoreHandler")
local composer = require("composer")
scene = composer.newScene()

display.setStatusBar(display.HiddenStatusBar)


-- Globals
_W = display.contentWidth
_H = display.contentHeight
_X = _W*.5
_Y = _H*.5
icon = {} 
star = {} 

-- Locals 

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

print("levelcompleted")





-- "scene:create()"
function scene:create( event )
   print("scene:create")
   local sceneGroup = self.view

   local background = display.newImage( sceneGroup, "images/blue-sunbeam-background.jpg", _X, _Y, false )


   -- Initialize the scene here.
   -- Example: adAd display objects to "sceneGroup", add touch listeners, etc.
   return true
end

-- "scene:show()"
function scene:show( event )
   print("on scene:show levelCompleted")
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      print("scene:show - did")
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.

      print ("Level completed!!!")

      local function appearEffect (obj)
          obj.alpha = 0
          obj.yScale = 0.1
          obj.xScale = 0.5
          transition.to( obj, { time=1000, alpha=1, xScale=1, yScale=1, transition=easing.inOutExpo } )
      end

      local stars = display.newImage(sceneGroup, "images/star_full.png", _X, _Y, false)
      appearEffect(stars)

      local function gotoMenu()
         display.remove( stars )
         display.remove(sceneGroup)
         sceneGroup = nil
         options = {
            effect = "fade",
            time = 100,
            params = { 
               levelid = levelid,
               iconid = iconid,
            }
         }
         composer.gotoScene( "menu", options )
      end

      timer.performWithDelay( 3000, gotoMenu )


   end
   return true
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
         display.remove(sceneGroup)
         sceneGroup = nil

   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
   --btn:removeEventListener( "touch", forward )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene


