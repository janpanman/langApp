-- Globals
pos = require("resolution")
-- highscoreHandler = require("highscoreHandler")

dict = require("dict.hy")
customFont = dict.f
_W = display.contentWidth
_H = display.contentHeight
_X = _W*.5
stop = false
--sceneGroup = display.newGroup()
labelTxt = {}
block = {}
btn = {}
m = 0

-- dislay groups
btnGrp = display.newGroup()
anim = display.newGroup()
pageGrp = display.newGroup()
levelid = ""
icondid = ""

sound = {} 
item = {}

print ("THIS IS GAME 2")

-- Locals 
local composer = require( "composer" )
local scene = composer.newScene()

-- animation 1, greenman
--local sheet = {}
local sheet1 = graphics.newImageSheet( "images/greenman.png", { width=128, height=128, numFrames=15 } )
local sheet2 = graphics.newImageSheet( "images/spritesheet_girl.png", { width=125, height=125, numFrames=16 } )
local sheet3 = graphics.newImageSheet( "images/polara_run_cycle.png", { width=71, height=126, numFrames=9 } )


--- Object effects ----- 
local function appearEffect (obj)
    obj.alpha = 0
    obj.yScale = 0.1
    obj.xScale = 0.5
    transition.to( obj, { time=1000, alpha=1, xScale=1, yScale=1, transition=easing.inOutExpo } )
end


local function slideEffect (obj)
    endX = obj.x
    obj.x = 0
    transition.to( obj, { time=400, x=endX, transition=easing.inOutExpo } )
end

local function wobbleEffect (obj)
    endXScale = obj.xScale
    endYScale = obj.yScale
    transition.to( obj, { time=100, xScale=.8*endXScale, yScale=1.2*endYScale, transition=easing.inOutExpo } )
    transition.to( obj, { time=100, delay=100, xScale=1.15*endXScale, yScale=0.85*endYScale, transition=easing.inOutExpo } )
    transition.to( obj, { time=100, delay=200, xScale=.9*endXScale, yScale=1.1*endYScale, transition=easing.inOutExpo } )
    transition.to( obj, { time=100, delay=300, xScale=1.05*endXScale, yScale=0.95*endYScale, transition=easing.inOutExpo } )
    transition.to( obj, { time=100, delay=400, xScale=0.95*endXScale, yScale=1.05*endYScale, transition=easing.inOutExpo } )
    transition.to( obj, { time=100, delay=500, xScale=endXScale, yScale=endYScale, transition=easing.inOutExpo } )
end


function greenLight()
    print ("Setting the stop flag to: false")
    stop = false
end

function showYellowStar() 
    print("Show new screen + yellow star")
end 


local function updateScore(m,label)
   print ("Updating the score for (count,label): (" .. m .. "," .. label ..")")
   --highscores.l11[m]=1
   --highscores["l11"][m]=1
   --loadsave.saveTable(highscores, "myTable.json", system.DocumentsDirectory)
end

local function handleTouch( event )
    local t = event.target 
    local phase = event.phase
    --[[
    if stop then
        print ("Stop flag = true")
        --timer.performWithDelay( 2000, greenLight )
        return true
    end

    stop = true
    timer.performWithDelay( 1500, greenLight )
    ]]
    --disable the event response for a while, to allow the animations to finish
    print ("Touch event id: " .. t.id)

    if (phase == "began" ) then
        print ("Touched id: " .. t.id)
        if (t.id == 1) then 
                print ("Woowie,.. correct" .. t.id)
                --labelTxt[1]:setFillColor( 1,1,1 )
