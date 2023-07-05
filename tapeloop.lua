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

tape = peripheral.find("tape_drive")

tape.seek(-tape.getSize())
tape.play()

while true do
    sleep(sleep_time_s)
    tape.seek(-tape.getSize())
end