--magicTurtle API by Liraal and EatenAlive3
--version 1.38 14-03-2012

-- reference: getMatch(block) takes a block (ID or name), returns the slot number of the block in inventory, or false if not in inventory.
-- reference: getSlotMatch(s1,s2,s3,s4,s5,s6,s7,s8,s9) takes a set of nine boolean states, and returns the number of the first state to be true.
-- reference: getSlot(slot) returns the ID of the block contained within the slot.

local c=false
local x, y, z --starting pos
local face=2 --make sure that the turtle's pointing north
local autoupdate=false --make this true if you want to autoupdate everytime 
local version=1.38
local updateID=11 --ID of terminal sending updates/commands
local armingID=11 --ID of terminal arming the mine
local disarmingID=11 --ID of disarming terminal
local selection = 1
local slot1,slot2,slot3,slot4,slot5,slot6,slot7,slot8,slot9 = 0,0,0,0,0,0,0,0,0
local blockIDs = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129}
local blockNames = {"air","stone","grass","dirt","cobblestone","planks","sapling","bedrock","water","stationary water","lava","stationary lava","sand","gravel","gold ore","iron ore","coal ore","log","leaves","sponge","glass","lapis lazuli ore","lapis lazuli block","dispenser","sandstone","note block","bed","powered rail","detector rail","sticky piston","cobweb","tall grass","dead bush","piston","piston extension","wool","block moved by piston","dandelion","rose","brown mushroom","red mushroom","gold block","iron block","double slab","slab","bricks","tnt","bookshelf","moss stone","obsidian","torch","fire","monster spawner","wooden stairs","chest","redstone wire","diamond ore","diamond block","crafting table","wheat seeds","farmland","furnace","burning furnace","sign post","wooden door","ladder","rails","cobblestone stairs","wall sign","lever","stone pressure plate","iron door","wooden pressure plate","redstone ore","glowing redstone ore","redstone torch off","redstone torch","button","flat snow","ice","snow block","cactus","clay","sugar cane","jukebox","fence","pumpkin","netherrack","soulsand","glowstone","portal","jack-o-lantern","cake","repeater off","repeater on","locked chest","trapdoor","silverfish","stone bricks","huge brown mushroom","huge red mushroom","iron bars","glass pane","melon","pumpkin stem","melon stem","vines","fence gate","brick stairs","stone brick stairs","mycelium","lily pad","nether brick","nether brick fence","nether brick stairs","nether wart","enchantment table","brewing stand","cauldron","end portal","end portal frame","end stone","dragon egg","redstone lamp","redstone lamp on","unknown block","unmapped block","computer","disk drive","monitor"}
air,stone,grass,dirt,cobblestone,cobble,planks,woodenplanks,sapling,bedrock,water,stationarywater,lava,stationarylava,sand,gravel,goldore,ironore,coalore,log,wood,leaves,leaf,sponge,glass,lapislazuliore,lapislazuliblock,dispenser,sandstone,noteblock,bed,poweredrail,detectorrail,stickypiston,cobweb,tallgrass,deadbush,piston,pistonextension,wool,blockmovedbypiston,dandelion,yellowflower,flower,rose,brownmushroom,redmushroom,goldblock,gold,ironblock,iron,doubleslab,slab,step,halfslab,halfstep,brick,bricks,tnt,bookshelf,mossstone,moss,obsidian,torch,fire,mobspawner,monsterspawner,woodenstairs,woodstairs,woodstair,chest,redstonewire,diamondore,diamond,diamondblock,craftingtable,craftingbench,workbench,worktable,wheatseeds,farmland,furnace,burningfurnace,signpost,woodendoor,wooddoor,woodoor,ladder,rails,cobblestonestairs,cobblestair,cobblestairs,wallsign,lever,stonepressureplate,irondoor,woodenpressureplate,redstoneore,glowingredstoneore,redstonetorchoff,redstonetorch,button,flatsnow,snow,ice,snowblock,cactus,clay,sugarcane,reeds,jukebox,fence,pumpkin,netherrack,soulsand,glowstone,portal,jackolantern,cake,repeateroff,repeateron,lockedchest,trapdoor,silverfish,stonebricks,smoothbricks,hugebrownmushroom,hugeredmushroom,ironbars,glasspane,melon,pumpkinstem,melonstem,vines,fencegate,brickstairs,stonebrickstairs,mycelium,lilypad,netherbrick,netherbrickfence,netherbrickstairs,netherwart,enchantmenttable,brewingstand,cauldron,endportal,endportalframe,endstone,dragonegg,redstonelamp,redstonelampon,unknown,unknownblock,unmapped,unmappedblock,computer,diskdrive,monitor = "air","stone","grass","dirt","cobblestone","cobblestone","planks","planks","sapling","bedrock","water","stationary water","lava","stationary lava","sand","gravel","gold ore","iron ore","coal ore","log","log","leaves","leaves","sponge","glass","lapis lazuli ore","lapis lazuli block","dispenser","sandstone","note block","bed","powered rail","detector rail","sticky piston","cobweb","tall grass","dead bush","piston","piston extension","wool","block moved by piston","dandelion","dandelion","dandelion","rose","brown mushroom","red mushroom","gold block","gold block","iron block","iron block","double slab","slab","slab","slab","slab","bricks","bricks","tnt","bookshelf","moss stone","moss stone","obsidian","torch","fire","monster spawner","monster spawner","wooden stairs","wooden stairs","wooden stairs","chest","redstone wire","diamond ore","diamond block","diamond block","crafting table","crafting table","crafting table","crafting table","wheat seeds","farmland","furnace","burning furnace","sign post","wooden door","wooden door","wooden door","ladder","rails","cobblestone stairs","cobblestone stairs","cobblestone stairs","wall sign","lever","stone pressure plate","iron door","wooden pressure plate","redstone ore","glowing redstone ore","redstone torch off","redstone torch","button","flat snow","flat snow","ice","snow block","cactus","clay","sugar cane","sugar cane","jukebox","fence","pumpkin","netherrack","soulsand","glowstone","portal","jack-o-lantern","cake","repeater off","repeater on","locked chest","trapdoor","silverfish","stone bricks","stone bricks","huge brown mushroom","huge red mushroom","iron bars","glass pane","melon","pumpkin stem","melon stem","vines","fence gate","brick stairs","stone brick stairs","mycelium","lily pad","nether brick","nether brick fence","nether brick stairs","nether wart","enchantment table","brewing stand","cauldron","end portal","end portal frame","end stone","dragon egg","redstone lamp","redstone lamp on","unknown block","unknown block","unmapped block","unmapped block","computer","disk drive","monitor"
local map = {}
vertexPaths = {}
nodes = {}
nodeF = {}

Vertex = {x=0,y=0,z=0,ID=0,active=true,
 setPos = function (self, xs,ys,zs)
  self.x=xs self.y=ys self.z=zs
 end,

 getPos = function(self)
  return self.x,self.y,self.z
 end,

 setID = function(self,newID)
  self.ID = newID
  vertexPaths[self.ID] = {}
 end,

 getID = function(self)
  return self.ID
 end,

 addPath = function(self,state)
  table.insert(vertexPaths[self.ID],#vertexPaths[self.ID]+1,state)
 end,

 getPath = function(self)
  return vertexPaths[self.ID]
 end,

 setActive = function(self,state)
  self.active = state
 end,

 isActive = function(self)
  return self.active
 end,

 getPosString = function(self)
  return self.x..","..self.y..","..self.z
 end,

 deletePath = function(self)
  vertexPaths[self.ID] = {}
 end}

function Vertex:new(o)
 o = o or {}
 setmetatable(o, self)
 self.__index = self
 return o
end

Node = {x=0,y=0,z=0,g=0,h=0,f=0,pid="",ID=0,active=true,

 setActive = function(self,state)
  self.active = state
 end,

 isActive = function(self)
  return self.active
 end,

 getPos = function(self)
  return self.x,self.y,self.z
 end,

 setPos = function(self,xs,ys,zs)
  self.x,self.y,self.z = xs,ys,zs
 end,

 getID = function(self)
  return self.ID
 end,

 setID = function(self,id)
  self.ID = id
 end,

 getPid = function(self)
  return self.pid
 end,

 setPid = function(self,id)
  self.pid = id
 end,

 getPosString = function(self)
  return self.x..","..self.y..","..self.z
 end}

function Node:new(xs,ys,zs,xe,ye,ze,id,pid,s,penalty,o)
 if not penalty then penalty = 0 end
 o = o or {}
 setmetatable(o, self)
 self.__index = self
 if not s then o.g = nodes[pid].g + 10
 o.pid = nodes[pid]:getPid()..pid.."," end
 o.h = (math.abs(xs-xe)+math.abs(ys-ye)+math.abs(zs-ze)-1)*10+penalty
 o.f = o.h + o.g
 o.x,o.y,o.z = xs,ys,zs
 o.ID = id
 nodes[id] = o
 nodeF[id] = o.f
 return o
end

function main()
 load()
 updateSlots()
end

function load()
 getPosF()
 loadSlots()
 if fs.exists("/blockdata") then
  local file = io.open("/blockdata","r")
  map = textutils.unserialize(file:read())
  file:close()
 end
end

function save()
 savePos()
 saveSlots()
end

function getSelection()
 return selection end

function saveSlots()
 if not fs.isDir("/pos") then fs.makeDir("/pos") end
 local slots = io.open("/pos/slots", "w")
 slots:write(slot1.." "..slot2.." ".." "..slot3.." "..slot4.." "..slot5.." "..slot6.." "..slot7.." "..slot8.." "..slot9.." "..selection)
 slots:close()
 return true end

function loadSlots()
 if not fs.isDir("/pos") then return false end
 local slots = io.open("/pos/slots","r")
 allSlots = slots:read()
 slots:close()
 slot1 = pattern(allSlots,"%S+",1)
 slot2 = pattern(allSlots,"%S+",slot1:len()+2)
 slot3 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+3)
 slot4 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+4)
 slot5 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+slot4:len()+5)
 slot6 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+slot4:len()+slot5:len()+6)
 slot7 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+slot4:len()+slot5:len()+slot6:len()+7)
 slot8 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+slot4:len()+slot5:len()+slot6:len()+slot7:len()+8)
 slot9 = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+slot4:len()+slot5:len()+slot6:len()+slot7:len()+slot8:len()+9)
 selection = pattern(allSlots,"%S+",slot1:len()+slot2:len()+slot3:len()+slot4:len()+slot5:len()+slot6:len()+slot7:len()+slot8:len()+slot9:len()+10)
 slot1 = tonumber(slot1) slot2 = tonumber(slot2) slot3 = tonumber(slot3) slot4 = tonumber(slot4) slot5 = tonumber(slot5) slot6 = tonumber(slot6) slot7 = tonumber(slot7) slot8 = tonumber(slot8) slot9 = tonumber(slot9) selection = tonumber(selection) turtle.select(selection)
 return true
