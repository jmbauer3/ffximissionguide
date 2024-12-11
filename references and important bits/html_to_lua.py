from bs4 import BeautifulSoup
import re

def parse_missions_with_structure(html_file, output_file):
    with open(html_file, "r", encoding="utf-8") as file:
        soup = BeautifulSoup(file, "html.parser")

    mission_guide = {}

    # Parse the HTML content and extract sections and steps
    for header in soup.find_all(['h1', 'h2', 'h3']):
        section_title = header.get_text(strip=True)

        # Skip irrelevant sections
        if section_title in ["Anonymous", "Navigation", "Wiki tools", "Page tools", "Categories"]:
            continue

        # Prepare section content
        steps = []

        # Extract content under each header
        for sibling in header.find_next_siblings():
            if sibling.name in ['h1', 'h2', 'h3']:
                break
            if sibling.name in ['p', 'ul', 'li']:
                text = sibling.get_text(strip=True)
                if not text or re.match(r'^_{5,}$', text):
                    continue  # Skip separators or empty lines

                # Escape single quotes and ensure newlines are removed
                text = text.replace("'", "\\'").replace('"', '\\"').replace("\n", " ")

                # Clean and format steps
                if re.match(r'^\(Step \d+\..*\)$', text):
                    text = re.sub(r'^\((Step \d+\.)\s*', r'\1 ', text)

                steps.append(text)

        # Add the section and steps to the mission guide
        if steps:
            mission_guide[section_title] = {
                "steps": steps
            }

    # Write the Lua-formatted output
    with open(output_file, "w", encoding="utf-8") as lua_file:
        lua_file.write("local missionGuide = {\n")
        for section, content in mission_guide.items():
            # Escape section titles for Lua
            section_title = section.replace("'", "\\'")
            lua_file.write(f"    ['{section_title}'] = {{\n")
            lua_file.write("        steps = {\n")
            for step in content['steps']:
                # Ensure step content is properly escaped and formatted
                lua_file.write(f"            '{step}',\n")
            lua_file.write("        },\n")
            lua_file.write("    },\n")
        lua_file.write("}\n")

# Input and output file paths
html_file = "User_Millsih_Simple Mission Guide - FFXI Wiki.htm"
output_file = "missions.lua"

# Run the parser
parse_missions_with_structure(html_file, output_file)

print(f"Mission guide parsed and saved to {output_file}.")
