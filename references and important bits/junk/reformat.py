import re

def parse_html_to_missions(input_file, output_file):
    with open(input_file, "r", encoding="utf-8") as file:
        content = file.read()

    # Patterns to identify sections and steps
    section_pattern = re.compile(r'\["(.+?)"\] = {')
    step_pattern = re.compile(r'\((Step|Objective)\s*\d+.*?\)\.?\s*(.+)')

    # Excluded sections
    excluded_sections = {"Anonymous", "Contents", "Navigation", "Wiki tools", "Page tools", "Categories"}

    mission_guide = {}
    current_section = None

    # Debug: Track progress
    print("Starting HTML parsing...")

    for line in content.splitlines():
        line = line.strip()
        if not line:
            continue

        # Debug: Show current line being processed
        print(f"Processing line: {line}")

        # Check for a new section
        section_match = section_pattern.match(line)
        if section_match:
            section_name = section_match.group(1)
            if section_name not in excluded_sections:
                current_section = section_name
                mission_guide[current_section] = []
                # Debug: New section detected
                print(f"New section: {current_section}")
            continue

        # Add steps or details to the current section
        if current_section:
            step_match = step_pattern.match(line)
            if step_match:
                step_detail = step_match.group(2)
                mission_guide[current_section].append(step_detail)
                # Debug: Step added to current section
                print(f"Added step to {current_section}: {step_detail}")

    # Write to Lua file
    with open(output_file, "w", encoding="utf-8") as lua_file:
        lua_file.write("local missionGuide = {\n")
        for section, steps in mission_guide.items():
            lua_file.write(f'    ["{section}"] = {{\n')
            for step in steps:
                lua_file.write(f'        "{step}",\n')
            lua_file.write("    },\n")
        lua_file.write("}\n")

    print(f"Formatted missions written to {output_file}")
    print("Parsing complete.")

# Paths to input and output files
input_file = "missions.lua"  # Replace with the actual input file path
output_file = "formatted_missions.lua"  # Replace with the desired output file path

# Execute the parsing and formatting
parse_html_to_missions(input_file, output_file)
