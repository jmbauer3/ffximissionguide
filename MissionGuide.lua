addon.name      = 'MissionGuide';
addon.author    = 'YourName';
addon.version   = '1.3';
addon.desc      = 'Guides players through mission objectives.';
addon.link      = 'https://ashitaxi.com/';

require('common');

-- MissionGuide Variables
local missionguide = {
    current_mission = 1, -- Start at the first mission
    missions = {
        { name = "The New Frontier", location = "Ru'Lude Gardens", description = "Speak to Monberaux to begin your journey." },
        { name = "Through the Quicksand Caves", location = "Western Altepa Desert", description = "Find and use the Quicksand Caves entrance." },
        { name = "Return to Delkfutt's Tower", location = "Delkfutt's Tower", description = "Retrieve the key item at the top." },
    },
};

-- Utility function to split a string into parts
local function split(input, delimiter)
    local result = {};
    for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match);
    end
    return result;
end

--[[
* event: load
* desc : Event called when the addon is being loaded.
--]]
ashita.events.register('load', 'load_cb', function()
    -- Debug: Print current state upon load
    print('[MissionGuide] Addon loaded successfully!');
    print('[MissionGuide] Use /mg current to check your current mission or /mg next to begin!');
end);

--[[
* event: unload
* desc : Event called when the addon is being unloaded.
--]]
ashita.events.register('unload', 'unload_cb', function()
    print('[MissionGuide] Addon unloaded.');
end);

--[[
* event: command
* desc : Event called when a command is entered.
--]]
ashita.events.register('command', 'command_cb', function(command, nType)
    local cmd = tostring(command):lower(); -- Convert command userdata to string and lowercase it
    local args = split(cmd, ' ');
    
    if args[1] == '/mg' then
        if args[2] == 'next' then
            -- Display next mission
            local mission = missionguide.missions[missionguide.current_mission];
            if mission then
                print(string.format('[MissionGuide] Next Mission:\nName: %s\nLocation: %s\nDescription: %s',
                    mission.name, mission.location, mission.description
                ));
            else
                print('[MissionGuide] No more missions available.');
            end
            return true;
        elseif args[2] == 'complete' then
            -- Mark mission as complete
            if missionguide.current_mission < #missionguide.missions then
                missionguide.current_mission = missionguide.current_mission + 1;
                print('[MissionGuide] Mission marked as complete. Use /mg next to see the next mission.');
            else
                print('[MissionGuide] All missions completed!');
            end
            return true;
        elseif args[2] == 'current' then
            -- Display current mission
            local mission = missionguide.missions[missionguide.current_mission];
            if mission then
                print(string.format('[MissionGuide] Current Mission:\nName: %s\nLocation: %s\nDescription: %s',
                    mission.name, mission.location, mission.description
                ));
            else
                print('[MissionGuide] No active mission. Use /mg next to start!');
            end
            return true;
        else
            -- Handle invalid or missing commands
            print('[MissionGuide] Invalid command. Usage: /mg [next|complete|current]');
            return true;
        end
    end
    
    return false;
end);
