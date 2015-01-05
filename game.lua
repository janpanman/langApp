-- Globals
pos = require("resolution")
highscoreHandler = require("highscoreHandler")




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


--local function updateScore(m,label)
--   print ("Updating the score for (count,label): (" .. m .. "," .. label ..")")
   --highscores.l11[m]=1
   --highscores["l11"][m]=1
   --loadsave.saveTable(highscores, "myTable.json", system.DocumentsDirectory)
--end

local function handleTouch( event )
    local t = event.target 
    local phase = event.phase

    if stop then
        print ("Stop flag = true")
        --timer.performWithDelay( 2000, greenLight )
        return true
    end

    stop = true
    timer.performWithDelay( 1500, greenLight )
    --disable the event response for a while, to allow the animations to finish

    print ("Phase:" .. phase )
    if (phase == "began" ) then
        

        if (t.id == 1) then 
                print ("Woowie,.. correct" .. t.id)
                labelTxt[1]:setFillColor( 1,1,1 )
--                dustEm.x = btn[1].x
--                dustEm.y = btn[1].y
--                PS:startEmitter('pointLoopEm',true)
                local playsound1 = audio.play( sound1, { duration=3000, onComplete=enlargeEffect(btn[1]) } )

                runAnimation()
                -- need something to only update the score if it was the first hit.... 
                if (answercount == 0 ) then 
                    print ("Updating the score... m=" .. m .. " labelid=" .. labelid)
                    score[m]=1
                    putLevelScores(score,labelid)
                else 
                    print ("Not updating the score.. not's the first right answer.. ")
                end

                
                --updateScore(m, labelid)
                --cleanupRestart()
                --timer.performWithDelay( 3000, cleanupRestart ) 

                -- reset correct answer counter to 0
                answercount = 0

        elseif (t.id == 2 ) then 
                wobbleEffect(t)
                labelTxt[t.id]:setFillColor( 1,0,0 )
                print ("Oppsie,.. wrong" .. t.id)
                answercount = 1
                disapearEffect(btn[2])
                local playsound2 = audio.play( sound2, { duration=3000, onComplete=disapearEffect(btn[2]) } )

        elseif (t.id == 3 ) then 
                wobbleEffect(t)
                labelTxt[3]:setFillColor( 1,0,0 )
                print ("Oppsie,.. wrong" .. t.id)
                answercount = 1
                disapearEffect(btn[3])
                local playsound3 = audio.play( sound3, { duration=3000, onComplete=disapearEffect(btn[3]) } )

        end
    end
    return true        
end


local function handleBoxTouch( event )
    local t = event.target 
    local phase = event.phase

    if (phase == "began" ) then
        local playsound1 = audio.play( sound1, { duration=3000 } )
    end
    return true        
end


function cleanup()
    print("Cleaning up")
    display.remove(pageGrp)
    display.remove(anim)
    display.remove(btnGrp)
    for i=1, 3 do
        --print ("Counter i:" .. i)
        btn[i]:removeEventListener( "touch", handleTouch )
        display.remove(btn[i])
        btn[i] = nil
    end
    pageGrp = nil
    anim = nil
    btnGrp = nil
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

function enlargeEffect(obj) 
    runAnimation()
    print ("handling right answer..." .. obj.id)
    transition.to(btn[2], { time=700, alpha=0, xScale=0.1, yScale=.1 } )
    transition.to(btn[3], { time=700, alpha=0, xScale=0.1, yScale=.1 } )
    transition.to(btn[1], { time=500, xScale=1.3, yScale=1.3 } )
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


