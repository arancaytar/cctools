directions = {N=0, E=1, S=2, W=3}
direction = nil

-- robust direction-finder: find an open direction, move a step,
-- use gps to determine which way we moved.
function findDirection()
  x,y,z = gps.locate()
  if x == nil then
    print("Error: GPS unavailable.")
    return false
  end
  i = 0
  while i < 4 and turtle.detect() do
    i = i + 1
    turtle.turnRight()
  end
  if not turtle.forward() then
    print("Error: Cannot find bearing, boxed in.")
    return false
  end

  x2,y2,z2 = gps.locate()
  -- binary arithmancy: NESW = (S|W)(W|E)
  movedDir = ((x2 + z < x + z2) and 1 or 0)*2 + ((x2 ~= x) and 1 or 0)
  turtle.back()
  for j = 1,i,1 do
    turtle.turnLeft()
  end
  direction = (4 + movedDir - i) % 4
  return direction
end

function turnTo(dir)
  rotate(dir - direction)
end

function rotate(offset)
  spin = {[false] = turtle.turnLeft, [true] = turtle.turnRight}
  for i = 1,math.abs(offset),1 do
    spin[offset>0]()
  end
  direction = (direction + offset + 4) % 4
end

function moveTo(tx, ty, tz)
  x,y,z = gps.locate()
  while x ~= tx or y ~= ty or z ~= tz do
    if y < ty then m=turtle.up()
    elseif y > ty then m=turtle.down()
    else
      if x > tx then turnTo(directions.W)
      elseif x < tx then turnTo(directions.E)
      elseif z < tz then turnTo(directions.S)
      else turnTo(directions.N) end
      m=turtle.forward()
    end
    if not m then 
      print("Stuck moving to "..tx.." "..ty.." "..tz)
      return false
    end
    x,y,z = gps.locate()
  end
  return true
end
  
function init()
  findDirection()
end

init()
