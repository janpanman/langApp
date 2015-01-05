R = {
	leftSide = display.screenOriginX,
	rightSide = display.contentWidth-display.screenOriginX,
	topSide = display.screenOriginY,
	bottomSide = display.contentHeight-display.screenOriginY,


	totalWidth = display.contentWidth-(display.screenOriginX*2),
	totalHeight = display.contentHeight-(display.screenOriginY*2),
	centerX = display.contentCenterX,
	centerY = display.contentCenterY,


}

return R
-- example use
--local object = display.newRect(0, 0, 20, 10);
--object.x, object.y = leftSide+10+object.contentWidth*0.5, topSide+10+object.contentHeight*0.5;