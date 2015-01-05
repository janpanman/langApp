-- Global functions

function imgRotate( img) 
	img.rotation = 0 
	imgTran = transition.to(img, {rotation=360, time=2000, onComplete=new(img)} )
end