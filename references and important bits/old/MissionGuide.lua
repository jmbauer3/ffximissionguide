addon.name      = 'missionguide';
addon.author    = 'YourName';
addon.version   = '1.2';
addon.desc      = 'Displays the Zilart mission guide with detailed locations in a simple window.';
addon.link      = 'https://ashitaxi.com/';

require('common');
local imgui = require('imgui');

-- Mission Guide Variables
local mission_guide = {
    is_open = { true }, -- Toggle for the window
    current_step = 1,   -- Track the current mission step
    steps = {          -- Zilart mission steps with location details
        "ZM1: The New Frontier\n\nLocation: Norg\nSpeak to Gilgamesh in Norg (J-8). Obtain the key item 'Delkfutt Key' by completing the prerequisite quest in Delkfutt's Tower.",
        "ZM2: Welcome t' Norg\n\nLocation: Kazham\nHead to Kazham and speak to Guddal (G-7) to complete this step.",
        "ZM3: Kazham's Chieftainess\n\nLocation: Kazham\nSpeak to Jakoh Wahcondalo (J-9). Gather three fragments:\n- **Wind Fragment**: Enter the Cloister of Gales in Tahrongi Canyon.\n- **Earth Fragment**: Enter the Cloister of Tremors in Altepa Desert.\n- **Water Fragment**: Enter the Cloister of Tides in Den of Rancor.",
        "ZM4: The Temple of Uggalepih\n\nLocation: Temple of Uggalepih\nObtain the 'Paintbrush of Souls' from a Tonberry and use it to open the hidden door at (H-8). Proceed through the temple to complete the objective.",
        "ZM5: Headstone Pilgrimage\n\nLocations:\nVisit six headstones and engage in battles:\n- **North Gustaberg** (J-7)\n- **Meriphataud Mountains** (E-5)\n- **West Sarutabaruta** (F-6)\n- **Beaucedine Glacier** (G-10)\n- **Xarcabard** (H-7)\n- **Cape Teriggan** (I-6).",
        "ZM6: Through the Quicksand Caves\n\nLocation: Quicksand Caves\nObtain the 'Antican Praetor Key' by defeating Anticans in the caves. Use it to navigate the path to the Chamber of Oracles at (H-9).",
        "ZM7: The Hall of the Gods\n\nLocation: Hall of the Gods\nAccess the Hall of the Gods through Ro'Maeve. Interact with the door at (I-7) to unlock Tu'Lia (Sky).",
        "ZM8: Return to Delkfutt's Tower\n\nLocation: Delkfutt's Tower\nAscend the spire of Delkfutt's Tower and defeat the Shadow Lord. Bring a group for this challenging battle!",
        "ZM9: Ark Angels\n\nLocation: Hall of the Gods\nDefeat the five Ark Angels scattered across the Tu'Lia spires. Each fight is unique, so bring a balanced party.",
        "ZM10: Awakening\n\nLocation: Celestial Nexus\nEnter the Celestial Nexus in Tu'Lia. Defeat Eald'narche to complete the Rise of the Zilart storyline and unlock new content!"
    },
};

--[[
* Event: Command
* Desc : Toggles the mission guide window with a chat command.
--]]
ashita.events.register('command', 'command_cb', function (e)
    local args = e.command:args();
    if (#args == 0 or not args[1]:any('/missionguide')) then
        return;
    end

    -- Block the command and toggle the window
    e.blocked = true;
    mission_guide.is_open[1] = not mission_guide.is_open[1];
end);

--[[
* Event: d3d_present
* Desc : Handles the rendering of the mission guide window.
--]]
ashita.events.register('d3d_present', 'present_cb', function ()
    -- Only display the window if it is set to open
    if (mission_guide.is_open[1]) then
        -- Set the initial size and position of the window (on first use)
        imgui.SetNextWindowSize({ 450, 300 }, ImGuiCond_FirstUseEver);

        -- Begin the mission guide window
        if (imgui.Begin('Mission Guide - Rise of the Zilart', mission_guide.is_open)) then
            -- Display the current mission step with word wrapping
            imgui.TextWrapped(mission_guide.steps[mission_guide.current_step] or "Mission complete!");

            -- Navigation buttons for mission steps
            imgui.Separator();
            if (imgui.Button('Previous Step') and mission_guide.current_step > 1) then
                mission_guide.current_step = mission_guide.current_step - 1;
            end
            imgui.SameLine();
            if (imgui.Button('Next Step') and mission_guide.current_step < #mission_guide.steps) then
                mission_guide.current_step = mission_guide.current_step + 1;
            end

            -- Optional close button inside the window
            if (imgui.Button('Close Guide')) then
                mission_guide.is_open[1] = false;
            end
        end

        -- End the mission guide window
        imgui.End();
    end
end);
