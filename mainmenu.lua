
--highscoreHandler = require("highscoreHandler")
local composer = require("composer")
gf = require "globalFunctions"

scene = composer.newScene()

display.setStatusBar(display.HiddenStatusBar)


-- Globals
require("resolution")

icon = {} 
star = {} 

-- Locals 

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

--print("mainmenu1")





-- "scene:create()"
function scene:create( event )
   print("scene:create")
   local sceneGroup = self.view
   local bg = gf:createBackground(sceneGroup, "images/blue-sunbeam-background.jpg", _X ,_Y )
   return true

end

-- "scene:show()"
function scene:show( event )
   print("on scene:show mainmenu")
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      print("scene:show - did")
      -- Called when the scene is now on e
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.


      if dog == nill then 
         print("dog == nill,.. creating a new one")
         local dog = gf:createDog(sceneGroup, "images/casper.jpg", 80, 80)
      else 
         print("dog already exist,.. ")
      end

      local btn0 = display.newImageRect( sceneGroup, "images/menu1-1.png", 180, 80 )
      local btn1 = display.newImageRect( sceneGroup, "images/menu1-3.png", 180, 80 )
      local btn2 = display.newImageRect( sceneGroup, "images/menu3-1.png", 180, 80 )

      btn0.x = _X
      btn0.y = _Y*0.35
      btn0.id = 0
      btn1.x = _X
      btn1.y = _Y
      btn1.id = 1
      btn2.x = _X
      btn2.y = _Y*1.65
      btn2.id = 2

      local options1 = {
         effect = "fade",
         time = 100,
         params = {
            levelid = "l1",
            prev = "mainmenu"
         }
      }

      local options2 = {
         effect = "fade",
         time = 100,
         params = {
            levelid = "l2",
            prev = "mainmenu"
         }
      }


      function forward (event)
         local t = event.target 
         local phase = event.phase

         if (phase == "began" ) then
            if (t.id == 1 ) then 
               print ("going forward goto game using options 1")
               -- timer.cancel( dogJumpTimer )
               --display.remove(dog)
               btn1:removeEventListener( "touch", forward )
               btn2:removeEventListener( "touch", forward )
               composer.gotoScene("menu", options1)
            elseif (t.id == 2 ) then 
               print ("going forward goto game using options 2")

               btn1:removeEventListener( "touch", forward )
               btn2:removeEventListener( "touch", forward )
               composer.gotoScene("menu", options2 )
            end 
         end
         
         return true
      end
      
      btn1:addEventListener( "touch", forward )
      btn2:addEventListener( "touch", forward )



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
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
   btn:removeEventListener( "touch", forward )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene


