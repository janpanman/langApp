-- Global functions

local function rotateImage( img) 
	img.rotation = 0 
	imgTrans = transition.to(img, {rotation=360, time=2000, onComplete=rotateImage(img)} )
end