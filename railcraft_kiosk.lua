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

    io.write("\nYour choice? [1-"..#destinations.."] ")

    user_input = io.read("*n")

    print("Choo choo too "..destinations[user_input].."!")
end