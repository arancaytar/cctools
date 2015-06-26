--[[
Umaroth's Power Monitor v1.3

Monitors TE4 Energy Cells and EnderIO Capacitor Banks and outputs a redstone signal once energy storage drops below set limits.
Will automatically detect any compatible energy storage and monitors and connect to all of them. They can be either directly adjacent to the computer or connected through a wired modem network. Monitor size must be 2x3 or 1x2.
Redstone signal output for the engines is off by default but can be changed easily on line 18.
Also supports BigReactors Reactors and Turbines. Maximum 1 of each.

Requires either OpenPeripheralsIntegration or Computronics or both. Computronics is recommended because OpenP doesn't fully support Capacitor Banks. If you have OpenPeripherals but not Computronics you must use the workaround on line 19 for Capacitor Banks to work.

Script overhaul by Umaroth. Original script located here: http://tinyurl.com/kuaxv2p
Changelog/README: http://pastebin.com/erPf3t4t
--]]

--You can change these:
local upper = 0.90 --Upper limit for computer to stop transmitting redstone signal. 0.98=98% full.
local lower = 0.45 --Lower limit for computer to start transmitting redstone signal.
local redstoneSide = "none" -- Change this to the side you want to output the redstone signal to. ["left","right","top","bottom","front","back","none"]
local capacitorBankBlocks = 0 -- If you have OpenPeripherals without Computronics you need to specify how many blocks your Capacitor Bank contains. Only works properly for one Capacitor Bank. If you have Computronics, this variable won't do anything.
local url = "http://ermarian.net/resources/minecraft/iridium/power"
local httpDelay = 180

--Don't change these:
cellCount = 0
connectedCells = {}
connectedOPCapBank = ""
monitorCount = 0
connectedMonitors = {}
TE4Cell = 0 EIOCell = 0 OPCapBank = 0
periList = peripheral.getNames()
validPeripherals = {
    "tile_thermalexpansion_cell",
    "powered_tile",
    "tile_blockcapacitorbank_name",
    "capacitor_bank",
    "monitor",
    "BigReactors%-Turbine",
    "BigReactors%-Reactor"
}

function checkValidity(periName)
    for n,b in pairs(validPeripherals) do
        if periName:find(b) then return b end
    end
    return false
end

for i,v in ipairs(periList) do
    local periFunctions = {
        ["tile_thermalexpansion_cell"] = function()
            cellCount = cellCount + 1
            TE4Cell= TE4Cell + 1
            connectedCells[cellCount] = periList[i]
        end,
        ["powered_tile"] = function()
            cellCount = cellCount + 1
            TE4Cell= TE4Cell + 1
            connectedCells[cellCount] = periList[i]
        end,
        ["tile_blockcapacitorbank_name"] = function()
            EIOCell = EIOCell + 1
            OPCapBank = OPCapBank + 1
            connectedOPCapBank = periList[i]
        end,
        ["capacitor_bank"] = function()
            cellCount = cellCount + 1
            EIOCell = EIOCell + 1
            connectedCells[cellCount] = periList[i]
        end,
        ["monitor"] = function()
            monitorCount = monitorCount + 1
            connectedMonitors[monitorCount] = periList[i]
        end,
        ["BigReactors%-Turbine"] = function()
            turbine = peripheral.wrap(periList[i])
        end,
        ["BigReactors%-Reactor"] = function()
            reactor = peripheral.wrap(periList[i])
        end
    }

    local isValid = checkValidity(peripheral.getType(v))
    if isValid then periFunctions[isValid]() end
end

--Check for storage cells and monitors before continuing
if cellCount == 0 and OPCapBank == 0 then
    print("No RF storage found. Exiting script!")
    return
end
if monitorCount == 0 then
    print("No Monitor found. Exiting script!")
    return
end
    --Compatibility with OpenPeripherals
if OPCapBank > 1 then
    print("Error: Without Computronics this script can only support a maximum of one Capacitor Bank. Exiting Script!")
    return
elseif OPCapBank == 1 and capacitorBankBlocks == 0 then
    print("Warning: You have not entered how many blocks your Capacitor Bank contains, the script will not return the correct numbers. Please fix this by editing the script and changing the variable 'capacitorBankBlocks'.")
elseif OPCapBank == 1 then
    print("Warning: OpenPeripherals does not fully support Capacitor Banks, numbers may not be fully accurate.")
end

--Function to set monitor sizes
function getMonitorSize(x, y)
    if x == 18 and y == 5 then
        return "small"
    elseif x == 29 and y == 12 then
        return "large"
    else
        print("Invalid monitor size detected. Exiting script!")
        return
    end
