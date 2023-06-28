if viewportAPI then os.unloadAPI("viewportAPI") end
os.loadAPI("/disk/dev/touchscreen-api/viewportAPI")
if buttonAPI then os.unloadAPI("buttonAPI") end
os.loadAPI("/disk/dev/touchscreen-api/buttonAPI")
if eventDispatcherAPI then os.unloadAPI("eventDispatcherAPI") end
os.loadAPI("/disk/dev/touchscreen-api/eventDispatcherAPI")

destinations = {
    "House",
    "NetherMeteor",
    "DesertJungle",
    "VolcanoVillage",
    "Creek"
}
buttons = {}
buttonHeight = 1
destinationPrefix = "Current destination: "

viewport = viewportAPI.new({term = term})

buttonHandler = function(element, x, y)
    statusbtn.text = destinationPrefix..element.text

    return true -- requests redraw of current viewport
end

quit = function(element, x, y)
    term.setBackgroundColor(colors.black)
    term.clear()
    error()
end

statusbtn = buttonAPI.new({
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