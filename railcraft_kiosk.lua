destinations = {
    "House",
    "NetherMeteor",
    "DesertJungle",
    "VolcanoVillage",
    "Creek"
}

while true do

    term.clear()
    print("\nAvailable destinations:")

    for i = 1, #destinations do
        print("\t"..i..": "..destinations[i])
    end

    print("")

    repeat
        io.write("Your choice? [1-"..#destinations.."] ")
        user_input = tonumber(read()) or 0
    until math.floor(user_input) == user_input and user_input > 0 and user_input < 6

    print("Choo choo too "..destinations[user_input].."!")

    local chest = peripheral.find("minecraft:chest")
    if chest then
        for slot, item in pairs(chest.list()) do
            print(("%d x %s in slot %d"):format(item.count, item.name, slot))
        end
    else
        print("No chest!")
    end

    sleep(1)
end