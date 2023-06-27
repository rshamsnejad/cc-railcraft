destinations = {
    "House",
    "NetherMeteor",
    "DesertJungle",
    "VolcanoVillage",
    "Creek"
}

while true do
    print("Available destinations:")

    for i = 1, #destinations do
        print("\t"..i..": "..destinations[i])
    end

    print("")

    repeat
        io.write("Your choice? [1-"..#destinations.."] ")
        user_input = tonumber(read())
    until math.floor(user_input) == user_input and user_input > 0 and user_input < 6

    print("Choo choo too "..destinations[user_input].."!")
end