--                dustEm.x = btn[1].x
--                dustEm.y = btn[1].y
--                PS:startEmitter('pointLoopEm',true)
                --local playsound1 = audio.play( sound[1], { duration=3000, onComplete=enlargeEffect(item[1]) } )
                transition.to( t, { time=1000, xScale=1.3, yScale=1.3 } )
                local playsound1 = audio.play( sound[1], { duration=3000, onComplete=goodAnim(t) } )
                --runAnimation()
                --updateScore(m, labelid)
                --cleanupRestart()
                --timer.performWithDelay( 3000, cleanupRestart ) 
        elseif (t.id == 2 ) then 
                print ("Oppsie,.. wrong" .. t.id)
                local playsound2 = audio.play( sound[2], { duration=3000, onComplete=disapearEffect(t) } )

        elseif (t.id == 3 ) then 
                print ("Oppsie,.. wrong" .. t.id)
                local playsound3 = audio.play( sound[3], { duration=3000, onComplete=disapearEffect(t) } )

        end
    end
    return true        
end


local function handleBtnTouch( event )
    local t = event.target 
    local phase = event.phase
    print ("Touch event id: " .. t.id)

    if (phase == "began" ) then
        print ("Touched id: " .. t.id)
        local playsound1 = audio.play( sound[1] )
    end
    return true        
end




local function createButton (n)
    local fontSize = 25
    
    --print ("Counter i:" .. i)
    btn = display.newGroup()
    local word = dict[tostring(n[1])]
    print ("Sequence: " .. n[1] .. " Pulled string: " .. word)
    
    labelTxt = display.newText( word, 0, 0, customFont, fontSize)
    labelTxt:setFillColor( 0,0,0 )
    block = display.newRoundedRect( 0, 0, 0.6 * fontSize * string.len( word ) - 3 * string.len( word ), 35, 12 )
    block.strokeWidth = 2
    block:setFillColor( 0.6, 0.6, 0.6 )
    block:setStrokeColor( 0, 0, 0 )
    btn:insert( block )
    btn:insert(labelTxt)
    btn.x = _W*.5
    btn.y = _H*.8
    btn.id=1
    slideEffect(btn)
    
    btn:addEventListener( "touch", handleBtnTouch )
    

    return (btn)
end

function cleanup()
    print("Cleaning up")
    display.remove(pageGrp)
    display.remove(anim)
    --display.remove(btnGrp)
    display.remove(btn)
    btn:removeEventListener( "touch", handleTouch )
    --[[
    for i=1, 3 do
        --print ("Counter i:" .. i)
        item[i]:removeEventListener( "touch", handleTouch )
        display.remove(item[i])
        item[i] = nil
    end
    ]]
    item = nil
    pageGrp = nil
    anim = nil
    --btnGrp = nil
    btn = nil
    --m = 0 
end 

function cleanupRestart()
    cleanup()
    if ( m >= 10 ) then
        timer.performWithDelay( 200, levelComplete )
    else 
        timer.performWithDelay( 200, createPage )
    end
end


function levelComplete ()
    print ("LEVEL COMPLETED function")
    --display.remove(pageGrp)
    --pageGrp = nil 
    --back:removeEventListener( "touch", goBack )
    --cleanup()
    m = 0
    options = {
        effect = "fade",
        time = 100,
        params = { 
            levelid = levelid,
            iconid = iconid,
        }
    }
    composer.gotoScene( "levelCompleted", options )
    return true
end

function disapearEffect (obj)
    --transition.to( obj, { time=500, delay=1000, alpha=0, xScale=0.1, yScale=.1, onComplete = enableButton(obj) } )
    if (obj.id ~= 1) then 
        print ("Handling obj.id = " .. obj.id)
        transition.to( obj, { time=500, delay=1000, alpha=0, xScale=0.1, yScale=.1, onComplete = greenLight } )
        --timer.performWithDelay( 1000, greenLight ) 
        --removeListener(obj)
        obj:removeEventListener( "touch", handleTouch )
        obj = nil
        -- remove listenere from obj

    end
end

function goodAnim (obj)
    
    print ("Good Anim for item: " .. obj.id)
    print ("Handling obj.id = " .. obj.id)

    runAnimation()
    transition.to( obj, { time=500, delay=1500, alpha=0, xScale=0.1, yScale=.1, onComplete = greenLight } )
    --timer.performWithDelay( 1000, greenLight ) 
    --removeListener(obj)

    timer.performWithDelay( 1500, cleanupRestart )     
    obj:removeEventListener( "touch", handleTouch )
    obj = nil
    -- remove listenere from obj
    --cleanupRestart()

