-- Global functions
gf = {}

function gf:createBackground(scnGrp, img, x, y)
   --local sceneGroup = self.view
   -- addBackground 
   -- local background = display.newImage( sceneGroup, "images/blue-sunbeam-background.jpg", x, y, false )

   print("img: " .. img .. ", x: " .. x .. ", y: " .. y)
   --local background = display.newImage( sceneGroup, img, x, y, false )
   local background = display.newImage( scnGrp, img, x, y, false )

   local function imgRotate() 
      --background.rotation = 0 
      transition.to(background, {rotation=10, time=10000 } )
      transition.to(background, {rotation=-10, time=10000, delay=10000, onComplete=imgRotate })
      print("rotating... ")
   end

   -- Initialize the scene here.
   -- Example: adAd display objects to "sceneGroup", add touch listeners, etc.
   print("Trying to rotate the background... ")
   timer.performWithDelay(1, imgRotate() )
end

return gf