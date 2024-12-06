_addon.name = 'MissionGuide'
_addon.author = 'YourName'
_addon.version = '1.0'
_addon.commands = {'mission'}

-- Mission data
local missions = {
    ["Zilart Missions"] = {
        { mission = "ZM1: The New Frontier", location = "Norg", note = "Speak to Gilgamesh to start the mission." },
        { mission = "ZM2: Welcome t' Norg", location = "Norg", note = "Speak to Ryoma in Norg to complete." },
        { mission = "ZM3: Kazham's Chieftainess", location = "Kazham", note = "Speak to Romaa Mihgo in Kazham." },
        { mission = "ZM4: The Temple of Uggalepih", location = "Temple of Uggalepih", note = "Examine the Paintbrush Door for a cutscene." },
        { mission = "ZM5: Headstone Pilgrimage", location = "Various Locations", note = "Examine headstones at Cloister zones. Prepare for fights." },
        { mission = "ZM6: Through the Quicksand Caves", location = "Quicksand Caves", note = "Defeat the Antican NMs and examine the door." },
        { mission = "ZM7: The Chamber of Oracles", location = "Ru'Aun Gardens", note = "Examine the Celestial Nexus for a cutscene." },
        { mission = "ZM8: Return to Delkfutt's Tower", location = "Delkfutt's Tower", note = "Defeat the NM and proceed to the top for a cutscene." },
        { mission = "ZM9: Ro'Maeve", location = "Ro'Maeve", note = "Obtain the Lightbringer Key Item." },
        { mission = "ZM10: The Celestial Nexus", location = "Ru'Aun Gardens", note = "Prepare for a difficult fight at the Celestial Nexus." },
        { mission = "ZM11: The Hall of the Gods", location = "Hall of the Gods", note = "Return to the Hall of the Gods to complete." },
        { mission = "ZM12: The Mithra and the Crystal", location = "Various Locations", note = "Follow up at Norg and Ru'Aun Gardens." },
        { mission = "ZM13: Ark Angels", location = "Various Locations", note = "Defeat the five Ark Angels in separate battles." },
        { mission = "ZM14: Awakening", location = "Celestial Nexus", note = "Final battle against Kam'lanaut. Cutscenes will follow." }
    }
}

-- Current mission index (default to the first mission)
local current_mission_index = 1
local current_category = "Zilart Missions"

-- Command handling
ashita.register_event('command', function(command, nType)
    local args = command:args()

    if args[1] == '/mission' then
        if args[2] == 'next' then
            if missions[current_category][current_mission_index] then
                local mission = missions[current_category][current_mission_index]
                print(string.format("Next Mission: %s", mission.mission))
                print(string.format("Location: %s", mission.location))
                print(string.format("Note: %s", mission.note))
            else
                print("No more missions in this category!")
            end
            return true
        elseif args[2] == 'complete' then
            current_mission_index = current_mission_index + 1
            print("Mission marked as complete. Use '/mission next' for the next step.")
            return true
        elseif args[2] == 'set' and args[3] then
            current_mission_index = tonumber(args[3])
            print("Mission index set to: " .. current_mission_index)
            return true
        elseif args[2] == 'category' and args[3] then
            current_category = args[3]
            current_mission_index = 1
            print("Category set to: " .. current_category)
            return true
        end
    end
    return false
end)