end

function badAnim (obj)
    
    print ("Bad Anim for item: " .. obj.id)
    print ("Handling obj.id = " .. obj.id)
    transition.to( obj, { time=500, delay=1000, alpha=0, xScale=0.1, yScale=.1, onComplete = greenLight } )
    --timer.performWithDelay( 1000, greenLight ) 
    --removeListener(obj)
    obj:removeEventListener( "touch", handleTouch )
    obj = nil
    -- remove listenere from obj
end


function enlargeEffect(obj) 
    runAnimation()
    print ("handling right answer..." .. obj.id)
    transition.to(item[2], { time=700, alpha=0, xScale=0.1, yScale=.1 } )
    transition.to(item[3], { time=700, alpha=0, xScale=0.1, yScale=.1 } )
    transition.to(item[1], { time=500, xScale=1.3, yScale=1.3 } )
    transition.to( obj, { time=500, delay=1000, alpha=0, xScale=0.1, yScale=.1, onComplete = greenLight })
    --removeListener(obj)
    obj:removeEventListener( "touch", handleTouch )
    obj = nil

    timer.performWithDelay( 1500, cleanupRestart ) 
    --btn[1] = nil
    --btn[2] = nil
    --btn[3] = nil

--return true
end


-- Sprite Animations

function runAnimation (event)
    --display.remove(anim)
    if anim ~= nil then
        display.remove(anim)
        anim = nil 
    end

    anim = display.newGroup()
    n = math.random(1,4)

    print("animation nr: " .. n )
    if (n == 1) then 
        print ("Animation: man")
        instance2 = display.newSprite( anim, sheet1, { name="man", start=1, count=15, time=600, loopCount = 4 } )
    elseif (n == 2 ) then 
        print ("Animation: girl")
        instance2 = display.newSprite( anim, sheet2, { name="girl", start=1, count=16, time=600, loopCount = 4 } )
    else 
        print ("Animation: other")
        instance2 = display.newSprite( anim, sheet3, { name="other", start=1, count=9, time=600, loopCount = 4 } )
    end
    instance2.x = _W*0.2
    instance2.y = _H*0.8
    anim:insert( instance2)
    instance2:play()


    return true
end

-- Logic functions 
local function threeNumbers (a, b)
    -- return 3 non-identical numbers between a and b in array n[1..3]
    -- expect b to be at least a+3 
    local n = {}
    repeat
        math.randomseed( os.time() )
        n[1] = math.random(a,b)
        --n[1] = m
        n[2] = math.random(a,b)
        n[3] = math.random(a,b)
    until n[1] ~= n[2] and n[2] ~= n[3] and n[1] ~= n[3]
    return (n)
end

local function twoNumbers (a,b)
    -- returns two non-identical numbers between a and b in array n[1..3]
    -- n[1]  = n 
    local n = {}
    repeat
        math.randomseed( os.time() )
        n[1] = m+a
        n[2] = math.random(a,b)
        n[3] = math.random(a,b)
    until n[1] ~= n[2] and n[2] ~= n[3] and n[1] ~= n[3]
    return (n)
end 

local function twoNumbersGiven (a,b,c)
    -- returns two non-identical numbers between a and b in array n[1..3]
    -- n[1]  = n 
    local n = {}
    repeat
        math.randomseed( os.time() )
        n[1] = c
        n[2] = math.random(a,b)
        n[3] = math.random(a,b)
    until n[1] ~= n[2] and n[2] ~= n[3] and n[1] ~= n[3]
    return (n)
end 



local function posX ()    
    local x = {}
    math.randomseed( os.time() )
    local pos = math.random(1,3)
    if (pos == 1) then
        x[1] = _W*.2       -- 1
        x[2] = _W*.5       -- 2
        x[3] = _W*.8       -- 3
    elseif (pos == 2) then
        x[1] = _W*.5       -- 2
        x[2] = _W*.2       -- 1
        x[3] = _W*.8       -- 3
    else
        x[1] = _W*.8       -- 3
        x[2] = _W*.5       -- 2
        x[3] = _W*.2       -- 1
    end
    return (x)
