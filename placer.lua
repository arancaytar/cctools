function checkInventory()
  for i = 1,16,1 do
    if turtle.getItemCount(i) > 0 then
      turtle.select(i)
      return true
    end
  end
  print("Empty inventory!")
  return false
end

