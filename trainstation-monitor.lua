if viewportAPI then os.unloadAPI("viewportAPI") end
os.loadAPI("/disk/dev/touchscreen-api/viewportAPI")
if buttonAPI then os.unloadAPI("buttonAPI") end
os.loadAPI("/disk/dev/touchscreen-api/buttonAPI")
if eventDispatcherAPI then os.unloadAPI("eventDispatcherAPI") end
os.loadAPI("/disk/dev/touchscreen-api/eventDispatcherAPI")

local destinations = {
    "House",
    "NetherMeteor",
    "JungleDesert",
    "VolcanoVillage",
    "Creek"
}

local buttons = {}
local buttonHeight = 1
--local destinationPrefix = "Current: "
local destinationPrefix = ""

wrapped = "left"
touchMonitor = peripheral.wrap(wrapped)
local viewport = viewportAPI.new({
    term = touchMonitor,
    textScale = 0.5
})
local track = peripheral.find("routing_track")

buttonHandler = function(element, x, y)
    track.setDestination(element.text)

    statusbtn.text = destinationPrefix..track.getDestination()

    return true -- requests redraw of current viewport
end

quit = function(element, x, y)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
end

statusbtn = buttonAPI.new({
    text = destinationPrefix..track.getDestination(),
    x = buttonAPI.anchorLeft,
    y = buttonAPI.anchorBottom,
    height = buttonHeight,
    width = buttonAPI.maxWidth,
    isSticky = true,
    backgroundColor = colors.green
})
viewport:addElement(statusbtn)

for key, value in ipairs(destinations) do
    table.insert(
        buttons,
        buttonAPI.new({
            text = value,
            x = buttonAPI.anchorLeft,
            y = key * 2 * buttonHeight,
            height = buttonHeight,
            width = buttonAPI.maxWidth,
            isSticky = true,
            backgroundColor = colors.blue
        })
    )

    buttons[key].callback = buttonHandler

    viewport:addElement(buttons[key])
end

viewport:redraw()

eventDispatcherAPI.addFilteredHandler("monitor_touch", wrapped, function(event, side, xPos, yPos)
    viewport:handleClick(xPos, yPos)
end)
eventDispatcherAPI.addFilteredHandler("monitor_resize", wrapped, function()
       viewport:redraw()
end)

eventDispatcherAPI.runDispatchLoop()