end

function setSlot(slot,name)
 local setTo = 0
 local q,position = tableContains(blockNames,name:lower())
 if q then setTo = position-1 else return false end
 if slot == 1 then slot1 = setTo elseif slot == 2 then slot2 = setTo elseif slot == 3 then slot3 = setTo elseif slot == 4 then slot4 = setTo elseif slot == 5 then slot5 = setTo elseif slot == 6 then slot6 = setTo elseif slot == 7 then slot7 = setTo elseif slot == 8 then slot8 = setTo elseif slot == 9 then slot9 = setTo end
 saveSlots()
 return true end

function getSlot(slot)
 if slot == 1 then return slot1 elseif slot == 2 then return slot2 elseif slot == 3 then return slot3 elseif slot == 4 then return slot4 elseif slot == 5 then return slot5 elseif slot == 6 then return slot6 elseif slot == 7 then return slot7 elseif slot == 8 then return slot8 elseif slot == 9 then return slot9 else return false end end

function updateSlots()
 for i=1,9,1 do
  if turtle.getItemCount(i) == 0 then setSlot(i,air) end
  if turtle.getItemCount(i) > 0 and getSlot(i) == 0 then setSlot(i, unknown) end
 end
 saveSlots()
end

function select(a)
 if tonumber(a) ~= nil then
  turtle.select(a)
  selection = a
  saveSlots()
 else
  if getMatch(a) then
   turtle.select(getMatch(a))
   selection = getMatch(a)
   saveSlots()
  else return false end
 end
end

function place(a)
 local tmp = getSelection()
 if tonumber(a) == nil then
  select(a)
  a = getBlockID(a)
 else
  select(a)
  a = getSlot(a)
 end
 done = turtle.place()
 if face == 0 then
   setBlock(x,y,z+1,a)
  elseif face == 1 then
   setBlock(x-1,y,z,a)
  elseif face == 2 then
   setBlock(x,y,z-1,a)
  elseif face == 3 then
      setBlock(x+1,y,z,a) end
 select(tmp) updateSlots() return done end

function placeUp(a)
 local tmp = getSelection()
 if tonumber(a) == nil then
  select(a)
  a = getBlockID(a)
 else
  select(a)
  a = getSlot(a)
 end
 done = turtle.placeUp()
    setBlock(x,y+1,z,a)
 select(tmp) updateSlots() return done end

function placeDown(a)
 local tmp = getSelection()
 if tonumber(a) == nil then
  select(a)
  a = getBlockID(a)
 else
  select(a)
  a = getSlot(a)
 end
 done = turtle.placeDown()
 setBlock(x,y-1,z,a)
 select(tmp) updateSlots() return done end

function tableContains(table, element)
  local count = 0
  for _, value in pairs(table) do
    count = count + 1
    if value == element then
      return true,count
    end
  end
  return false,0
end

function getBlockName(i)
 local final
 local names = blockNames[i+1]
 if names then final = names
 elseif (i/1000)>= 0 and (i/1000) == math.floor(i/1000) then final = "turtle "..(i/1000) end
 return final end

function getBlockID(name)
 if name == false or name == true then name = basicToBlockType(name) end
 if tonumber(name) ~= nil then return false end
 local q,w = tableContains(blockNames,name:lower())
 if q then return tonumber(blockIDs[w])
 else return false end end

function version()
return version
end

function setMineID(arming, disarming)
armingID=arming
disarmingID=disarming
end

function setUpdateID(a)
updateID=a
end

function savePos()
if not fs.isDir("/pos") then fs.makeDir("/pos") end
local f1=io.open("/pos/posx", "w")
local f2=io.open("/pos/posy", "w")
local f3=io.open("/pos/posz", "w")
local f4=io.open("/pos/face", "w")
f1:write(x)
f2:write(y)
f3:write(z)
f4:write(face)
f1:close()
f2:close()
f3:close()
f4:close()
return true
end

function getPosF()
if not fs.exists("/pos/posx") or not fs.exists("/pos/posy") or not fs.exists("/pos/posz") or not fs.exists("/pos/face") then print("You need to set your position with setPos") return false end
local f1=io.open("pos/posx", "r")
local f2=io.open("pos/posy", "r")
local f3=io.open("pos/posz", "r")
local f4=io.open("pos/face", "r")
x=tonumber(f1:read())
y=tonumber(f2:read())
z=tonumber(f3:read())
face=tonumber(f4:read())
f1:close()
f2:close()
f3:close()
f4:close()
end

function getPos()
return x,y,z
end

function setNorth()
face=2
end

function setFacing(f)
 face=f
 savePos()
 return true
end

function setPos(a, b, c, ...)
x=a
y=b
z=c
if ...~=nil then face=... end
savePos()
return true
end

function faceAdd(a)
if face+a>3 then face=face+a-4 else face=face+a end
end

function faceSub(a)
if face-a<0 then face=4-face-a else face=face-a end
end

function faceSouth()
return faceSet(0)
end

function faceEast()
return faceSet(3)
end

function faceNorth()
return faceSet(2)
end

function faceWest()
return faceSet(1)
end

function toString(a)
 local bool = a
 if bool == true then
  return "true"
 else
  return "false"
 end
end

function faceSet(a)
 local turn = face-a
 local tmp = getFacing()
 local done = false
 if face == a then
  done = true
 elseif turn == -1 or turn == 3 then
  turnRight()
  done = true
 elseif turn == 1 or turn == -3 then
  turnLeft()
  done = true
 elseif math.abs(turn) == 2 then
  rotate(2)
  done = true
 end
 if done == false then
  face = tmp
 end
 return done
end

function turnLeft(a)
if not a then a = 1 end
for i=1,math.abs(a),1 do
 turtle.turnLeft()
 faceSub(1)
 savePos()
end
return true
end

function turnRight(a)
if not a then a = 1 end
for i=1,math.abs(a),1 do
 turtle.turnRight()
 faceAdd(1)
 savePos()
end
return true
end

function rotate(angle)
 if math.abs(math.floor((angle+1)/4)) == math.abs((angle+1)/4) then
  turnRight(angle-2)
 else
  turnLeft(angle)
 end
end

function checkSides()
 local front = turtle.detect()
 turnRight()
 local right = turtle.detect()
 turnRight()
 local back = turtle.detect()
 turnRight()
 local left = turtle.detect()
 turnRight()
 local top = turtle.detectUp()
 local bottom = turtle.detectDown()
 return front,right,back,left,top,bottom
end

function getPos()
return x, y, z
end

function getFacing()
return face
end

function up(a)
 local state
 if not a then a=1 end
 if y~=255 then
  for i=1,a,1 do
   state = turtle.up()
   if state then y=y+1
    setBlock(x,y-1,z,0)
    setBlock(x,y,z,os.getComputerID().."000")
    savePos() else break end
  end
 end
 return state
end

function down(a)
 local state
 if not a then a = 1 end
 if y~=1 then
  for i=1,a,1 do
   state = turtle.down()
   if state then y=y-1
    setBlock(x,y+1,z,0)
    setBlock(x,y,z,os.getComputerID().."000")
    savePos() else break end
  end
 end
 return state
end

