if viewportAPI then os.unloadAPI("viewportAPI") end
os.loadAPI("/disk/dev/touchscreen-api/viewportAPI")
if buttonAPI then os.unloadAPI("buttonAPI") end
os.loadAPI("/disk/dev/touchscreen-api/buttonAPI")
if eventDispatcherAPI then os.unloadAPI("eventDispatcherAPI") end
os.loadAPI("/disk/dev/touchscreen-api/eventDispatcherAPI")

-- Connect to the global network through the modem on the back face
rednet.open("back")

args = {...}

scriptName = "elevator.lua"

if #args <= 1 then
    print("Usage:")
    print("Print to terminal :\t"..scriptName.." term <floor level>")
    print("Print to monitor  :\t"..scriptName.." <monitor wrap-id> <floor level>")
    print("Examples:")
    print("\t"..scriptName.." monitor_4 0")
    print("\t"..scriptName.." right -2")

    error()
end

local floors = {
    "0",
    "-1",
    "-2"
}

local wrapId = args[1]
local thisFloor = args[2]
local rednetProtocol = "MainElevator"

local buttons = {}
local buttonHeight = 1
--local floorPrefix = "Current: "
local floorPrefix = ""

if wrapId == "term" then
    wrapped = term
else
    wrapped = peripheral.wrap(wrapId)
end

local viewport = viewportAPI.new({
    term = wrapped,
    textScale = 0.5
})
local track = peripheral.find("routing_track")

buttonHandler = function(element, x, y)
    statusbtn.text = floorPrefix..element.text
    rednet.broadcast(element.text, rednetProtocol)

    return true -- requests redraw of current viewport
end

statusbtn = buttonAPI.new({
    text = floorPrefix,
    x = buttonAPI.anchorLeft,
    y = buttonAPI.anchorBottom,
    height = buttonHeight,
    width = buttonAPI.maxWidth,
    isSticky = true,
    backgroundColor = colors.green
})
viewport:addElement(statusbtn)

for key, value in ipairs(floors) do
    table.insert(
        buttons,
        buttonAPI.new({
            text = value,
            x = buttonAPI.anchorLeft,
            y = key * 2 * buttonHeight,
            height = buttonHeight,
            width = buttonAPI.maxWidth,
            isSticky = true,
            backgroundColor = colors.blue,
            callback = buttonHandler
        })
    )

    viewport:addElement(buttons[key])
end

viewport:redraw()

if wrapId == "term" then
    eventDispatcherAPI.addHandler("mouse_click", function(event, side, xPos, yPos)
        viewport:handleClick(xPos, yPos)
    end)
else
    eventDispatcherAPI.addFilteredHandler("monitor_touch", wrapId, function(event, side, xPos, yPos)
        viewport:handleClick(xPos, yPos)
    end)
    eventDispatcherAPI.addFilteredHandler("monitor_resize", wrapId, function()
        viewport:redraw()
    end)
end

eventDispatcherAPI.runDispatchLoop()