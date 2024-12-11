from bs4 import BeautifulSoup
import json

def parse_html_to_json(html_file, json_file):
    with open(html_file, 'r', encoding='utf-8') as file:
        soup = BeautifulSoup(file, 'html.parser')

    mission_guide = {}
    current_section = None
    current_mission = None

    for tag in soup.find_all(['h2', 'b', 'p', 'ul']):
        if tag.name == 'h2':  # Main section
            current_section = tag.get_text(strip=True)
            mission_guide[current_section] = {}
            current_mission = None
        elif tag.name == 'b':  # Mission title
            if current_section:
                current_mission = tag.get_text(strip=True)
                mission_guide[current_section][current_mission] = []
        elif tag.name == 'p' and current_mission:  # Mission steps
            text = tag.get_text(strip=True)
            if text and text != "__________________________________________________________________________________":
                mission_guide[current_section][current_mission].append(text)
        elif tag.name == 'ul' and current_mission:  # Notes under a mission
            for li in tag.find_all('li'):
                note = li.get_text(strip=True)
                if note:
                    mission_guide[current_section][current_mission].append(note)

    # Save the result to a JSON file for review
    with open(json_file, 'w', encoding='utf-8') as jf:
        json.dump(mission_guide, jf, ensure_ascii=False, indent=4)

# Paths to input and output files
html_file = "User_Millsih_Simple Mission Guide - FFXI Wiki.htm"
json_file = "parsed_missions.json"

# Run the function
parse_html_to_json(html_file, json_file)