function forward(a)
local state=true
if not a then a = 1 end
if face==0 then for i=1, a, 1 do state=turtle.forward() if state then z=z+1 savePos()
 setBlock(x,y,z-1,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
if face==1 then for i=1, a, 1 do state=turtle.forward() if state then x=x-1 savePos()
 setBlock(x+1,y,z,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
if face==2 then for i=1, a, 1 do state=turtle.forward() if state then z=z-1 savePos()
 setBlock(x,y,z+1,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
if face==3 then for i=1, a, 1 do state=turtle.forward() if state then x=x+1 savePos()
 setBlock(x-1,y,z,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
return state
end

function back(a)
local state=true
if not a then a = 1 end
if face==2 then for i=1, a, 1 do state=turtle.back() if state then z=z+1 savePos()
 setBlock(x,y,z-1,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
if face==3 then for i=1, a, 1 do state=turtle.back() if state then x=x-1 savePos()
 setBlock(x+1,y,z,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
if face==0 then for i=1, a, 1 do state=turtle.back() if state then z=z-1 savePos()
 setBlock(x,y,z+1,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
if face==1 then for i=1, a, 1 do state=turtle.back() if state then x=x+1 savePos()
 setBlock(x-1,y,z,0)
 setBlock(x,y,z,os.getComputerID().."000") end end end
return state
end

function left(a)
 if not a then a = 1 end
 turnLeft()
 return forward(a)
end

function right(a)
 if not a then a = 1 end
 turnRight()
 return forward(a)
end

function goToPos(a, b, c, mode)
faceEast()
a=a-x
b=b-y
c=c-z
if a>=0 then
for i=1, a, 1 do
while mode and turtle.detect() do dig() sleep(0.2) end
forward(1)
end
else
a=math.abs(a)
rotate(2)
for i=1, a, 1 do
while mode and turtle.detect() do dig() sleep(0.2) end
forward(1)
end
end
if b>=0 then for i=1, b, 1 do
while mode and turtle.detectUp() do digUp() sleep(0.2) end
up()
end
else
b=math.abs(b)
for i=1, b, 1 do
while mode and turtle.detectDown() do digDown() sleep(0.2) end
down()
end
end
faceSouth()
if c>=0 then
for i=1, c, 1 do
while mode and turtle.detect() do dig() sleep(0.2) end
forward(1)
end
else
c=math.abs(c)
rotate(2)
for i=1, c, 1 do
while mode and turtle.detect() do dig() sleep(0.2) end
forward(1)
end
end
return true
end

function tunnel(w, h, l)
local xs, ys, zs=getPos()
local faces=face
for k=1, l, 1 do
for j=1, h, 1 do
turnLeft()
for i=1, w, 1 do
dig()
forward(1)
end
for i=1, w, 1 do back(1) end
turnRight()
if j<h then digDown() down() end
end
for j=1, h, 1 do if j<h then up() end end
dig() forward(1)
end
goToPos(xs, ys, zs, false)
faceSet(faces)
return true
end

function staircase(w, h, l)
local xs, ys, zs=getPos()
local faces=face
for k=1, l, 1 do
for j=1, h, 1 do
turnLeft()
for i=1, w, 1 do
dig()
forward(1)
end
for i=1, w, 1 do back(1) end
turnRight()
if j<h then digDown() down() end
end
for j=1, h, 1 do up() end
dig() forward(1)
end
goToPos(xs, ys, zs, false)
faceSet(faces)
return true
end

function wread()
local _, y=term.getCursorPos()
local tmp=read()
local x, _=term.getCursorPos()
term.setCursorPos(x,y)
return tmp
end

function build(blueprint)
local l=#blueprint
local h=#blueprint[1]
local w=#blueprint[1][1]
local xs, ys, zs=getPos()
local faces=face
for k=1, l, 1 do
for j=1, h, 1 do
turnLeft()
for i=1, w, 1 do
dig()
forward(1)
end
for i=1, w, 1 do 
local block=blueprint[k][j][i]
print(block)
if block~=0 then select(block) turtle.place() end
back(1) 
end
turnRight()
if j<h then digDown() down() end
end
for j=1, h, 1 do if j<h then up() end end
dig() forward(1)
end
goToPos(xs, ys, zs, false)
faceSet(faces)
return true
end

function sketch()
print("Blueprint maker")
print("Use turtle's slot IDs for data")
print("Enter dimensions")
write(" Width: ") local w=wread()
write(" Height: ") local h=wread()
write(" Length: ") local l=wread()
local t={}
for i=1, l, 1 do
print("Vertical Layer ",i)
local tt={}
for j=1, h, 1 do
print("Horizontal Row ", j)
local ttt={}
for k=1, w, 1 do
local tmp=tonumber(wread())
table.insert(ttt, tmp)
write(" ")
end
table.insert(tt, ttt)
end
table.insert(t, tt)
end
return t
end

function getUpdate(side)
local a,b,c=os.pullEvent()
while a~="rednet_message" or b~=updateID do a,b,c=os.pullEvent() end
local tmp=loadstring(c)
tmp()
return true
end

function getUpdateP(side)
if peripheral.getType(side)=="disk" and fs.exists("/"..disk.getMountPath(side).."/magicTurtleUpdate/update") then
shell.run("/"..disk.getMountPath(side).."/magicTurtleUpdate/update")
return true
end
return false
end

function event()
local a,b,c=os.pullEvent()
if a=="rednet_message" and b==updateID and c=="update" then getUpdate(b) return true end
if a=="peripheral" then getUpdateP(b) return true end
return false
end

function updateSeek()
rednet.open("right")
local result = false
while not result do result = event() end
return true
end

function lua()
while true do
write(">")
local com=wread() print("")
if com=="exit" then return true end
if com=="menu" then menu() end
if c then break end
local exec=loadstring(com)
exec()
end
end

function autoUpdate()
autoupdate=true
while true do
parallel.waitForAny(lua, updateSeek)
end
return true
end

function isSpace()
for i=1, 9, 1 do
if turtle.getItemCount(i)==0 then return true end
end
return false
end

function diamondMine(l,...)
local xs,ys,zs=getPos()
local a,b,c=getPos()
while b~=12 do digDown() down() dig() digDown() forward(1) a,b,c=getPos() end
while isSpace() do
if ...~=nil then digSlot(...) else dig() end
forward(1) digDown() 
turnLeft() for i=1, l, 1 do 
if ...~=nil then digSlot(...) else dig() end
forward(1) end
back(l)
rotate(2)
for i=1, l, 1 do 
if ...~=nil then digSlot(...) else dig() end
forward(1) end
back(l)
end
goToPos(xs,ys,zs, true)
return true
end

function mine(mode, l,...)
if mode=="diamond" then diamondMine(l,...) end
if mode=="regular" then tunnel(l, l, l) end
if mode=="quarry" then quarry(l, ...) end
return true
end

function sendCommand(id, side, exec)
rednet.open(side)
rednet.send(id, "update")
local state=rednet.send(id, exec)
return state
end

function fcoord()
if face==0 then z=z+1 end
if face==1 then x=x+1 end
if face==2 then z=z-1 end
if face==3 then x=x-1 end
end

function lookAround()
if not turtle.forward() and rs.getInput("front") then return false end
fcoord()
if not rs.getInput("bottom") then
back(1)
turnRight() forward(1)
if not rs.getInput("bottom") then
back(2) rotate(2)
if not rs.getInput("bottom") then
back(1) turnRight() return false
else return true
end
else return true
end
else return true
end
end

function road()
while true do
if not lookAround() then
up()
if not lookAround() then
if not turtle.forward() and not rs.getInput("bottom") then turnLeft() write(1)
if not turtle.forward() and not rs.getInput("bottom") then rotate(2) write(2)
if not turtle.forward() and not rs.getInput("bottom") then break end end end
write(13)
fcoord()
down() down()
if not lookAround() then up() break end
end
end
end
end

function obs()
while true do
if turtle.detect() then
blow=true
write(1)
back(1)
select(5)
turtle.place()
for i=1, 5, 1 do
write(2)
if not turtle.detectDown() then select(1) turtle.placeDown() end
back(1)
end
forward(5)
for i=1, 5, 1 do
back(1)
select(6)
turtle.place()
end
rs.setOutput("front", true) back(1) rs.setOutput("front", false)
back(3)
sleep(2.5)
forward(9)
blow=false
end
sleep(0.2)
end
end

function blowup()
local tmp
local blow=false
while true do
print(blow)
if not blow then tmp=loadstring(read()) else tmp=loadstring("") end
parallel.waitForAll(tmp, obs)
end
return true
end

function wander(mode)
if mode == nil then mode = false end
while true do
if (math.random(1,10))>5 then turnLeft()
else turnRight() end
for i=1, math.random(10, 30), 1 do if not turtle.detect() then forward(1) end end
if not mode then
sleep(1) end
end end

function wanderer(exec)
local wand=true
while wand do
local tmp=loadstring(exec)
parallel.waitForAny(wander, tmp)
end
end

function jack(sap)
local xs,ys,zs=getPos()
select(sap)
turtle.place()
up()
while not turtle.detect() do sleep(0.2) end
back(2) turnRight() back(2) up() up() up() up()
tunnel(5,5,5)
goToPos(xs,ys,zs, true)
end

function treefarm(sap)
while true do jack(sap) end
end

function watchUp()
while true do
if turtle.detectUp() then rs.setOutput("bottom", true) end
sleep(0.5)
end
end

function disarm()
while true do
local a,b,c=os.pullEventRaw()
if a=="rednet_message" and b==disarmingID and c=="disarm" then arm=false end
sleep(0.5)
end
end

function landmine(slot, net)
local arm
while not turtle.detectDown() do down() end
digDown() down() digDown()
select(slot)
turtle.placeDown()
while true do
if net then
local a,b,c=os.pullEventRaw()
while a~="rednet_message" or b~=armingID or c~="arming" do a,b,c=os.pullEventRaw() end
end
arm=true
while arm do
if net then 
parallel.waitForAny(watchUp, disarm)
else
watchUp()
end
end
end
digdown() up()
end

function patch(slot, l, w)
for i=1, l, 1 do
turnLeft()
for j=1, w, 1 do
forward(1)
if (turtle.getItemCount(slot))==0 then return false end
select(slot)
while not turtle.detectDown() do turtle.placeDown() end
end
back(w) turnRight() forward(1)
end
back(l)
end

function guardArea(exec, w, h)
local tmp=loadstring(exec)
while true do
for i=1, h, 1 do
turnLeft()
for j=1, w, 1 do
forward(1)
if not turtle.detectDown() then tmp() end
if turtle.detect() then tmp() end
end
back(w) turnRight() forward(1)
end
back(h)
end
end

function remoteArm(id)
return rednet.send(id, "arming")
end

function remoteDisarm(id)
return rednet.send(id, "disarming")
end

function remoteSleep(id, t)
remoteDisarm(id)
sleep(t)
remoteArm(id)
end

function cDigDown()
local it={}
for i=1, 9, 1 do
table.insert(it, turtle.getItemCount(i))
end
digDown()
for i=1, 9, 1 do
if it[i]<turtle.getItemCount(i) then return i end
end
return false
end

function cDig()
local it={}
for i=1, 9, 1 do
table.insert(it, turtle.getItemCount(i))
end
dig()
for i=1, 9, 1 do
if it[i]<(turtle.getItemCount(i)) then return i end
end
return false
end

function camoMine(slot)
local slot2=cDigDown()
down() digDown()
placeDown(slot) up()
placeDown(slot2)
return true
end

function mineGrid(slot)
for i=1, 5, 1 do
turnRight()
for j=1, 5, 1 do
camoMine(slot)
forward(3)
end
back(15)
turnLeft()
forward(3)
end
back(9) turnRight() forward(6) turnLeft()
end

function playerDetect()
if not turtle.forward() and not dig() then turtle.back() return true else return false end
end

function follow()
while not playerDetect() do
turnRight() sleep(0.1)
end
forward(1)
end

function follower()
while true do
follow()
sleep(0.1)
end
end

function detectLeft()
turnLeft()
local a=turtle.detect()
turnRight()
return a
end

function detectRight()
turnRight()
local a=turtle.detect()
turnLeft()
return a
end

function detectBack()
rotate(2)
local a=turtle.detect()
rotate(2)
return a
end

function detect(side)
if side=="top" then return turtle.detectUp() end
if side=="bottom" then return turtle.detectDown() end
if side=="left" then return detectLeft() end
if side=="right" then return detectRight() end
if side=="back" then return detectBack() end
if side=="front" then return turtle.detect() end
return false
end

function detectDir(f)
local tmp=getFacing()
faceSet(f)
local tmp2=turtle.detect()
faceSet(tmp)
return tmp2
end

function path(face)
while true do
while detectRight() and not turtle.detect() do
forward(1)
end
if detectRight() and turtle.detect() then turnLeft() end
if not detectRight() then if not forward(1) then turnRight() end elseif not turtle.detectUp() then up() else down() end
if not detectDir(face) then break end
end
end

function digSlot(slot)
local s=cDig()
if s and s~=slot then select(s) turtle.drop() select(slot) else return false end
return true
end

function quarry(w, l)
local run=true
while run and isSpace() do
for i=1, l, 1 do
while turtle.detect() do dig() end
turnRight()
for j=1, w, 1 do
local s1=digDown() forward(1)
end
back(w)
turnLeft()
local s2=down()
end
if not s1 and not s2 then run=false end
end
return true
end

function stf(a,b)
local f=io.open(b,"w")
for i=1, #a,1 do
local ai=a[i]
local tmp2=""
for j=1, #ai, 1 do
local tmp=""
for k=1, #ai[j], 1 do tmp=tmp..ai[j][k] end
tmp=tmp.." "
tmp2=tmp2..tmp tmp=""
end
f:write(tmp2) f:write("\n")
end
f:close()
return true
end

function ctl(a)
local t={}
local tt={}
local ttt={}
for k=1, #a, 1 do
tmp2=a[k]
for i=1, #tmp2, 1 do
local tmp=tmp2[i]
for j=1, string.len(tmp), 1 do table.insert(ttt, string.sub(tmp, j,j)) end
table.insert(tt,ttt) ttt={}
end
table.insert(t,tt) tt={}
end
return t
end

function stt(a)
local t={}
local tmp=""
for i=1, string.len(a), 1 do
if string.sub(a,i,i)==" " then
table.insert(t,tmp) tmp=""
else
tmp=tmp..string.sub(a,i,i)
end
end
if tmp~="" then table.insert(t,tmp) end
return t
end

function tff(name)
local tmp=io.open(name,"r")
local n={}
for line in tmp:lines() do
table.insert(n,stt(line))
end
return ctl(n)
end

function architect(w, h, l)
local blueprint={}
local xs, ys, zs=getPos()
local faces=face
local row={}
local layer={}
for k=1, l, 1 do
for j=1, h, 1 do
turnLeft()
for i=1, w, 1 do
local tmp=cDig()
if not tmp then tmp=0 end
table.insert(row, tmp)
forward(1)
end
for i=1, w, 1 do back(1) end
turnRight()
table.insert(layer, row) row={}
if j<h then 
local tmp=cDigDown() 
if not tmp then tmp=0 end
table.insert(row, tmp)
down() 
end
end
for j=1, h, 1 do if j<h then up() end end
local tmp=cDig()
if not tmp then tmp=0 end
table.insert(row, tmp) 
forward(1)
table.insert(blueprint, layer) layer={}
end
goToPos(xs, ys, zs, false)
faceSet(faces)
return blueprint
end

function basicToBlockType(booleanBlock)
 if booleanBlock then
  return 125
 elseif not booleanBlock then
  return 0
 else
  return false
 end
end

function mapSides()
 local tmp = getFacing()
 local front,right,back,left,top,bottom = checkSides()
 local xs,ys,zs = getPos()
 setBlock(xs,ys,zs,os.getComputerID()*1000)
 if getFacing() == 2 then
  setBlock(xs,ys,zs-1,basicToBlockType(front))
  setBlock(xs+1,ys,zs,basicToBlockType(right))
  setBlock(xs,ys,zs+1,basicToBlockType(back))
  setBlock(xs-1,ys,zs,basicToBlockType(left))
  setBlock(xs,ys+1,zs,basicToBlockType(top))
  setBlock(xs,ys-1,zs,basicToBlockType(bottom))
 elseif getFacing() == 0 then
  setBlock(xs,ys,zs+1,basicToBlockType(front))
  setBlock(xs-1,ys,zs,basicToBlockType(right))
  setBlock(xs,ys,zs-1,basicToBlockType(back))
  setBlock(xs+1,ys,zs,basicToBlockType(left))
  setBlock(xs,ys+1,zs,basicToBlockType(top))
  setBlock(xs,ys-1,zs,basicToBlockType(bottom))
 elseif getFacing() == 1 then
  setBlock(xs-1,ys,zs,basicToBlockType(front))
  setBlock(xs,ys,zs-1,basicToBlockType(right))
  setBlock(xs+1,ys,zs,basicToBlockType(back))
  setBlock(xs,ys,zs+1,basicToBlockType(left))
  setBlock(xs,ys+1,zs,basicToBlockType(top))
  setBlock(xs,ys-1,zs,basicToBlockType(bottom))
 elseif getFacing() == 3 then
  setBlock(xs+1,ys,zs,basicToBlockType(front))
  setBlock(xs,ys,zs+1,basicToBlockType(right))
  setBlock(xs-1,ys,zs,basicToBlockType(back))
  setBlock(xs,ys,zs-1,basicToBlockType(left))
  setBlock(xs,ys+1,zs,basicToBlockType(top))
  setBlock(xs,ys-1,zs,basicToBlockType(bottom))
 else return false end
 faceSet(tmp)
 return true
end

function mapSidesHorizontal()
 local tmp = getFacing()
 local front = turtle.detect() turnRight() local right = turtle.detect() turnRight() local back = turtle.detect() turnRight() local left = turtle.detect() turnRight()
 local xs,ys,zs = getPos()
 setBlock(xs,ys,zs,os.getComputerID()*1000)
 if getFacing() == 2 then
  setBlock(xs,ys,zs-1,basicToBlockType(front))
  setBlock(xs+1,ys,zs,basicToBlockType(right))
  setBlock(xs,ys,zs+1,basicToBlockType(back))
  setBlock(xs-1,ys,zs,basicToBlockType(left))
 elseif getFacing() == 0 then
  setBlock(xs,ys,zs+1,basicToBlockType(front))
  setBlock(xs-1,ys,zs,basicToBlockType(right))
  setBlock(xs,ys,zs-1,basicToBlockType(back))
  setBlock(xs+1,ys,zs,basicToBlockType(left))
 elseif getFacing() == 1 then
  setBlock(xs-1,ys,zs,basicToBlockType(front))
  setBlock(xs,ys,zs-1,basicToBlockType(right))
  setBlock(xs+1,ys,zs,basicToBlockType(back))
  setBlock(xs,ys,zs+1,basicToBlockType(left))
 elseif getFacing() == 3 then
  setBlock(xs+1,ys,zs,basicToBlockType(front))
  setBlock(xs,ys,zs+1,basicToBlockType(right))
  setBlock(xs-1,ys,zs,basicToBlockType(back))
  setBlock(xs,ys,zs-1,basicToBlockType(left))
 else return false end
 faceSet(tmp)
 return true
end

function mapSidesVert()
 local tmp = getFacing()
 if getFacing() ~= 0 and getFacing() ~= 2 then faceNorth() end
 local front,top,bottom = turtle.detect(),turtle.detectUp(),turtle.detectDown()
 setBlock(x,y,z,os.getComputerID().."000")
 setBlock(x,y,z-1,basicToBlockType(front))
 setBlock(x,y+1,z,basicToBlockType(top))
 setBlock(x,y-1,z,basicToBlockType(bottom))
 faceSet(tmp)
 return true
end

function getBlock(xs,ys,zs)
 local tmp = 126
 if not map[xs..","..ys..","..zs] then
  return tmp
 else
  return map[xs..","..ys..","..zs]
end end

function setBlock(xs,ys,zs,type)
 if tonumber(type) == nil then type = getBlockID(type) end
 if tonumber(type) ~= nil then
  local file = io.open("/blockdata","w")
  map[xs..","..ys..","..zs] = type
  file:write(textutils.serialize(map))
  file:close()
  return true
 else return false end
end

function compare(slot)
 local done = false
 if tonumber(slot) ~= nil then
  select(slot)
  done = turtle.compare()
 else
  select(getMatch(slot))
  done = turtle.compare()
 end
 return done
end

function compareUp(slot)
 local done = false
 if tonumber(slot) ~= nil then
  select(slot)
  done = turtle.compareUp()
 else
  select(getMatch(slot))
  done = turtle.compareUp()
 end
 return done
end

function compareDown(slot)
 local done = false
 if tonumber(slot) ~= nil then
  select(slot)
  done = turtle.compareDown()
 else
  select(getMatch(slot))
  done = turtle.compareDown()
 end
 return done
end

function stringToBoolean(string) if string == "true" then return true else return false end end

function pattern(text,pattern,start)
 return string.sub(text,string.find(text,pattern,start)) end

function compareAll()
 local tmp = ""
 for i=1,9,1 do
  tmp = tmp..toString(compare(i)).." "
 end
 local s1 = pattern(tmp,"%S+",1)
 local s2 = pattern(tmp,"%S+",s1:len()+2)
 local s3 = pattern(tmp,"%S+",s1:len()+s2:len()+3)
 local s4 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+4)
 local s5 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+5)
 local s6 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+6)
 local s7 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+7)
 local s8 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+s7:len()+8)
 local s9 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+s7:len()+s8:len()+9)
 return stringToBoolean(s1),stringToBoolean(s2),stringToBoolean(s3),stringToBoolean(s4),stringToBoolean(s5),stringToBoolean(s6),stringToBoolean(s7),stringToBoolean(s8),stringToBoolean(s9)
end

function compareAllUp()
 local tmp = ""
 for i=1,9,1 do
  tmp = tmp..toString(compareUp(i)).." "
 end
 local s1 = pattern(tmp,"%S+",1)
 local s2 = pattern(tmp,"%S+",s1:len()+2)
 local s3 = pattern(tmp,"%S+",s1:len()+s2:len()+3)
 local s4 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+4)
 local s5 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+5)
 local s6 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+6)
 local s7 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+7)
 local s8 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+s7:len()+8)
 local s9 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+s7:len()+s8:len()+9)
 return stringToBoolean(s1),stringToBoolean(s2),stringToBoolean(s3),stringToBoolean(s4),stringToBoolean(s5),stringToBoolean(s6),stringToBoolean(s7),stringToBoolean(s8),stringToBoolean(s9)
