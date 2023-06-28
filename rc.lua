if viewportAPI then os.unloadAPI("viewportAPI") end
os.loadAPI("/dev/touchscreen-api/viewportAPI")
if buttonAPI then os.unloadAPI("buttonAPI") end
os.loadAPI("/dev/touchscreen-api/buttonAPI")
if eventDispatcherAPI then os.unloadAPI("eventDispatcherAPI") end
os.loadAPI("/dev/touchscreen-api/eventDispatcherAPI")

destinations = {
    "House",
    "NetherMeteor",
    "DesertJungle",
    "VolcanoVillage",
    "Creek"
}
buttons = {}
buttonHeight = 1

viewport = viewportAPI.new({term = term})

handler = function(element, x, y)
    term.setBackgroundColor(colors.black)
    term.clear()

    print("Destination: "..element.text)

    error()

    return true -- requests redraw of current viewport
end

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
            backgroundColor = colors.green
        })
    )

    buttons[key].callback = handler

    viewport:addElement(buttons[key])
end


viewport:redraw()


eventDispatcherAPI.addHandler("mouse_click", function(event, side, xPos, yPos)
    viewport:handleClick(xPos, yPos)
end)

eventDispatcherAPI.runDispatchLoop()