end



function createPage()

    for z=1,  #returnTbl do
        print ("item: " .. z .. " randomized: " .. returnTbl[z])
    end
        
    if (m == 10) then 
        print ("Level completed")
        levelComplete()

    else

        if pageGrp == nil then
            pageGrp = display.newGroup()
        end

        print ("Creating page for: (m+startPoint,startpoint,endpoint): " .. (m + startPoint) .. ", " .. startPoint .. ", " .. endPoint .. " randomized nr: " .. returnTbl[m+1] )
        print ("Sequence nr: " .. m .. " Randomized nr: " .. returnTbl[m+1] )

        local item = {} 
        --local n = threeNumbers (1000,1016)
        local n = twoNumbersGiven (startPoint, endPoint, returnTbl[m+1]+startPoint-1)
        --local n = twoNumbers (startPoint, endPoint)
        local x = posX()
        print ("n[1]:" .. n[1] .. " n[2]:" .. n[2] .. " n[3]:" .. n[3])
        print ("x[1]:" .. x[1] .. " x[2]:" .. x[2] .. " x[3]:" .. x[3])

        for i=1,3 do
            print ("Loading sound: dict/" .. n[i] .. "_" .. dict.lang ..".wav")
            sound[i] = audio.loadSound("dict/" .. n[i] .. "_" .. dict.lang ..".wav")
            item[i] = display.newImageRect( "images/" .. n[i] .. ".png", 100, 100 )
            item[i].x = x[i]
            item[i].y = _H*.3
            print ("i: " .. i .. "item[i].x: " .. item[i].x .. " item[i].y: " .. item[i].y)
            item[i].id = i
            item[i]:addEventListener( "touch", handleTouch )

            --appearEffect(item)
            pageGrp:insert(item[i])

        end

        createButton(n)

        function goBack( event )
            local t = event.target 
            local phase = event.phase

              --disable the event response for a while, to allow the animations to finish
            if (phase == "began"  ) then
                --print ("Pressed back button")

                display.remove(pageGrp)
                --pageGrp = nil 
                back:removeEventListener( "touch", goBack )
                cleanup()
                m = 0
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
            return true        
        end

        back = display.newImageRect(  "images/button_back.png", 90, 30 )
        back.x, back.y = pos.leftSide+5+back.contentWidth*0.5, pos.topSide+5+back.contentHeight*0.5
        pageGrp:insert( back )
        back:addEventListener( "touch", goBack )

        if (m < 9) then 
           print ("level not yet completed, current value is: " .. m )
        end
        m = m +1
    end    

end


-- "scene:create()"
function scene:create( event )


   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   -- local background = display.newImage( sceneGroup, "images/green_sunbeam.jpg", _W/2, _H/2, false )
   local background = display.newImage( sceneGroup, "images/blue-sunbeam-background.jpg", _W/2, _H/2, false )
   -- local background = display.newImage( sceneGroup, "images/green_radiant.jpg", _W/2, _H/2, false )
   return true
end

-- "scene:show()"
function scene:show( event )
    -- n array, n[1] is the correct nr, n[2] & n[3] are incorrect
    --local n={}
    print ("game")
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        print ("Loading")

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.

        -- Example: start timers, begin animation, play audio, etc.
        params = event.params
        levelid = params.levelid
        labelid = params.labelid
        iconid = params.iconid
        startPoint = ((iconid-1)*10)+1000
        endPoint = startPoint + 9

        --prev = params.prev
        print ("-----------------------------------")
        print ("Level id = " .. levelid)
        print ("Label id = " .. labelid)
        print ("Icon id = " .. iconid)
        print ("startPoint = " .. startPoint)
        print ("endPoint = " .. endPoint)
        print ("-----------------------------------")

        print ("trying to pull a value " .. highscores.l11[1])

        -- generate random 10... 
        randomTen() 


        createPage()

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
        display.remove( btnGrp )
        display.remove (anim)
        display.remove (pageGrp)
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