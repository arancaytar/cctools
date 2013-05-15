local position

function returnToStart()
  

function ensureInventory()
  for i = 1,16,1 do
    if turtle.getItemCount(i) > 0 then
      turtle.select(i)
      return
    end
  end
  error("Empty.")
end

args = {...}

-- open pattern file

function buildPattern(filename)
  file = fs.open(filename, 'r')

  line = file.readLine()
  i = 0
  n = 0
  while line ~= nil do
    n = #line
    if i % 2 > 0 then
      line = string.reverse(line)
      turtle.turnRight()
      turtle.forward()
      turtle.turnRight()
    elseif i > 0 then
      turtle.turnLeft()
      turtle.forward()
      turtle.turnLeft()
    end
    for j = 1, #line, 1 do
      if j > 1 then
        turtle.forward()
      end
      if string.sub(line,j,j) == '#' then
        ensureInventory()
        turtle.placeDown()
      end
    end
    line = file.readLine()
    i = i + 1
  end
  if i % 2 > 0 then
    for j = 1, n - 1, 1 do
      turtle.back()
    end
  else
    turtle.turnLeft()
    turtle.turnLeft()
  end
  turtle.turnRight()
  for j = 1, i-1, 1 do
    turtle.back()
  end
  turtle.turnLeft()
  turtle.up()  
  file.close()
end


for i = 1,tonumber(args[2]),1 do
  buildPattern(args[1])
end