end

--Check monitor sizes before continuing
for i = 1, #connectedMonitors do
    local monitor = peripheral.wrap(connectedMonitors[i])
    if getMonitorSize(monitor.getSize()) == nil then
        return
    end
end

--Print connected peripherals
print("Peripherals connected:")
if monitorCount > 1 then print(monitorCount.." Monitors") else print(monitorCount.." Monitor") end
if TE4Cell ~= 1 then print(TE4Cell.." TE Energy Cells") else print(TE4Cell.." TE Energy Cell") end
if EIOCell ~= 1 then print(EIOCell.." Capacitor Banks") else print(EIOCell.." Capacitor Bank") end
if turbine ~= nil then print ("1 Turbine") else print ("0 Turbines") end
if reactor ~= nil then print ("1 Reactor") else print ("0 Reactors") end

--Main code

--Set default output states to off
if redstoneSide ~= "none" then redstone.setOutput(redstoneSide, false) end
if turbine ~= nil then turbine.setActive(false) end
if reactor ~= nil then reactor.setActive(false) end

--Clear all monitors
for i = 1, #connectedMonitors do
    local monitor = peripheral.wrap(connectedMonitors[i])
    monitor.clear()
end
engines = true
if redstoneSide ~= "none" then
  redstone.setOutput(redstoneSide, true)
end
if turbine ~= nil then turbine.setActive(true) end
if reactor ~= nil then reactor.setActive(true) end
fill = 0
sent = 0