end

function compareAllDown()
 local tmp = ""
 for i=1,9,1 do
  tmp = tmp..toString(compareDown(i)).." "
 end
 local s1 = pattern(tmp,"%S+",1)
 local s2 = pattern(tmp,"%S+",s1:len()+2)
 local s3 = pattern(tmp,"%S+",s1:len()+s2:len()+3)
 local s4 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+4)
 local s5 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+5)
 local s6 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+6)
 local s7 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+7)
 local s8 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+s7:len()+8)
 local s9 = pattern(tmp,"%S+",s1:len()+s2:len()+s3:len()+s4:len()+s5:len()+s6:len()+s7:len()+s8:len()+9)
 return stringToBoolean(s1),stringToBoolean(s2),stringToBoolean(s3),stringToBoolean(s4),stringToBoolean(s5),stringToBoolean(s6),stringToBoolean(s7),stringToBoolean(s8),stringToBoolean(s9)
end

function getMatch(block1)
 local s1 = 1
 if tonumber(block1) == nil then block1 = getBlockID(block1) end
 if getSlot(1) == block1 then s1 = 1 elseif getSlot(2) == block1 then s1 = 2 elseif getSlot(3) == block1 then s1 = 3 elseif getSlot(4) == block1 then s1 = 4 elseif getSlot(5) == block1 then s1 = 5 elseif getSlot(6) == block1 then s1 = 6 elseif getSlot(7) == block1 then s1 = 7 elseif getSlot(8) == block1 then s1 = 8 elseif slot9 == block1 then s1 = 9 else return false end
 return s1 end

