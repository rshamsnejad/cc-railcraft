-- WORKFLOW:
-- 1/ Convert a .wav file to a .dfpwm one with LionRay DFPWM Converter
-- 2/ Upload on tmpfiles.org
-- 3/ `wget` that shit
-- 4/ `tape write` that wgotten thing
-- 5/ Call this here script like this:
--     `loop 3.2`
--    with 3.2 to replace with the end time of the loop

sleep_time_s = 4

args = {...}
if #args >= 1 then
    sleep_time_s = tonumber(args[1])
end

-- Instanciate the peripherals, do a little cleanup
tape = peripheral.find("tape_drive")
tape.stop()
tape.seek(-tape.getSize())

monitor = peripheral.find("monitor")
if monitor then
    monitor.clear()
    monitor.setCursorPos(1, 1)
end
--------------------------------------------------------------------------------

-- Main loop
while true do

    -- Green wire is the start button, sleep until it's on
    while not(redstone.testBundledInput("top", colors.combine(colors.green))) do
        sleep(0.5)
    end

    -- Sound on
    tape.play()
    -- Lights on
    redstone.setOutput("back", true)

    -- Write the tape's name to an eventual monitor
    if monitor then
        w, h = monitor.getSize()

        monitor.clear()
        monitor.setCursorPos(2, h/2)
        monitor.write(tape.getLabel())
    end

    -- Loop the music
    ---- Rewinding does not affect the playing state, so calling seek() over and
    ---- over works by itself
    while true do
        sleep(sleep_time_s)
        tape.seek(-tape.getSize())

        -- Red wire is stop button (with hardware buffer)
        if redstone.testBundledInput("top", colors.combine(colors.red)) then
            -- Sound off and rewind
            tape.stop()
            tape.seek(-tape.getSize())
            -- Lights off
            redstone.setOutput("back", false)

            -- Tape name off
            if monitor then
                monitor.clear()
            end

            break
        end
    end
end