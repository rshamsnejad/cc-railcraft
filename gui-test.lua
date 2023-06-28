-- vim: set filetype=lua:

if viewportAPI then os.unloadAPI("viewportAPI") end
os.loadAPI("/dev/touchscreen-api/viewportAPI")
if buttonAPI then os.unloadAPI("buttonAPI") end
os.loadAPI("/dev/touchscreen-api/buttonAPI")
if eventDispatcherAPI then os.unloadAPI("eventDispatcherAPI") end
os.loadAPI("/dev/touchscreen-api/eventDispatcherAPI")

viewport = viewportAPI.new({term = term})

testbtn = buttonAPI.new({
    text = "test",
    x = buttonAPI.anchorLeft,
    y = buttonAPI.anchorTop,
    height = 1,
    width = buttonAPI.maxWidth,
    isSticky = true,
    backgroundColor = colors.green
})
viewport:addElement(testbtn)
exitbtn = buttonAPI.new({
    text = "Exit",
    x = buttonAPI.anchorLeft,
    y = buttonAPI.anchorBottom,
    height = 1,
    width = buttonAPI.maxWidth,
    isSticky = true,
    backgroundColor = colors.red
})
viewport:addElement(exitbtn)

viewport:redraw()

handler = function(element, x, y)
    if element == testbtn then
        element.backgroundColor = element.backgroundColor == colors.red and colors.green or colors.red
    elseif element == exitbtn then
        term.setBackgroundColor(colors.black)
        term.clear()
        error()
    else
        error("Unknown Button")
    end
    return true -- requests redraw of current viewport
end

testbtn.callback = handler
exitbtn.callback = handler

eventDispatcherAPI.addHandler("mouse_click", function(event, side, xPos, yPos)
    viewport:handleClick(xPos, yPos)
end)

eventDispatcherAPI.runDispatchLoop()