# Mission Guide for Ashita

### **Description**
Mission Guide is an addon for the Ashita client designed to provide step-by-step guidance for completing missions in *Final Fantasy XI*. This user-friendly tool allows players to select mission categories, navigate through mission steps, and quickly find relevant information in-game.

This addon is based on the **Simple Mission Guide** created by [Millsih](https://www.bg-wiki.com/ffxi/User:Millsih/Simple_Mission_Guide). Special thanks to Millsih for their comprehensive and detailed work!

---

### **Features**
- **Category Dropdown:** Easily select a mission category.
- **Step-by-Step Navigation:** View mission objectives one at a time with "Previous" and "Next" buttons.
- **Comprehensive Coverage:** Includes major mission series like Rhapsodies of Vana'diel, Rise of the Zilart, and Chains of Promathia.
- **Lightweight and Intuitive:** Simple design integrates seamlessly with the Ashita interface.

---

### **Installation**
1. **Download the Files**:
   - Download the `missionguide.lua` addon script.
   - Download the `missions.lua` file containing the mission data.

2. **Place the Files**:
   - Copy `missionguide.lua` to your Ashita addons directory:
     ```
     /Ashita/addons/missionguide/
     ```
   - Place `missions.lua` in the same directory:
     ```
     /Ashita/addons/missionguide/
     ```

3. **Activate the Addon**:
   - Open Ashita and log in to your character.
   - Run the following command in the chat window:
     ```
     /addon load missionguide
     ```

4. **Start Using**:
   - Toggle the Mission Guide window by entering:
     ```
     /missionguide
     ```

---

### **Usage**
- **Open the Addon**: Use the `/missionguide` command.
- **Select a Category**: Use the dropdown menu to select a mission series or category.
- **Navigate Steps**:
  - **Previous Step:** Go back to the last step.
  - **Next Step:** Proceed to the next step.
- **Close the Window**: Click the "Close Guide" button or toggle it off with `/missionguide`.

---

### **Known Issues**
- **Uneven Step Splits**: Some steps may contain a single word, while others are lengthy paragraphs. Refining the step structure is a future enhancement.
- **Random Edge Cases**: Depending on the mission guide structure, some mission steps may need manual adjustment.

---

### **Contributing**
Want to improve the guide or add more missions? Feel free to:
1. Edit `missions.lua` to update the mission data.
2. Submit your improvements via [GitHub](https://github.com/jmbauer3).

---

### **Credits**
- **Author of Addon**: John M. Bauer ([GitHub](https://github.com/jmbauer3))
- **Original Guide Author**: [Millsih](https://www.bg-wiki.com/ffxi/User:Millsih/Simple_Mission_Guide)
- **Support**: Thanks to the Ashita community for their help and feedback.

---

### **License**
This project is licensed under the **MIT License**, which allows for open use, modification, and distribution.
