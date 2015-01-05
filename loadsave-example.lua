local loadsave = require("loadsave")

newTable = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
if newTable == nil then
	local t = loadsave.inithighscores
	loadsave.saveTable(t, "myTable.json", system.DocumentsDirectory)
	newTable = loadsave.loadTable("myTable.json", system.DocumentsDirectory)
end	




loadsave.printTable(newTable)