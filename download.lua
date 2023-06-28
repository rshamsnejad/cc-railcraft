args = {...}

pastebinId = args[1]
filename = "/disk/dev/"

if args[2] == nil then
    filename = filename.."pulledScript.lua"
else
    filename = filename..args[2]
end

if fs.exists(filename) then fs.delete(filename) end

shell.run("pastebin get "..pastebinId.." "..filename)

shell.run(filename)