function replace(block1,block2)
 local tmp = getSelection()
 local s1,s2 = 1,1
 local done = false
 if tonumber(block1) ~= nil and tonumber(block2) ~= nil then
  s1 = getMatch(block1)
  s2 = getMatch(block2)
  if compare(s1) then
   dig()
   done = place(s2)
   select(tmp)
  end
 else
  s1 = getMatch(block1)
  s2 = getMatch(block2)
  if compare(s1) then
   dig()
   done = place(s2)
   select(tmp)
  end
 end
 return done
end

function replaceUp(block1,block2)
 local tmp = getSelection()
 local s1,s2 = 1,1
 local done = false
 if tonumber(block1) ~= nil and tonumber(block2) ~= nil then
  s1 = getMatch(block1)
  s2 = getMatch(block2)
  if compareUp(s1) then
   digUp()
   done = placeUp(s2)
   select(tmp)
  end
 else
  if compareUp(s1) then
   digUp()
   done = placeUp(s2)
   select(tmp)
  end
 end
 return done
end

function replaceDown(block1,block2)
 local tmp = getSelection()
 local s1,s2 = 1,1
 local done = false
 if tonumber(block1) ~= nil and tonumber(block2) ~= nil then
  s1 = getMatch(block1)
  s2 = getMatch(block2)
  if compareDown(s1) then
   digDown()
   done = placeDown(s2)
   select(tmp)
  end
 else
  if compareDown(s1) then
   digDown()
   done = placeDown(s2)
   select(tmp)
  end
 end
 return done
end

function dig(block)
 if block == nil then block = false elseif tonumber(block) == nil then block = getBlockID(block) end
 local done = false
 local state = 0
 if not block then state = true else state = compare(getBlockName(block)) end
 if state and turtle.dig() then
  if face == 0 then
   done = setBlock(x,y,z+1,0)
  elseif face == 1 then
   done = setBlock(x-1,y,z,0)
  elseif face == 2 then
   done = setBlock(x,y,z-1,0)
  elseif face == 3 then
   done = setBlock(x+1,y,z,0)
  else done = false end
 else done = false end
 updateSlots()
 return done
end

function digUp(block)
 if block == nil then block = false elseif tonumber(block) == nil then block = getBlockID(block) end
 local done = false
 local state = 0
 if not block then state = true else state = compareUp(getBlockName(block)) end
 if state and turtle.digUp() then
   done = setBlock(x,y+1,z,0)
 else done = false end
 updateSlots()
 return done
end

function digDown(block)
 if block == nil then block = false elseif tonumber(block) == nil then block = getBlockID(block) end
 local done = false
 local state = 0
 if not block then state = true else state = compareDown(getBlockName(block)) end
 if state and turtle.digDown() then
   done = setBlock(x,y-1,z,0)
 else done = false end
 updateSlots()
 return done
end

function getSlotMatch(s1,s2,s3,s4,s5,s6,s7,s8,s9) -- boolean values
 if s1 then return 1 elseif s2 then return 2 elseif s3 then return 3 elseif s4 then return 4 elseif s5 then return 5 elseif s6 then return 6 elseif s7 then return 7 elseif s8 then return 8 elseif s9 then return 9 else return false end end

function checkSidesType()
 updateSlots()
 local front,right,back,left,top,bottom = 0,0,0,0,0,0
 if turtle.detect() then front = getSlot(getSlotMatch(compareAll())) else front = 0 end if not front then front = 125 end turnRight()
 if turtle.detect() then right = getSlot(getSlotMatch(compareAll())) else right = 0 end if not right then right = 125 end turnRight()
 if turtle.detect() then back = getSlot(getSlotMatch(compareAll())) else back = 0 end if not back then back = 125 end turnRight()
 if turtle.detect() then left = getSlot(getSlotMatch(compareAll())) else left = 0 end if not left then left = 125 end turnRight()
 if turtle.detectUp() then top = getSlot(getSlotMatch(compareAllUp())) else top = 0 end if not top then top = 125 end 
 if turtle.detectDown() then bottom = getSlot(getSlotMatch(compareAllDown())) else bottom = 0 end if not bottom then bottom = 125 end 
 return front,right,back,left,top,bottom end

function mapSidesType()
 local tmp = getFacing()
 local front,right,back,left,top,bottom = checkSidesType()
 local xs,ys,zs = getPos()
 setBlock(xs,ys,zs,os.getComputerID().."000")
 if getFacing() == 2 then
  setBlock(xs,ys,zs-1,front)
  setBlock(xs+1,ys,zs,right)
  setBlock(xs,ys,zs+1,back)
  setBlock(xs-1,ys,zs,left)
  setBlock(xs,ys+1,zs,top)
  setBlock(xs,ys-1,zs,bottom)
 elseif getFacing() == 0 then
  setBlock(xs,ys,zs+1,front)
  setBlock(xs-1,ys,zs,right)
  setBlock(xs,ys,zs-1,back)
  setBlock(xs+1,ys,zs,left)
  setBlock(xs,ys+1,zs,top)
  setBlock(xs,ys-1,zs,bottom)
 elseif getFacing() == 1 then
  setBlock(xs-1,ys,zs,front)
  setBlock(xs,ys,zs-1,right)
  setBlock(xs+1,ys,zs,back)
  setBlock(xs,ys,zs+1,left)
  setBlock(xs,ys+1,zs,top)
  setBlock(xs,ys-1,zs,bottom)
 elseif getFacing() == 3 then
  setBlock(xs+1,ys,zs,front)
  setBlock(xs,ys,zs+1,right)
  setBlock(xs-1,ys,zs,back)
  setBlock(xs,ys,zs-1,left)
  setBlock(xs,ys+1,zs,top)
  setBlock(xs,ys-1,zs,bottom)
 else return false end
 faceSet(tmp)
 return true
end

function mapSidesTypeHorizontal()
 local tmp = getFacing()
 local front,right,back,left = 126,126,126,126
 if not turtle.detect() then front = getSlot(getSlotMatch(compareAll())) else front = 0 end turnRight()
 if not turtle.detect() then right = getSlot(getSlotMatch(compareAll())) else right = 0 end turnRight()
 if not turtle.detect() then back = getSlot(getSlotMatch(compareAll())) else back = 0 end turnRight()
 if not turtle.detect() then left = getSlot(getSlotMatch(compareAll())) else left = 0 end turnRight()
 local xs,ys,zs = getPos()
 setBlock(xs,ys,zs,os.getComputerID().."000")
 if getFacing() == 2 then
  setBlock(xs,ys,zs-1,front)
  setBlock(xs+1,ys,zs,right)
  setBlock(xs,ys,zs+1,back)
  setBlock(xs-1,ys,zs,left)
 elseif getFacing() == 0 then
  setBlock(xs,ys,zs+1,front)
  setBlock(xs-1,ys,zs,right)
  setBlock(xs,ys,zs-1,back)
  setBlock(xs+1,ys,zs,left)
 elseif getFacing() == 1 then
  setBlock(xs-1,ys,zs,front)
  setBlock(xs,ys,zs-1,right)
  setBlock(xs+1,ys,zs,back)
  setBlock(xs,ys,zs+1,left)
 elseif getFacing() == 3 then
  setBlock(xs+1,ys,zs,front)
  setBlock(xs,ys,zs+1,right)
  setBlock(xs-1,ys,zs,back)
  setBlock(xs,ys,zs-1,left)
 else return false end
 faceSet(tmp)
 return true
end

function mapSidesTypeVert()
 local tmp = getFacing()
 if getFacing() ~= 0 and getFacing() ~= 2 then faceNorth() end
 local front,top,bottom = 126,126,126
 if not turtle.detect() then front = 0 else front = getSlot(getSlotMatch(compareAll())) end
 if not turtle.detectUp() then top = 0 else top = getSlot(getSlotMatch(compareAllUp())) end
 if not turtle.detectDown() then bottom = 0 else bottom = getSlot(getSlotMatch(compareAllDown())) end
 setBlock(x,y,z,os.getComputerID().."000")
 if getFacing() == 2 then setBlock(x,y,z-1,front) elseif getFacing() == 0 then setBlock(x,y,z+1,front) else return false end
 setBlock(x,y+1,z,top)
 setBlock(x,y-1,z,bottom)
 faceSet(tmp)
 return true
end

function getRow(type,xs,ys,zs,xe,ye,ze)
 if tonumber(type) == nil then
  type = getBlockID(type)
 elseif tonumber(type) ~= nil then
 else return false end
 local dir = 6
 local blocks = 0
 dir = getDirection(xs,ys,zs,xe,ye,ze)
 if dir == 0 then zs = zs + 1 elseif dir == 1 then xs = xs - 1 elseif dir == 2 then zs = zs - 1 elseif dir == 3 then xs = xs + 1 elseif dir == 4 then ys = ys - 1 elseif dir == 5 then ys = ys + 1 elseif dir == 6 then return false else return false end
 if not map[xs..","..ys..","..zs] then return false end
 local temp = getBlock(xs,ys,zs)
 local tmp = tonumber(pattern(temp,"%d+",1))
 local stop = false
 while not stop do
  if tmp == type then
   blocks = blocks + 1
   if dir == 0 then
    temp = getBlock(xs,ys,zs+1)
    if ze > zs then
     tmp = tonumber(pattern(temp,"%d+",1)) --patterns are used incase block save format ever changes.
     zs = zs + 1
    else stop = true end
   elseif dir == 1 then
    temp = getBlock(xs-1,ys,zs)
    if xe < xs then
     tmp = tonumber(pattern(temp,"%d+",1))
     xs = xs - 1
    else stop = true end
   elseif dir == 2 then
    temp = getBlock(xs,ys,zs-1)
    if ze < zs then
     tmp = tonumber(pattern(temp,"%d+",1))
     zs = zs - 1
    else stop = true end
   elseif dir == 3 then
    temp = getBlock(xs+1,ys,zs)
    if xe > xs then
     tmp = tonumber(pattern(temp,"%d+",1))
     xs = xs + 1
    else stop = true end
   elseif dir == 4 then
    temp = getBlock(xs,ys-1,zs)
    if ys > ye then
     tmp = tonumber(pattern(temp,"%d+",1))
     ys = ys - 1
    else stop = true end
   elseif dir == 5 then
    temp = getBlock(xs,ys+1,zs)
    if ys > ye then
     tmp = tonumber(pattern(temp,"%d+",1))
     ys = ys + 1
    else stop = true end
   elseif dir == 6 then
    stop = true
    return false
   else return false end
  else stop = true end
 end
 return blocks
