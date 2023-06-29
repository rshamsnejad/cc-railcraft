if viewportAPI then os.unloadAPI("viewportAPI") end
os.loadAPI("/disk/dev/touchscreen-api/viewportAPI")
if buttonAPI then os.unloadAPI("buttonAPI") end
os.loadAPI("/disk/dev/touchscreen-api/buttonAPI")
if eventDispatcherAPI then os.unloadAPI("eventDispatcherAPI") end
os.loadAPI("/disk/dev/touchscreen-api/eventDispatcherAPI")

local destinations = {
    "House",
    "NetherMeteor",
    "DesertJungle",
    "VolcanoVillage",
    "Creek"
}
local destinations_inv = {}
for key, value in pairs(destinations) do
    destinations_inv[value] = key
end

local buttons = {}
local buttonHeight = 1
local destinationPrefix = "Current destination: "

local viewport = viewportAPI.new({term = term})
chest_id = "minecraft:chest"
track_id = "railcraft:routing_track"
local chest = peripheral.find(chest_id)
local track = peripheral.find(track_id)

buttonHandler = function(element, x, y)
    -- Before we change it, statusbtn.text contains the previous destination,
    -- which should be the one of the ticket already in place
    track.pushItems(chest_id, 1, 1, destinations_inv[statusbtn.text])

    statusbtn.text = destinationPrefix..element.text
    chest.pushItems(track_id, destinations_inv[element.text], 1)

    return true -- requests redraw of current viewport
end

quit = function(element, x, y)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
end

local statusbtn = buttonAPI.new({
    text = "Current destination: "..destinations[1],
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


eventDispatcherAPI.addHandler("mouse_click", function(event, side, xPos, yPos)
    viewport:handleClick(xPos, yPos)
end)

eventDispatcherAPI.runDispatchLoop()