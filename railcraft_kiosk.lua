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

    io.write("\rChoo choo too "..destinations[user_input].."!")

    sleep(1)
end