--Main loop
while true do
    last = fill

  --Get all dynamic values
    --Get storage values
    local eNow = 0 eMax = 0 cellLoops = 0
    for i = 1, #connectedCells do
        cell = peripheral.wrap(connectedCells[i])
        eNow = eNow + cell.getEnergyStored()
        eMax = eMax + cell.getMaxEnergyStored()
        cellLoops = i
    end
    --Compatibility with OpenPeripherals
    if OPCapBank == 1 and cellLoops == #connectedCells then
        cell = peripheral.wrap(connectedOPCapBank)
        eNow = (eNow + cell.getEnergyStored()) * capacitorBankBlocks
        eMax = (eMax + cell.getMaxEnergyStored()) * capacitorBankBlocks
    end

    local time = os.clock()
    if httpDelay > 0 and time - sent >= httpDelay then
        http.post(url, "day="..os.day().."&time="..os.time().."&eNow="..eNow.."&eMax="..eMax)
        sent = time
    end

    --Compute engine activation ratio
    fill = eNow / eMax

    --Set storage scale
    if eNow >= 1000000000 then eNowScale = "billion"
    elseif eNow >= 1000000 then eNowScale = "million"
    else eNowScale = "none" end
    if eMax >= 1000000000 then eMaxScale = "billion"
    elseif eMax >= 1000000 then eMaxScale = "million"
    else eMaxScale = "none" end

    --Adjust number to scale
    if eNowScale == "billion" then eNowValue = math.ceil(eNow / 1000000)
    elseif eNowScale == "million" then eNowValue = math.ceil(eNow / 1000)
    else eNowValue = math.ceil(eNow) end
    if eMaxScale == "billion" then eMaxValue = math.ceil(eMax / 1000000)
    elseif eMaxScale == "million" then eMaxValue = math.ceil(eMax / 1000)
    else eMaxValue = math.ceil(eMax) end

    --Adjust suffix to scale
    if eNowScale == "billion" then eNowSuffixLarge = "m RF" eNowSuffixSmall = "mRF"
    elseif eNowScale == "million" then eNowSuffixLarge = "k RF" eNowSuffixSmall = "kRF"
    else eNowSuffixLarge = " RF" eNowSuffixSmall = " RF" end
    if eMaxScale == "billion" then eMaxSuffixLarge = "m RF" eMaxSuffixSmall = "mRF"
    elseif eMaxScale == "million" then eMaxSuffixLarge = "k RF" eMaxSuffixSmall = "kRF"
    else eMaxSuffixLarge = " RF" eMaxSuffixSmall = " RF" end

    --Get number of digits to write
    local eNowDigitCount = 0 eMaxDigitCount = 0
    for digit in string.gmatch(eNowValue, "%d") do eNowDigitCount = eNowDigitCount + 1 end
    for digit in string.gmatch(eMaxValue, "%d") do eMaxDigitCount = eMaxDigitCount + 1 end

    --Get location to write
    if eNowSuffixLarge ~= " RF" then eNowXLarge = 8 - eNowDigitCount
    else eNowXLarge = 9 - eNowDigitCount end
    eNowXSmall = 16 - eNowDigitCount
    if eMaxSuffixLarge ~= " RF" then eMaxXLarge = 25 - eMaxDigitCount
    else eMaxXLarge = 26 - eMaxDigitCount end
    eMaxXSmall = 16 - eMaxDigitCount

    if fill > upper then
        --Energy level is over upper level, turning redstone/reactors off
        if redstoneSide ~= "none" then
            redstone.setOutput(redstoneSide, false)
        end
        if turbine ~= nil then turbine.setActive(false) end
        if reactor ~= nil then reactor.setActive(false) end
        engines = false
    elseif fill < lower then
        --Energy level is below lower limit, turning redstone/reactors on
        if redstoneSide ~= "none" then
            redstone.setOutput(redstoneSide, true)
        end
        if turbine ~= nil then turbine.setActive(true) end
        if reactor ~= nil then reactor.setActive(true) end
        engines = true
    end

    --Loop to write to every monitor
    for i = 1, #connectedMonitors do
        local monitor=peripheral.wrap(connectedMonitors[i])

        if getMonitorSize(monitor.getSize()) == "large" then
            monitor.setCursorPos(9, 1)
            monitor.write("Power Status")
            --Erase old data
            monitor.setCursorPos(13,8)
            monitor.write("    ")
            monitor.setCursorPos(3,9)
            monitor.write("       ")
            monitor.setCursorPos(20,9)
            monitor.write("       ")
            --Write constant/new data
            monitor.setCursorPos(3,8)
            monitor.write("Storage:")
            monitor.setCursorPos(eNowXLarge,9)
            monitor.write(eNowValue..eNowSuffixLarge)
            monitor.setCursorPos(20,8)
            monitor.write("Capacity:")
            monitor.setCursorPos(eMaxXLarge,9)
            monitor.write(eMaxValue..eMaxSuffixLarge)

            monitor.setCursorPos(5, 11)
            if (last - fill <= 0) then
                monitor.setBackgroundColour((colours.green))
                if (last - fill < 0) then
                    monitor.write(" Rising  ")
                else
                    monitor.write(" Holding ")
                end
            else
                monitor.setBackgroundColour((colours.red))
                monitor.write(" Falling ")
            end

            monitor.setCursorPos(17, 11)
            if engines then
                monitor.setBackgroundColour((colours.yellow))
            else
                monitor.setBackgroundColour((colours.grey))
            end
            monitor.write(" Reactor ")

            monitor.setBackgroundColour((colours.green))
            for i = 0, 24 do
                for j = 0, 3 do
                    if 4*i+j > fill * 100 then
                        monitor.setBackgroundColour((colours.red))
                    end
                    monitor.setCursorPos(3+i,3+j)
                    monitor.write(" ")
                end
            end
            monitor.setBackgroundColour((colours.black))
            if fill == 1 then
                monitor.setCursorPos(13, 8)
            elseif fill >= 0.1 then
                monitor.setCursorPos(14, 8)
            else monitor.setCursorPos(15, 8) end
            monitor.write(string.format("%d%%", math.floor(fill * 100)+0.5))
        elseif getMonitorSize(monitor.getSize()) == "small" then
            --erase old data
            monitor.setCursorPos(10,3)
            monitor.write("       ")
            monitor.setCursorPos(10,5)
            monitor.write("       ")
            --write constant/new data
            monitor.setCursorPos(2,2)
            monitor.write("Engines:")
            if engines then
                monitor.setBackgroundColour((colours.green))
                monitor.setCursorPos(1,4)
                monitor.write(" ON ")
                monitor.setBackgroundColour((colours.grey))
                monitor.setCursorPos(5,4)
                monitor.write(" OFF ")
                monitor.setBackgroundColour((colours.black))
            else
                monitor.setBackgroundColour((colours.grey))
                monitor.setCursorPos(1,4)
                monitor.write(" ON ")
                monitor.setBackgroundColour((colours.green))
                monitor.setCursorPos(5,4)
                monitor.write(" OFF ")
                monitor.setBackgroundColour((colours.black))
            end
            monitor.setCursorPos(11,2)
            monitor.write("Storage:")
            monitor.setCursorPos(eNowXSmall,3)
            monitor.write(eNowValue..eNowSuffixSmall)
            monitor.setCursorPos(eMaxXSmall,4)
            monitor.write("of:")
            monitor.setCursorPos(eMaxXSmall,5)
            monitor.write(eMaxValue..eMaxSuffixSmall)
        end
    end
    sleep(1)
end --while
