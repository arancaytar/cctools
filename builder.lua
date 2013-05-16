os.loadAPI("aran/navigation")
os.loadAPI("aran/strings")

-- reads a boolean matrix and returns an array of true positions.
function matrixToPositions(matr)
  positions = {}
  for i = 1,#matr,do
    for j = 1,#(matr[i]),do
      if matr[i][j] then
        -- in coordinate systems, the horizontal index precedes.
        table.insert(positions, {i, j})
      end
    end
  end
  return positions
end

-- maps a list of positions according to an origin and a cardinal direction.
-- this indicates what direction (NESW) increases the "horizontal" index
-- the other will be clockwise at a right angle.
function mapPositions(x, z, direction, positions)
  mapped = {}
  if direction == 0 then
    for i,j in positions do
      table.insert(mapped, x+i, z-j)
    end
  elseif direction == 1 then
    for i,j in positions do
      table.insert(mapped, x+j, z+i)
    end
  elseif direction == 2 then
    for i,j in positions do
      table.insert(mapped, x-i, z+i)
    end
  elseif direction == 3 then
    for i,j in positions do
      table.insert(mapped, x-j, z-i)
    end
  end
  return mapped
end

function copyPositions(positions)
  new = {}
  for i,j in positions do
    table.insert(new, {i,j})
  end
  return new
end

-- sorts a list of positions by DECREASING proximity.
-- removing elements from the end is faster.
function proxSort(x, z, positions)
  sorter = function(p1, p2)
    r1 = (p1[1]-x)^2 + (p1[2]-y)^2
    r2 = (p2[1]-x)^2 + (p2[2]-y)^2
    return r1 > r2
  end
  return table.sort(positions, sorter)
end

-- moves to every position in turn and fills it.
-- tries to optimize greedily; very good for single-path patterns.
function buildPositions(y, realPositions)
  n = #realPositions
  while n > 0 do
    x, z = realPositions[n]
    while not navigation.moveTo(x,y,z)
      sleep(10)
    end
    while not placer.checkInventory()
      sleep(10)
    end
    turtle.placeDown()
    table.remove(realPositions)
    table.sort(x, z, realPositions)
    n = n - 1
  end
end

-- builds a pattern, starting from current position, moving ahead.
function buildPattern(matrix, count)
  x, y, z = gps.locate()
  f = navigation.direction
  mapped = mapPositions(x, z, f, matrixToPositions(matrix))
  for i = 0,count-1,1 do
    tasks = copyPositions(positions)
    buildPositions(y+i, tasks)
  end
end

function loadPattern(filename)
  data = fs.open(filename, 'r').readAll()
  lines = string.lines(data)
  matrix = {}
  for i = 1,#lines,1 do
    matrix[i] = {}
    for j in 1,#(lines[i]),1 do
      matrix[i][j] = (string.sub(lines[i],j,j) == "#")
    end
  end
  return matrix
end
  
