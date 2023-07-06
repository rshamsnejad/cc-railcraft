tape = peripheral.find("tape_drive")

monitor = peripheral.find("monitor")
if monitor then
    monitor.clear()
end

redstone.setOutput("back", false)
tape.stop()
tape.seek(-tape.getSize())