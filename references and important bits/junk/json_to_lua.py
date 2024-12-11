import json

def json_to_lua(json_file, lua_file):
    with open(json_file, "r", encoding="utf-8") as jf:
        mission_guide = json.load(jf)

    # Filter out unwanted sections
    unwanted_sections = ["Anonymous", "Contents", "Navigation", "Wiki tools", "Page tools", "Categories"]
    mission_guide = {k: v for k, v in mission_guide.items() if k not in unwanted_sections}

    with open(lua_file, "w", encoding="utf-8") as lua:
        lua.write("local missionGuide = {\n")
        for section, missions in mission_guide.items():
            lua.write(f"    ['{section}'] = {{\n")
            for mission, steps in missions.items():
                lua.write(f"        ['{mission}'] = {{\n")
                lua.write(f"            steps = {{\n")
                for step in steps:
                    lua.write(f"                '{step}',\n")
                lua.write("            },\n")
                lua.write("        },\n")
            lua.write("    },\n")
        lua.write("}\n")

# Paths to input JSON and output Lua
json_file = "parsed_missions.json"
lua_file = "formatted_missions.lua"

# Convert JSON to Lua
json_to_lua(json_file, lua_file)
