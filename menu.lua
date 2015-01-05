-- Globals
pos = require("resolution")
highscoreHandler = require("highscoreHandler")
gf = require("globalFunctions")

dict = require("dict.hy")
customFont = dict.f
m=0

local composer = require("composer")
scene = composer.newScene()

print ("== 00. creating pagegroup... ")

local function calcStar(levelArray) 
    --print("Retrieve the score for lbl " .. lbl )
    local starScore = 0
    for n=1, #levelArray do
      starScore = starScore + levelArray[n]
    end
    return starScore     
end


local function createIcons()
    --local sceneGroup = self.view
    local options = {} 
    local star = {}
    local icons = {} 
    local levelTxt = {}
    local levelArray = {} 
    local fontSize = 25

    --print ("Width: " .. _W)
    --print ("Height: " .. _H)
    local count = 0
    local count2 = 0
    for i=1, 2 do
        for j=1,3 do
            count = count +1 
            print ("Counter count,i,j:" ..count .. ",".. i .. "," .. j)
            label = levelid .. count
            print ("score label: " .. label )
            -- display.newRoundedRect( left, top, width, height, cornerRadius )
            
            icon[count] = display.newRoundedRect( 0, 0, 70, 70, 12 )
            pageGroup:insert( icon[count] )
            --icon[count]:insert( pageGroup )
--            icon[count]:insert( sceneGroup )
            icon[count].strokeWidth = 2
            icon[count]:setFillColor( 0, 0, 1 )
            icon[count]:setStrokeColor( 0, 0, 0 )
            levelTxt[count] = display.newText( count , 0, 0, customFont, fontSize)

            -- drop on a 4x3 grid in _W x _H 
            -- local x = i*_W/4
            -- local y = _H* (j*.3) + (j-1) * 30 + _H*.1
            local x = j*_W/4
            local y = _H* (i*.3) + (i-1) * 30 + _H*.1

            icon[count].x = x 
            icon[count].y = y
            icon[count].id = count 
            icon[count].lvl = label
            levelTxt[count].x = x 
            levelTxt[count].y = y 
            pageGroup:insert( levelTxt[count] )
            options[count] = { 
                params = {
                   levelid = levelid,
                   labelid = label,
                   iconid = count, 
                   prev = "menu"
                   }
            }

            local function gotoLevel(event)
               local t = event.target 
               local phase = event.phase

               if (phase == "began" ) then
                  -- if (t.id == 1) then 
                  print ("### going forward goto level: " .. t.lvl .. ", Counter: " .. t.id )
                  icon[count]:removeEventListener( "touch", gotoLevel )
                  --btn2:removeEventListener( "touch", forward )

                  if ( levelid == "l1") then 
                      composer.gotoScene("game", options[t.id])
                      --title = display.newImageRect(  "images/menu1-3.png", 120, 60 )
                  else 
                      composer.gotoScene("game2", options[t.id])
                      --title = display.newImageRect(  "images/menu3-1.png", 120, 60 )
                  end

               end
               
               return true

            end

            icon[count]:addEventListener( "touch", gotoLevel )
            print ("loading the levelScores,.. for level: " .. label)
            levelArray = getLevelScores(label)
            starScore = calcStar(levelArray)

            print ("starScore = " .. starScore )

            -- if starScore = 9+ then 3 full stars
            for s=0,2 do
                count2 = count2 + 1
                print ("count2 = " .. count2 ) 
                --display.newImage( filename [,baseDirectory] [, left, top ] )
                print ("starScore: " .. starScore .. " s = " .. s)
                if (starScore >= 9 ) then 
                    star[count2] = display.newImageRect( "images/star_full.png", 20, 20 )
                elseif (starScore >= 6 and s < 2) then 
                    star[count2] = display.newImageRect( "images/star_full.png", 20, 20 )
                elseif (starScore >= 1 and s < 1 ) then 
                    star[count2] = display.newImageRect( "images/star_full.png", 20, 20 )
                else
                    star[count2] = display.newImageRect( "images/star_empty.png", 20, 20 )
                end 
                star[count2].x = x - 26 + (s * 26) 
                star[count2].y = y + 48
                -- star[count2]:insert( pageGroup )
                pageGroup:insert( star[count2] )
            end   
        end 
    end
    -- return (btn)
end

local function createPage()
    --local sceneGroup = self.view
    highscores = loadHighscores()
    function goBack( event )
        local t = event.target 
        local phase = event.phase

          --disable the event response for a while, to allow the animations to finish
        if (phase == "began" ) then
              --print ("Pressed back button")
              composer.gotoScene("mainmenu" )
              --display.remove(pageGroup)
              --pageGroup = nil 
              --sceneGroup = nil
              --scene:hide()
              back:removeEventListener( "touch", goBack )
        end
        return true        
    end

    back = display.newImageRect(  "images/button_back.png", 90, 30 )
    back.x, back.y = pos.leftSide+5+back.contentWidth*0.5, pos.topSide+5+back.contentHeight*0.5
    --back.x = 0.3 *_H
    --back.y = 0.04 *_W 
    pageGroup:insert( back )
    back:addEventListener( "touch", goBack )

    if ( levelid == "l1") then 
        title = display.newImageRect(  "images/menu1-3.png", 120, 60 )
    else 
        title = display.newImageRect(  "images/menu3-1.png", 120, 60 )
    end
    title.x = 0.7 *_H
    title.y = 0.07 *_W
    pageGroup:insert( title )
    createIcons()
end 



-- "scene:create()"
function scene:create( event )

  print ("== 0. creating pagegroup... ")
   local sceneGroup = self.view
   local bg = gf:createBackground(sceneGroup, "images/blue-sunbeam-background.jpg", _X ,_Y )
   return true
end

-- "scene:show()"
function scene:show( event )
    -- n array, n[1] is the correct nr, n[2] & n[3] are incorrect
    --local n={}
    print ("menu")
    local sceneGroup = self.view
    local phase = event.phase


    if pageGroup == nil then
        print ("== 1. creating pagegroup... ")
        pageGroup = display.newGroup()
    else 
        print ("== 1.1 pageGroup already exist, recreating... ")
         
        display.remove(pageGroup)
        pageGroup = nil
        pageGroup = display.newGroup( )
    end

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        print ("Loading")

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        
        -- Example: start timers, begin animation, play audio, etc.
        params = event.params
        levelid = params.levelid
        print ("Label id = " .. levelid)
        createPage()
    --display.newImageRect( [parentGroup,], filename, [baseDirectory,], width, height )

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
      --remove pageGroup
      print ("== 1. removing pagegroup... ")
      display.remove(pageGroup)
      pageGroup = nil
   end
   return true
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
   return true
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene