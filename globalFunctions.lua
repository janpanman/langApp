-- Global functions
gf = {}


function gf:createBackground(scnGrp, img, x, y)
   --local sceneGroup = self.view
   -- addBackground 
   -- local background = display.newImage( sceneGroup, "images/blue-sunbeam-background.jpg", x, y, false )

   print("img: " .. img .. ", x: " .. x .. ", y: " .. y)
   --local background = display.newImage( sceneGroup, img, x, y, false )
   background = display.newImage( scnGrp, img, x, y, false )

   local function imgRotate() 
      --background.rotation = 0 
      transition.to(background, {rotation=10, time=10000 } )
      transition.to(background, {rotation=-10, time=10000, delay=10000, onComplete=imgRotate })
      print("rotating... ")
   end

   -- Initialize the scene here.
   -- Example: adAd display objects to "sceneGroup", add touch listeners, etc.
   print("Trying to rotate the background... ")
   gf.bgTimer = timer.performWithDelay(1, imgRotate() )
end


function gf:createDog(scnGrp, img, x, y )

   dog = display.newImageRect( scnGrp, img, x, y, false )
   dog.x = _X*.2
   dog.y = _Y*1.8
   startPositionY = dog.y

   local function jumpDoggie() 
      transition.to(dog, {y=startPositionY-50, time=300, delay=2000})
      transition.to(dog, {y=startPositionY, time=100, delay=2400, onComplete=jumpDoggie })
   end
   gf.dogJumpTimer = timer.performWithDelay( 1, jumpDoggie() )
   -- body
end




return gf