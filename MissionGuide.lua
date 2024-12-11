addon.name      = 'missionguide'
addon.author    = 'YourName'
addon.version   = '2.0'
addon.desc      = 'Displays detailed mission guides with step-by-step instructions.'
addon.link      = 'https://ashitaxi.com/'

require('common')
local imgui = require('imgui')

-- Load the mission guide data from missions.lua
local missionGuide = require('missions')

-- Addon state variables
local state = {
    is_open = { true }, -- Toggle for the window
    current_section = nil, -- Currently selected section
    current_step = 1, -- Current step within the section
}

--[[ Command Event ]]
ashita.events.register('command', 'command_cb', function(e)
    local args = e.command:args()
    if (#args == 0 or not args[1]:any('/missionguide')) then
        return
    end

    -- Toggle the mission guide window
    e.blocked = true
    state.is_open[1] = not state.is_open[1]
end)

--[[ D3D Present Event ]]
ashita.events.register('d3d_present', 'present_cb', function()
    if not state.is_open[1] then
        return
    end

    imgui.SetNextWindowSize({ 500, 400 }, ImGuiCond_FirstUseEver)

    if imgui.Begin('Mission Guide', state.is_open) then
        imgui.Text('Select a Mission Category:')
        if imgui.BeginCombo('##section_select', state.current_section or 'Select...') then
            if missionGuide.ordered_sections then
                for _, section_name in ipairs(missionGuide.ordered_sections) do
                    if imgui.Selectable(section_name, section_name == state.current_section) then
                        state.current_section = section_name
                        state.current_step = 1
                    end
                end
            else
                imgui.Text('Error: No ordered sections defined.')
            end
            imgui.EndCombo()
        end

        if state.current_section then
            local section = missionGuide[state.current_section]
            if section and section.steps then
                imgui.Separator()
                imgui.TextWrapped(section.steps[state.current_step] or 'Mission complete!')
                imgui.Separator()

                if imgui.Button('Previous Step') and state.current_step > 1 then
                    state.current_step = state.current_step - 1
                end
                imgui.SameLine()
                if imgui.Button('Next Step') and state.current_step < #section.steps then
                    state.current_step = state.current_step + 1
                end
            else
                imgui.Text('No steps available for this mission.')
            end
        else
            imgui.Text('Please select a mission category to view steps.')
        end
    end

    imgui.End()
end)