end

function getBorderingBlocks(xs,ys,zs)
 local north,east,south,west,up,down = 125,125,125,125,125,125
 north = getBlock(xs,ys,zs-1)
 east = getBlock(xs+1,ys,zs)
 south = getBlock(xs,ys,zs+1)
 west = getBlock(xs-1,ys,zs)
 up = getBlock(xs,ys+1,zs)
 down = getBlock(xs,ys-1,zs)
 return north,east,south,west,up,down
end

function getBlockTypeDirection(type,s1,s2,s3,s4,s5,s6) --for finding blocks after a getBorderingBlocks()
 local returnPack = ""
 type = getBlockID(type)
 if s1 == type then returnPack = returnPack.."2 " end
 if s2 == type then returnPack = returnPack.."3 " end
 if s3 == type then returnPack = returnPack.."0 " end
 if s4 == type then returnPack = returnPack.."1 " end
 if s5 == type then returnPack = returnPack.."5 " end
 if s6 == type then returnPack = returnPack.."4 " end
 if returnPack == "" then
  returnPack = returnPack.."6 "
 end
 returnPack = returnPack.."|"
 local q1,q2,q3,q4,q5,q6 = nil,nil,nil,nil,nil,nil
 q1 = pattern(returnPack,"%S+",1)
 if q1 ~= "|" and q1 ~= nil then q2 = pattern(returnPack,"%S+",q1:len()+2) end
 if q2 ~= "|" and q2 ~= nil then q3 = pattern(returnPack,"%S+",q1:len()+q2:len()+3) end
 if q3 ~= "|" and q3 ~= nil then q4 = pattern(returnPack,"%S+",q1:len()+q2:len()+q3:len()+4) end
 if q4 ~= "|" and q4 ~= nil then q5 = pattern(returnPack,"%S+",q1:len()+q2:len()+q3:len()+q4:len()+5) end
 if q5 ~= "|" and q5 ~= nil then q6 = pattern(returnPack,"%S+",q1:len()+q2:len()+q3:len()+q4:len()+q5:len()+6) end
 if q1 then q1 = tonumber(q1) end if q2 then q2 = tonumber(q2) end if q3 then q3 = tonumber(q3) end if q4 then q4 = tonumber(q4) end if q5 then q5 = tonumber(q5) end if q6 then q6 = tonumber(q6) end
 return q1,q2,q3,q4,q5,q6
end

function goDirection(dir,spaces)
 local done = false
 if dir == 0 or dir == 1 or dir == 2 or dir == 3 then faceSet(dir) done = forward(spaces)
 elseif dir == 5 then for i=1,spaces,1 do done = up() end
 elseif dir == 4 then for i=1,spaces,1 do done = down() end end
 return done
end

function getCoordCount(coord,number)
 local count = 0
 local xo,yo,zo = false,false,false
 local xs,ys,zs = 0,0,0
 if coord:lower() == "x" then xo = true
 elseif coord:lower() == "y" then yo = true
 elseif coord:lower() == "z" then zo = true
 else return false end
 for k,v in pairs(map) do
  xs = pattern(k,"[^,]+",1)
  ys = pattern(k,"[^,]+",xs:len()+2)
  zs = pattern(k,"[^,]+",xs:len()+ys:len()+3)
  xs = tonumber(xs) ys = tonumber(ys) zs = tonumber(zs)
  if xo and xs == number then count = count + 1
  elseif yo and ys == number then count = count + 1
  elseif zo and zs == number then count = count + 1 end
 end
 return count
end

function blockToText(blockID)
 blockID = tonumber(blockID)
 if blockID == 0 then return " "
 elseif blockID == 126 then return "~"
 elseif blockID/1000 == math.floor(blockID/1000) then return "T"
 elseif blockID == 3 or blockID == 12 or blockID == 13 or blockID == 18 then return "#"
 elseif blockID == 50 then return "i"
 else return "@" end end

function coordRow(xs,ys,zs)
 local returnPack = ""
 local count = 0
 local done = false
 zs = zs + 3
 while not done do
  returnPack = returnPack..blockToText(getBlock(xs,ys,zs))
  zs = zs - 1
  if getBlock(xs,ys,zs) == 126 then count = count+1 end
  if count >= 15 then done = true end
 end
 return returnPack
end

function getFullRow(xs,ys,zs,xe,ye,ze)
 local tmp = ""
 local done = false
 local dir = getDirection(xs,ys,zs,xe,ye,ze)
 while not done do
  tmp = tmp..getBlock(xs,ys,zs)..","
  if dir == 0 then zs = zs + 1 if zs > ze then done = true end
  elseif dir == 1 then xs = xs - 1 if xs < xe then done = true end
  elseif dir == 2 then zs = zs - 1 if zs < ze then done = true end
  elseif dir == 3 then xs = xs + 1 if xs > xe then done = true end
  elseif dir == 4 then ys = ys - 1 if ys < ye then done = true end
  elseif dir == 5 then ys = ys + 1 if ys > ye then done = true end
  else return false end
 end
 tmp = tmp.."|"
 return tmp
end

function getDirection(xs,ys,zs,xe,ye,ze)
 local xf,yf,zf = xe-xs,ye-ys,ze-zs
 local ax,ay,az = math.abs(xf),math.abs(yf),math.abs(zf)
 if xs == xe and ys == ye and zs == ze then return 6 end
 if xs == xe and zs == ze then if yf>=0 then return 5 else return 4 end end
 if xs == xe and ys == ye then if zf >= 0 then return 0 else return 2 end end
 if ys == ye and zs == ze then if xf >= 0 then return 3 else return 1 end end
 if max(ax,ay,az) == ax then if xf >= 0 then return 3 else return 1 end
 elseif max(ax,ay,az) == az then if zf >= 0 then return 0 else return 2 end
 elseif max(ax,ay,az) == ay then if yf>=0 then return 5 else return 4 end
 else return 6 end
end

function max(x,...)
  local max=x
  local args={...}
  for i=1,#args,1 do
    if args[i]>max then
      max=args[i]
    end
  end
  return max
end

function maxTable(x)
  local max = x[1]
  for i=1,#x,1 do
    if x[i]>max then
      max=x[i]
    end
  end
  return max
end