local function createButtons (n, y)
    local fontSize = 25
    --display.remove(btnGrp)
    if btnGrp == nil then
        btnGrp = display.newGroup( )
    end
    for i=1, 3 do
        --print ("Counter i:" .. i)
        btn[i] = display.newGroup()
        local word = dict[tostring(n[i])]
        print ("Sequence: " .. n[i] .. " Pulled string: " .. word)
        print ("Y position: y: ".. i .. ": " .. y[i])
        labelTxt[i] = display.newText( word, 0, 0, customFont, fontSize)
        labelTxt[i]:setFillColor( 0,0,0 )
        block[i] = display.newRoundedRect( 0, 0, 0.6 * fontSize * string.len( word ) - 3 * string.len( word ), 35, 12 )
        block[i].strokeWidth = 2
        block[i]:setFillColor( 0.6, 0.6, 0.6 )
        block[i]:setStrokeColor( 0, 0, 0 )
        btn[i]:insert( block[i] )
        btn[i]:insert(labelTxt[i])
        btn[i].x = _W*.70
        btn[i].y = y[i]
        btn[i].id=i
        slideEffect(btn[i])
        
        btn[i]:addEventListener( "touch", handleTouch )
        btn[i]:insert( btnGrp )
    end
    return (btn)
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
    instance2.x = _W*0.25
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

local function posY ()    
    local y = {}
    math.randomseed( os.time() )
    local pos = math.random(1,3)
    if (pos == 1) then
        y[1] = _H*.15
        y[2] = _H*.30
        y[3] = _H*.45
    elseif (pos == 2) then
        y[1] = _H*.30
        y[2] = _H*.15
        y[3] = _H*.45
    else
        y[1] = _H*.45
        y[2] = _H*.15
        y[3] = _H*.30
    end
    return (y)
end

function createPage()

    --if item ~= nil then 
    --    item = nil
    --end


    if (m == 10) then 
        print ("Level completed")
        levelComplete()

    else

        if pageGrp == nil then
            pageGrp = display.newGroup()
        end

        print ("Creating page for: (m+startPoint,startpoint,endpoint): " .. (m + startPoint) .. ", " .. startPoint .. ", " .. endPoint .. " randomized nr: " .. returnTbl[m+1] )
        print ("Sequence nr: " .. m .. " Randomized nr: " .. returnTbl[m+1] )

        --local n = threeNumbers (1000,1016)
        local n = twoNumbersGiven (startPoint, endPoint, returnTbl[m+1]+startPoint-1)
        local y = posY()
        print ("n[1]:" .. n[1] .. " n[2]:" .. n[2] .. " n[3]:" .. n[3])
        print ("y[1]:" .. y[1] .. " y[2]:" .. y[2] .. " y[3]:" .. y[3])

        -- loading the 3 sounds 
        sound1 = audio.loadSound("dict/" .. n[1] .. "_" .. dict.lang ..".wav")
        sound2 = audio.loadSound("dict/" .. n[2] .. "_" .. dict.lang ..".wav")
        sound3 = audio.loadSound("dict/" .. n[3] .. "_" .. dict.lang ..".wav")

        print ("Good one " .. n[1])
        print ("Error one " .. n[2])
        print ("Error one " .. n[3])
        --print ("Pos =" .. pos)
        print ("file: images/" .. n[1] .. ".png")


        local item = display.newImageRect( "images/" .. n[1] .. ".png", 150, 150 )
        --local item = display.newImageRect( "images/" .. n[1] .. ".png", 10, 10 )
        
        item.x = _W*0.25
        item.y = _H*.3
        item:addEventListener( "touch", handleBoxTouch )

        print ("x: " .. item.x .. " y: " .. item.y)
        appearEffect(item)
        pageGrp:insert(item)
        createButtons(n,y)



        local function goBack( event )
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
        --back.x = 0.3 *_H
        --back.y = 0.04 *_W 
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

        print ("trying to pull a value highscores.l11[1]" .. highscores.l11[1])
        score = getLevelScores(labelid)
        -- print ("trying to pull a value levelScores(labelid)" .. levelScores(labelid))
        -- print ("trying to pull a value score[1]:" .. score[1])
        answercount = 0

        -- print ("Trying to put a value in score[1]=1")
        -- score[1]=1
        -- putLevelScores(score,labelid)


        -- now pick the levelid 

        -- l11 => 1000 - 1009
        -- l12 => 1010 - 1019
        -- l13 => 1020 - 1029

        -- iconid = 1,2,3,4,5,6 
        -- start = 1000 
        -- end = 1009
        --for n=startPoint,endPoint do 
        --    createPage(n,startPoint,endPoint)
        --end
        -- generate random 10... 
        randomTen() 
        createPage()



        -- Example: start timers, begin animation, play audio, etc.





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