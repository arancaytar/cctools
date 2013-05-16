os.loadAPI("aran/navigation")

function ensureInventory()
  for i = 1,16,1 do
    if turtle.getItemCount(i) > 0 then
      turtle.select(i)
      return true
    end
  end
  return false
end

args = {...}

-- open pattern file

function buildPattern(filename)
  x,y,z = gps.locate()
  file = fs.open(filename, 'r')

  line = file.readLine()
  i = 0
  n = 0
  while ensureInventory and line ~= nil do
    n = #line
    if i % 2 > 0 then
      line = string.reverse(line)
    end
    if i > 0 then
      d = (i%2)*2 - 1
      navigation.rotate(d)
      if not turtle.forward() then
        navigation.moveTo(x,y,z)
        file.close()
        error("Blocked.")
      end
      navigation.rotate(d)
    end  
    for j = 1, #line, 1 do
      if j > 1 then
        if not turtle.forward() then 
          navigation.moveTo(x,y,z)
          file.close()
          error("Blocked")
          return false
        end
      end
      if string.sub(line,j,j) == '#' then
        if not ensureInventory() then 
          navigation.moveTo(x,y,z)
          file.close()
          error("Empty")
          return false
        end
        turtle.placeDown()
      end
    end
    line = file.readLine()
    i = i + 1
  end
  navigation.moveTo(x,y+1,z)
  file.close()
end

for i = 1,tonumber(args[2]),1 do
  buildPattern(args[1])
end
