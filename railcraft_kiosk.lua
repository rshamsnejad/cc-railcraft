destinations = {
    "House",
    "NetherMeteor",
    "DesertJungle",
    "VolcanoVillage",
    "Creek"
}
--destinations[0] = "House"

if true then
    print("Available destinations:")

    for i = 1, #destinations do
        print("\t"..i..": "..destinations[i])
    end

    print("")

    user_input = 0
    repeat
        io.stdin:flush()
        io.write("Your choice? [1-"..#destinations.."] ")
        user_input = io.read("*n")
    until math.floor(user_input) == user_input and user_input > 0 and user_input < 6

    print("Choo choo too "..destinations[user_input].."!")
end