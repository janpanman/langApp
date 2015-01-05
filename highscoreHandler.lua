local json = require "json"

function initHighscores()

    --[[
    local  scores = {
            ["l11"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l12"] = {1,1,1,1,1,1,1,1,0,0}, 
            ["l13"] = {1,1,1,1,1,1,1,0,0,0}, 
            ["l14"] = {1,1,1,0,0,0,0,0,0,0}, 
            ["l15"] = {1,1,0,0,0,0,0,0,0,0}, 
            ["l16"] = {0,0,0,0,0,0,0,0,0,0},
            ["l21"] = {0,0,0,0,1,0,0,0,0,0}, 
            ["l22"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l23"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l24"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l25"] = {0,0,0,0,0,0,1,0,0,0}, 
            ["l26"] = {0,0,0,0,0,0,0,0,1,0}
        }
    ]]-- 
    
    local  scores = {
            ["l11"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l12"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l13"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l14"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l15"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l16"] = {0,0,0,0,0,0,0,0,0,0},
            ["l21"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l22"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l23"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l24"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l25"] = {0,0,0,0,0,0,0,0,0,0}, 
            ["l26"] = {0,0,0,0,0,0,0,0,0,0},
        }        

    return scores
end

--print("l11[1] = " .. highscores.l11[1])


function loadHighscores()
    local base = system.pathForFile( "highscores.json", system.DocumentsDirectory)
    local jsoncontents = ""
    local highscoresArray = {}
    local file = io.open( base, "r" )
      if file then
        local jsoncontents = file:read( "*a" )
        highscoresArray = json.decode(jsoncontents);
        io.close( file ) 
        return highscoresArray
      else 
        highscores = initHighscores()

        saveHighscores( highscores )
        return highscores 
      end
     return highscores
end

function saveHighscores( score)
      local base = system.pathForFile( "highscores.json", system.DocumentsDirectory)
      local file = io.open(base, "w")
      local jsoncontents = json.encode(highscores)
      file:write( jsoncontents )
    io.close( file )
end


-- Returns the array for a certain level
function getLevelScores(lbl)
    print ("retrieving score for label: " .. lbl)
    local ar = {}
    if (lbl == "l11") then 
        ar = highscores.l11
    elseif (lbl == "l12") then
        ar = highscores.l12
    elseif (lbl == "l13") then
        ar = highscores.l13
    elseif (lbl == "l14") then
        ar = highscores.l14
    elseif (lbl == "l15") then
        ar = highscores.l15
    elseif (lbl == "l16") then
        ar = highscores.l16
    elseif (lbl == "l21") then 
        ar = highscores.l21
    elseif (lbl == "l22") then
        ar = highscores.l22
    elseif (lbl == "l23") then
        ar = highscores.l23
    elseif (lbl == "l24") then
        ar = highscores.l24
    elseif (lbl == "l25") then
        ar = highscores.l25
    elseif (lbl == "l26") then
        ar = highscores.l26
    end
    return ar
end    

-- Returns the array for a certain level
function putLevelScores(ar, lbl)
    print ("saving score: ar for label: " .. lbl)
    --local ar = {}
    if (lbl == "l11") then 
        highscores.l11 = ar
    elseif (lbl == "l12") then
        highscores.l12 = ar
    elseif (lbl == "l13") then
        highscores.l13 = ar
    elseif (lbl == "l14") then
        highscores.l14 = ar 
    elseif (lbl == "l15") then
        highscores.l15 = ar
    elseif (lbl == "l16") then
        highscores.l16 = ar
    elseif (lbl == "l21") then 
        highscores.l21 = ar
    elseif (lbl == "l22") then
        highscores.l22 = ar
    elseif (lbl == "l23") then
        highscores.l23 = ar
    elseif (lbl == "l24") then
        highscores.l24 = ar
    elseif (lbl == "l25") then
        highscores.l25 = ar
    elseif (lbl == "l26") then
        highscores.l26 = ar
    end
    saveHighscores(highscores)
end    



function randomTen()
    randomTbl = {}
    reverseTbl = {}
    returnTbl = {} 
    math.randomseed( os.time() )
    randomTbl[1] = math.random(0,200)
    randomTbl[2] = math.random(0,200)
    randomTbl[3] = math.random(0,200)
    randomTbl[4] = math.random(0,200)
    randomTbl[5] = math.random(0,200)
    randomTbl[6] = math.random(0,200)
    randomTbl[7] = math.random(0,200)
    randomTbl[8] = math.random(0,200)
    randomTbl[9] = math.random(0,200)
    randomTbl[10] = math.random(0,200)

    for i = 1, #randomTbl do
       print ("== randomTbl[" .. i .. "]=" .. randomTbl[i])
       reverseTbl[randomTbl[i]]=i
    end 


    table.sort( randomTbl )

    for i = 1, #randomTbl do
        --print ("=== randomTbl[" .. i .. "]=" .. randomTbl[i])
        --print ("=== Reverse value = " .. reverseTbl[randomTbl[i]])

        print ("returnTbl[" .. i .. "]=" .. reverseTbl[randomTbl[i]] )
        returnTbl[i] = reverseTbl[randomTbl[i]]
    end 
    
    for i = 1, #returnTbl do
        print ("==== returnTbl[" .. i .. "]=" .. returnTbl[i])
    end
    
    return returnTbl
end