function maxTableTable(x) -- returns the POSITION of max value, NOT the max value!
  local tmp = maxTable(x)
  local max = {}
  for k,v in pairs(x) do
   if v == tmp then table.insert(max,#max+1,k) end
  end
  return max
end

function min(x,...)
  local min=x
  local args={...}
  for i=1,#args,1 do
    if args[i]<min then
      min=args[i]
    end
  end
  return min
end

function minTable(x)
  local min=x[1]
  for i=1,#x,1 do
    if x[i]<min then
      min=x[i]
    end
  end
  return min
end

function minTableTable(x) -- returns the POSITION of min value, NOT the min value!
  local tmp = minTable(x)
  local min = {}
  for k,v in pairs(x) do
   if v == tmp then table.insert(min,#min+1,k) end
  end
  return min
end

function getSeperated(x) -- for numbers in string format, returns a table.
 local sep = {}
 local done = false
 local count,prevVars,tmp = 0,0,0
 x = x..""
 while not done do
  count = count + 1
  tmp = pattern(x,"[^,]+",count+prevVars)
  if tmp == "|" then done = true return sep end
  prevVars = prevVars + tmp:len()
  table.insert(sep,count,tonumber(tmp))
 end
 return sep
end

function drop(a)
 if tonumber(a) ~= nil then
  select(a)
  turtle.drop()
  updateSlots()
 else
  select(getMatch(a))
  turtle.drop()
  updateSlots()
 end
end

function graph(xs,ys,zs,width,height,mode)
 local curX,curZ = 1,1
 if width == nil and height == nil then width,height = term.getSize()
 else height = height + 1 end
 width = width + 1
 local xw,zw = math.floor(width/2),math.floor(height/2)
 local fullRow = 0
 local fullRowY = 0
 local tmp = {}
 local temp = {}
 local tempp = 0
 if mode == nil then mode = false end
 term.clear()
 term.setCursorPos(1,1)
 for i=1,height-1,1 do
  fullRow = getFullRow(xs-xw+curX,ys,zs-zw+curZ,xs+xw,ys,zs+zw)
  if mode then fullRowY = getFullRow(xs-xw+curX,ys-1,zs-zw+curZ,xs+xw,ys,zs+zw) end
  for i=1,width-1,1 do
   tmp = getSeperated(fullRow)
   tempp = blockToText(tmp[i])
   if mode then temp = getSeperated(fullRowY)
   if tempp == " " and blockToText(temp[i]) ~= " " and blockToText(temp[i]) ~= "~" then tempp = "=" end end
   term.write(tempp)
  end
  if curZ <= height then
   curZ = curZ + 1
   term.setCursorPos(1,curZ)
  else break end
 end
end

function getBlockInDir(xs,ys,zs,dir)
 if dir == 0 then return getBlock(xs,ys,zs+1)
 elseif dir == 1 then return getBlock(xs-1,ys,zs)
 elseif dir == 2 then return getBlock(xs,ys,zs-1)
 elseif dir == 3 then return getBlock(xs+1,ys,zs)
 elseif dir == 4 then return getBlock(xs,ys-1,zs)
 elseif dir == 5 then return getBlock(xs,ys+1,zs)
 elseif dir == 6 then return getBlock(xs,ys,zs)
 else return false end
end

function getCoordsInDir(xs,ys,zs,dir,spaces)
 if spaces == nil then spaces = 1 end
 if dir == 0 then return xs,ys,zs+spaces
 elseif dir == 1 then return xs-spaces,ys,zs
 elseif dir == 2 then return xs,ys,zs-spaces
 elseif dir == 3 then return xs+spaces,ys,zs
 elseif dir == 4 then return xs,ys-spaces,zs
 elseif dir == 5 then return xs,ys+spaces,zs
 elseif dir == 6 then return xs,ys,zs
 else return false end
end

function goToCoordsPath(xs,ys,zs)
 local xf,yf,zf = x-xs,y-ys,z-zs
 if xf > 0 then faceWest() return forward(1)
 elseif xf < 0 then faceEast() return forward(1)
 elseif zf > 0 then faceNorth() return forward(1)
 elseif zf < 0 then faceSouth() return forward(1)
 elseif yf > 0 then return down()
 elseif yf < 0 then return up()
 end
 return false
end

function pathfindDijkstra(xe,ye,ze)
 local xs,ys,zs = getPos()
 if xe == xs and ye == ys and ze == zs then return true end
 if getBlock(xe,ye,ze,true) ~= 0 then print("You can only pathfind to air.") return false end
 local count,solutionID = 1,0
 local done = false
 local vertices = {}
 local cooldown = 0
 local takenPos = {xs..","..ys..","..zs}
 local q = 0
 vertices[1] = Vertex:new()
 vertices[1]:setID(1)
 vertices[1]:setPos(xs,ys,zs)
 while not done do
  for i=1,#vertices,1 do
   if vertices[i]:isActive() then
    for ii=0,5,1 do
     cooldown = cooldown + 1
     if cooldown >= 50 then sleep(0) cooldown = 0 end
     count = count + 1
     vertices[count] = Vertex:new()
     vertices[count]:setID(count)
     xs,ys,zs = vertices[i]:getPos()
     vertices[count]:setPos(getCoordsInDir(xs,ys,zs,ii))
     for q=1,#takenPos,1 do
      if vertices[count]:getPosString() == takenPos[q] then
       vertices[count]:setActive(false)
      end
     end
     table.insert(takenPos,#takenPos+1,vertices[count]:getPosString())
     if getBlock(vertices[count]:getPos()) ~= 0 then
      vertices[count]:setActive(false)
     elseif vertices[count]:isActive() then
      for iii=1,#vertices[i]:getPath(),1 do
       vertices[count]:addPath(vertices[i]:getPath()[iii])
      end
      vertices[count]:addPath(vertices[count]:getPosString())
     end
    end
    vertices[i]:setActive(false)
   end
  end
  for i=1,#vertices,1 do
   if vertices[i]:getPosString() == xe..","..ye..","..ze then
    solutionID = vertices[i]:getID()
    done = true
    break
   end
  end
 end
 for k,v in ipairs(vertices[solutionID]:getPath()) do
  q = getSeperated(v..",|")
  xs,ys,zs = q[1],q[2],q[3]
  if not goToCoordsPath(xs,ys,zs) then return false end
 end
 return done
end

function getCube(xs,ys,zs,radius,type)
 local cube = {}
 local xf,yf,zf,xe,ye,ze = xs-radius,ys-radius,zs-radius,xs+radius,ys+radius,zs+radius
 local block = 125
 local cooldown = 0
 if type then
  if tonumber(type) == nil then type = getBlockID(type) end
  for i=math.floor((math.abs(yf-ye))/-2),math.floor((math.abs(yf-ye))/2),1 do
   for ii=math.floor((math.abs(zf-ze))/-2),math.floor((math.abs(zf-ze))/2),1 do
    for iii=math.floor((math.abs(xf-xe))/-2),math.floor((math.abs(xf-xe))/2),1 do
     block = getBlock(xs+iii,ys+i,zs+ii)
     cooldown = cooldown + 1 if cooldown >=50 then sleep(0.01) cooldown = 0 end
     if block == type then table.insert(cube,#cube+1,(xs+iii)..","..(ys+i)..","..(zs+ii)) end
    end
   end
  end
 else
  for i=math.floor((math.abs(yf-ye))/-2),math.floor((math.abs(yf-ye))/2),1 do
   for ii=math.floor((math.abs(zf-ze))/-2),math.floor((math.abs(zf-ze))/2),1 do
    for iii=math.floor((math.abs(xf-xe))/-2),math.floor((math.abs(xf-xe))/2),1 do
     cooldown = cooldown + 1 if cooldown >=50 then sleep(0.01) cooldown = 0 end
     table.insert(cube,#cube+1,(xs+iii)..","..(ys+i)..","..(zs+ii))
    end
   end
  end
 end
 return cube
end

function setCuboid(xs,ys,zs,xe,ye,ze)
 local xb,yb,zb
 xb = min(xs,xe)
 yb = max(ys,ye)
 zb = min(zs,ze)
 return xb,yb,zb
end

function getCubeSel(xs,ys,zs,xe,ye,ze,type,axis)
 if not axis then axis = 1 end
 local cube = {}
 local xf,yf,zf = math.abs(xs-xe),math.abs(ys-ye),math.abs(zs-ze)
 local cooldown = 0
 local block = 125
 local xb,yb,zb = setCuboid(xs,ys,zs,xe,ye,ze)
 if type then
  if tonumber(type) == nil then type = getBlockID(type) end
  if axis == 1 then
   for i=0,math.abs(ys-ye),1 do
    for ii=0,math.abs(zs-ze),1 do
     for iii=0,math.abs(xs-xe),1 do
      block = getBlock(xb+iii,yb-i,zb+ii)
      cooldown = cooldown + 1 if cooldown >=50 then sleep(0.01) cooldown = 0 end
      if block == type then table.insert(cube,#cube+1,(xb+iii)..","..(yb-i)..","..(zb+ii)) end
     end
    end
   end
  else
   for i=math.abs(ys-ye),0,-1 do
    for ii=math.abs(zs-ze),0,-1 do
     for iii=math.abs(xs-xe),0,-1 do
      block = getBlock(xb+iii,yb-i,zb+ii)
      cooldown = cooldown + 1 if cooldown >=50 then sleep(0.01) cooldown = 0 end
      if block == type then table.insert(cube,#cube+1,(xb+iii)..","..(yb-i)..","..(zb+ii)) end
     end
    end
   end
  end
 else
  if axis == 1 then
   for i=0,math.abs(ys-ye),1 do
    for ii=0,math.abs(zs-ze),1 do
     for iii=0,math.abs(xs-xe),1 do
      cooldown = cooldown + 1 if cooldown >=50 then sleep(0.01) cooldown = 0 end
      table.insert(cube,#cube+1,(xb+iii)..","..(yb-i)..","..(zb+ii))
     end
    end
   end
  else
   for i=math.abs(ys-ye),0,-1 do
    for ii=math.abs(zs-ze),0,-1 do
     for iii=math.abs(xs-xe),0,-1 do
      cooldown = cooldown + 1 if cooldown >=50 then sleep(0.01) cooldown = 0 end
      table.insert(cube,#cube+1,(xb+iii)..","..(yb-i)..","..(zb+ii))
     end
    end
   end
  end
 end
 return cube
end

function dist(xs,ys,zs,xe,ye,ze)
 local d1,d2,d3 = xs-xe,ys-ye,zs-ze
 return math.sqrt(d1^2+d2^2+d3^2)
end

function getClosest(xs,ys,zs,max,type) --Returns a table containing the closest matching coordinates.
 if not max then max = 5 end
 if max > 20 then max = 20 print("Too high! Maximum value is 20.") end
 if not type then type = 126 end
 if tonumber(type) == nil then type = getBlockID(type) end
 local min = 0
 local tmp = {}
 local q,w = {},{}
 local xe,ye,ze = 0,0,0
 local cooldown = 0
 if max >= 8 then print("This may take a little while, because the radius was "..max..".") end
 q=getCube(xs,ys,zs,max,type)
 for i=1,#q,1 do
  w = getSeperated(q[i]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  table.insert(tmp,#tmp+1,dist(xs,ys,zs,xe,ye,ze))
  cooldown = cooldown + 1 if cooldown >= 80 then sleep(0.01) cooldown = 0 end
 end
 w = {}
 min = minTable(tmp)
 for k,v in ipairs(tmp) do
  if v == min then
   table.insert(w,#w+1,q[k])
  end
  cooldown = cooldown + 1 if cooldown >= 80 then sleep(0.01) cooldown = 0 end
 end
 return w
end

function exploreType(radius,goback,mode)
 mapSidesType()
 if goback == nil then goback = true end
 if mode == nil then mode = true end
 local xs,ys,zs = getPos()
 local q,w
 local xe,ye,ze
 local a
 local done = false
 local loops = 1
 q = getCube(xs,ys,zs,radius,126)
 local tmp = #q
 if #q == 0 then exploreProgress(1,1,4) return true end
 for i=1,2,1 do
 while not done do
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   pathfind(getCoordsInDir(xe,ye,ze,a))
   mapSidesType()
   q = getCube(xs,ys,zs,radius,126)
   tmp = #q
  end
  loops = loops + 1
  if loops > tmp-1 then done = true end
  if mode and not done then
   if i == 0 then
    exploreProgress(loops,tmp,i)
   else
    exploreProgress(loops,tmp,i)
   end
  end
 end
 done = false
 q = getCube(xs,ys,zs,radius,126)
 tmp = #q
 loops = 1
 end
 while not done do --Safety loop, gets any missed spots at the cost of being slower. That's why we did a fast loop before, to clear out most of the unmapped blocks
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   pathfind(getCoordsInDir(xe,ye,ze,a))
   mapSidesType()
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   exploreProgress(loops,tmp,3)
  end
 end
 exploreProgress(loops-1,tmp,4)
 if goback then pathfind(xs,ys,zs) end
 return done
end
 
function explore(radius,goback,mode)
 mapSides()
 if goback == nil then goback = true end
 if mode == nil then mode = true end
 local xs,ys,zs = getPos()
 local q,w
 local xe,ye,ze
 local a
 local done = false
 local loops = 1
 q = getCube(xs,ys,zs,radius,126)
 local tmp = #q
 if #q == 0 then exploreProgress(1,1,4) return true end
 for i=1,2,1 do
 while not done do
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   pathfind(getCoordsInDir(xe,ye,ze,a))
   mapSides()
   q = getCube(xs,ys,zs,radius,126)
   tmp = #q
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   if i == 0 then
    exploreProgress(loops,tmp,i)
   else
    exploreProgress(loops,tmp,i)
   end
  end
 end
 done = false
 q = getCube(xs,ys,zs,radius,126)
 tmp = #q
 loops = 1
 end
 while not done do --Safety loop, gets any missed spots at the cost of being slower. That's why we did a fast loop before, to clear out most of the unmapped blocks
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   pathfind(getCoordsInDir(xe,ye,ze,a))
   mapSides()
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   exploreProgress(loops,tmp,3)
  end
 end
 exploreProgress(loops-1,tmp,4)
 if goback then pathfind(xs,ys,zs) end
 return done
end

function exploreSel(xq,yq,zq,xw,yw,zw,goback,mode)
 print("Warning: exploreSel() is in beta testing, expect an occasional bug.")
 mapSides()
 if goback == nil then goback = true end
 if mode == nil then mode = true end
 local xs,ys,zs = getPos()
 local q,w
 local xe,ye,ze
 local t1,t2,t3
 local a
 local done = false
 local loops = 1
 q = getCubeSel(xq,yq,zq,xw,yw,zw,126)
 local tmp = #q
 if #q == 0 then exploreProgress(1,1,4) return true end
 for i=1,2,1 do
 while not done do
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   t1,t2,t3 = getCoordsInDir(xe,ye,ze,a)
   pathfind(t1,t2,t3,10)
   mapSides()
   q = getCubeSel(xq,yq,zq,xw,yw,zw,126,i)
   tmp = #q
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   if i == 0 then
    exploreProgress(loops,tmp,i)
   else
    exploreProgress(loops,tmp,i)
   end
  end
 end
 done = false
 q = getCubeSel(xq,yq,zq,xw,yw,zw,126)
 tmp = #q
 loops = 1
 end
 while not done do --Safety loop, gets any missed spots at the cost of being slower. That's why we did a fast loop before, to clear out most of the unmapped blocks
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   t1,t2,t3 = getCoordsInDir(xe,ye,ze,a)
   pathfind(t1,t2,t3,10)
   mapSides()
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   exploreProgress(loops,tmp,3)
  end
 end
 exploreProgress(loops-1,tmp,4)
 if goback then pathfind(xs,ys,zs) end
 return done
end

function exploreProgress(loops,tmp,stage)
 if not stage then stage = 1 end
 local extra = 10*(stage-1)
 local width,height = term.getSize()
 term.clear()
 term.setCursorPos(1,math.floor(height/2)-3)
 term.write("{[")
 local i = 0
 if stage < 4 then
  while i < math.floor((loops/tmp)*10)+extra do
   i = i + 1
   term.write("=")
  end
  i = 0
 else term.write("==============================") end
 if stage < 4 then
  while i < 30-math.floor((loops/tmp)*10)-extra do
   i = i + 1
   term.write(" ")
  end
 end
 term.write("]}")
 term.setCursorPos(math.floor(width/2)-7,math.floor(height/2)-2)
 if stage < 4 then term.write("|"..math.floor((loops/tmp)*33+(extra*3.3)).."% complete|") else term.write("|100% complete|") end
 term.setCursorPos(1,math.floor(height/2)-1)
 term.write(loops.." of "..tmp.." possible blocks")
 term.setCursorPos(1,math.floor(height/2))
 term.write("explored.")
 term.setCursorPos(1,math.floor(height/2)+1)
 if stage < 3 then term.write("Stage "..stage.." of 3.") else term.write("Stage 3 of 3.") end
 term.setCursorPos(1,math.floor(height/2)+2)
 term.write("Do not ctrl^T, shutdown, or exit")
 term.setCursorPos(1,math.floor(height/2)+3)
 term.write("the game while exploring, or else")
 term.setCursorPos(1,math.floor(height/2)+4)
 term.write("you may experience data corruption.")
 term.setCursorPos(1,height)
end

function exploreTypeSel(xq,yq,zq,xw,yw,zw,goback,mode)
 print("Warning: exploreTypeSel() is in beta testing, expect an occasional bug.")
 mapSidesType()
 if goback == nil then goback = true end
 if mode == nil then mode = true end
 local xs,ys,zs = getPos()
 local q,w
 local xe,ye,ze
 local a
 local done = false
 local loops = 1
 q = getCubeSel(xq,yq,zq,xw,yw,zw,126)
 local tmp = #q
 if #q == 0 then exploreProgress(1,1,4) return true end
 for i=1,2,1 do
 while not done do
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   t1,t2,t3 = getCoordsInDir(xe,ye,ze,a)
   pathfind(t1,t2,t3,10)
   mapSidesType()
   q = getCubeSel(xq,yq,zq,xw,yw,zw,126,i)
   tmp = #q
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   if i == 0 then
    exploreProgress(loops,tmp,i)
   else
    exploreProgress(loops,tmp,i)
   end
  end
 end
 done = false
 q = getCubeSel(xq,yq,zq,xw,yw,zw,126)
 tmp = #q
 loops = 1
 end
 while not done do --Safety loop, gets any missed spots at the cost of being slower. That's why we did a fast loop before, to clear out most of the unmapped blocks
  w = getSeperated(q[loops]..",|")
  xe,ye,ze = w[1],w[2],w[3]
  a = getBlockTypeDirection(air,getBorderingBlocks(xe,ye,ze))
  if a and a ~= 6 then
   t1,t2,t3 = getCoordsInDir(xe,ye,ze,a)
   pathfind(t1,t2,t3,10)
   mapSidesType()
  end
  loops = loops + 1
  if loops > tmp then done = true end
  if mode and not done then
   exploreProgress(loops,tmp,3)
  end
 end
 exploreProgress(loops-1,tmp,4)
 if goback then pathfind(xs,ys,zs) end
 return done
end

function pathfind(xe,ye,ze,tc,up,s,t)
 local ue
 if not tc then ue = false else ue = true end
 if not tc then tc = 10 else tc = math.abs(tc) end
 if not up then up = false end
 if not s then s = 0 end
 if not t then t = false else t = true end
 local xs,ys,zs = getPos()
 waypoints = getWaypoints(xs,ys,zs,xe,ye,ze,ue,up)
 local tmp,done,breaking
 local tries = 0
 prev = waypoints
 local cooldown = 0
 local _,__,___
 while not done do
  tries = tries + 1
  tmp = 0
  for i=1,min(#prev,#waypoints),1 do
   if prev[i]:getPos() ~= waypoints[i]:getPos() then breaking = i else breaking = -1 end
  end
  if not breaking then breaking = -1 end
  if breaking > -1 then _,__,___ = waypoints[breaking - 1]:getPos() pathfind(_,__,___,tc) end
  for k,v in pairs(waypoints) do
   cooldown = cooldown + 1 if cooldown >= 100 then cooldown = 0 sleep(0) end
   if (k >= breaking or breaking == -1) and not goToCoordsPath(v:getPos()) and k ~= 1 then
    tmp = -1
    done = false
    break
   end
  end
  prev = waypoints
  if tmp ~= -1 then
   goToCoordsPath(xe,ye,ze)
   done = true
  else
   if s < 1 then
    if t then mapSidesType() else mapSides() end
    if tries >= tc then tries = 0 xs,ys,zs = getPos() end
    waypoints = getWaypoints(xs,ys,zs,xe,ye,ze,ue,up)
   else
    explore(s)
    if tries >= tc then tries = 0 xs,ys,zs = getPos() end
    waypoints = getWaypoints(xs,ys,zs,xe,ye,ze,ue,up)
   end
  end
 end
 return true
end

function getWaypoints(xs,ys,zs,xe,ye,ze,ue,up)
 local returnpack = {}
 local done = false
 local xp,yp,zp = xs,ys,zs
 local penalty = 0
 if xs == xe and ys == ye and zs == ze then return {xs..","..ys..","..zs} end
 local open = {}
 nodes = {} nodeF = {}
 local closest = nil
 if s and getBlock(xe,ye,ze) == 126 then
  closest = getClosest(xe,ye,ze,5,air) 
  if #closest ~= 0 then
   local w = getSeperated(closest[1]..",|")
   pathfind(w[1],w[2],w[3])
  end
 end
 local tmp,temp
 local cooldown = 0
 open[1] = Node:new(xs,ys,zs,xe,ye,ze,1,false,true)
 table.sort(nodeF)
 table.sort(open, function(a,b) return a.f<b.f end)
 while not done do
  for ii=0,5,1 do
   tmp = nil
   temp = false
   cooldown = cooldown + 1 if cooldown > 50 then sleep(0) cooldown = 0 end
   xs,ys,zs = open[1]:getPos()
   if (getBlockInDir(xs,ys,zs,ii) == 0 or (ue and getBlockInDir(xs,ys,zs,ii) == 126)) and temp ~= true then
    if getBlockInDir(xs,ys,zs,ii) == 126 then penalty = up end
    xs,ys,zs = getCoordsInDir(xs,ys,zs,ii)
    for iii=1,#open,1 do if open[iii]:getPosString() == xs..","..ys..","..zs then tmp = true temp = open[iii] end end
    if not tmp then
     open[#open+1] = Node:new(xs,ys,zs,xe,ye,ze,#nodes+1,open[1].ID,false,penalty)
     if open[#open]:getPosString() == xe..","..ye..","..ze then done = open[#open] end
    elseif open[1].g > temp.g + 10 then
     open[1].pid = temp.pid
     tmp = getSeperated(open[1].pid..",|")
     open[1].g = nodes[tmp[#tmp]].g + 10
     open[1].f = open[1].g + open[1].h
     nodeF[open[1].ID] = open[1].f
     table.sort(nodeF)
     table.sort(open, function(a,b) return a.f<b.f end)
    end
   end
   penalty = 0
  end
  if temp == true then xs,ys,zs = xp,yp,zp open[1] = Node:new(xp,yp,zp,xe,ye,ze,1,false,true) break end
  nodeF[open[1].ID] = math.huge
  table.remove(open,1)
  table.sort(nodeF)
  table.sort(open, function(a,b) return a.f<b.f end)
  if #open == 0 then done = false end
 end
 table.sort(nodeF)
 table.sort(open, function(a,b) return a.f<b.f end)
 if done then
  tmp = getSeperated(done.pid.."|")
  for i=1,#tmp,1 do
   table.insert(returnpack,nodes[tmp[i]])
  end
  nodes = {} nodeF = {}
  return returnpack
 else nodes = {} nodeF = {} return {} end
end

main()
