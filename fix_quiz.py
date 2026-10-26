#!/usr/bin/env python3

# Real quiz questions about coffee
real_questions = [
    ("Which brewing method uses paper filters and a cone-shaped dripper?", ["V60", "French Press", "Moka Pot", "Turkish Coffee"], 0, "Methods", "Easy"),
    ("What is the ideal water temperature for pour-over coffee?", ["80-85°C", "88-92°C", "92-96°C", "98-100°C"], 2, "Methods", "Medium"),
    ("Which method produces coffee with the fullest body?", ["V60", "Chemex", "French Press", "AeroPress"], 2, "Methods", "Easy"),
    ("How long should you steep coffee in a French Press?", ["1-2 minutes", "4 minutes", "7-8 minutes", "12 minutes"], 1, "Methods", "Easy"),
    ("What grind size is recommended for espresso?", ["Extra Coarse", "Coarse", "Medium", "Fine"], 3, "Methods", "Easy"),
    ("What is the purpose of blooming in pour-over brewing?", ["Cool the coffee", "Release CO2 from beans", "Add flavor", "Reduce acidity"], 1, "Methods", "Medium"),
    ("Which brewing method was invented in Taiwan?", ["V60", "Kalita Wave", "Clever Dripper", "Chemex"], 2, "Methods", "Hard"),
    ("What pressure does an espresso machine typically operate at?", ["3 bars", "6 bars", "9 bars", "12 bars"], 2, "Methods", "Medium"),
    ("Which method uses steam pressure on the stovetop?", ["French Press", "Moka Pot", "AeroPress", "Chemex"], 1, "Methods", "Easy"),
    ("How long should cold brew steep for optimal flavor?", ["2-4 hours", "6-8 hours", "12-24 hours", "48 hours"], 2, "Methods", "Easy"),
    ("Which coffee species accounts for 60-70% of global production?", ["Robusta", "Arabica", "Liberica", "Excelsa"], 1, "Beans", "Easy"),
    ("Which country is known as the birthplace of coffee?", ["Brazil", "Colombia", "Ethiopia", "Vietnam"], 2, "Beans", "Easy"),
    ("What does AA mean in Kenya AA coffee?", ["Arabica-Arabica", "Altitude Above average", "Bean screen size", "Acidity level"], 2, "Beans", "Medium"),
    ("Which processing method produces the fruitiest flavors?", ["Washed", "Natural", "Honey", "Wet-hulled"], 1, "Beans", "Medium"),
    ("What is a peaberry coffee bean?", ["A processing type", "A bean variety", "A single round bean from cherry", "Green unroasted bean"], 2, "Beans", "Hard"),
    ("Which type of grinder produces the most consistent grind?", ["Blade grinder", "Burr grinder", "Mortar and pestle", "Food processor"], 1, "Equipment", "Easy"),
    ("What is the purpose of a gooseneck kettle?", ["Faster boiling", "Precise pouring control", "Better heat retention", "Aesthetic appearance"], 1, "Equipment", "Easy"),
    ("What is the ideal brew ratio for pour-over methods?", ["1:10", "1:15-1:17", "1:20", "1:25"], 1, "Techniques", "Medium"),
    ("What does tamping refer to in espresso preparation?", ["Grinding beans", "Compressing grounds", "Heating water", "Frothing milk"], 1, "Techniques", "Easy"),
    ("What does body refer to in coffee tasting?", ["Caffeine content", "Weight and texture in mouth", "Color of brew", "Temperature"], 1, "Tasting", "Easy"),
    ("Which is NOT a primary taste in coffee?", ["Sweetness", "Acidity", "Umami", "Bitterness"], 2, "Tasting", "Medium"),
    ("What is crema on espresso?", ["Burnt coffee", "Golden foam from oils and CO2", "Milk foam", "Sugar coating"], 1, "Tasting", "Easy"),
    ("What causes channeling in espresso brewing?", ["Fresh beans", "Uneven tamping or distribution", "Hot water", "Good grinder"], 1, "Techniques", "Medium"),
    ("What is the best grind size for French Press?", ["Extra Fine", "Fine", "Medium", "Coarse"], 3, "Techniques", "Easy"),
    ("How long should espresso extraction take?", ["10-15 seconds", "25-30 seconds", "45-60 seconds", "2 minutes"], 1, "Methods", "Medium"),
    ("Which coffee type has the highest caffeine content?", ["Light Roast Arabica", "Dark Roast Arabica", "Light Roast Robusta", "Dark Roast Robusta"], 2, "Beans", "Medium"),
    ("What temperature should milk be steamed to for lattes?", ["55-60°C", "65-70°C", "75-80°C", "85-90°C"], 1, "Techniques", "Medium"),
    ("What is the purpose of resting coffee beans after roasting?", ["Cool them down", "Release CO2 gas", "Add flavor", "Change color"], 1, "Beans", "Medium"),
    ("Which roast level typically has the highest acidity?", ["Light", "Medium", "Medium-Dark", "Dark"], 0, "Beans", "Easy"),
    ("What is a ristretto shot?", ["Long espresso", "Short concentrated espresso", "Espresso with milk", "Iced espresso"], 1, "Methods", "Medium"),
    ("Which country produces the most coffee globally?", ["Colombia", "Vietnam", "Brazil", "Ethiopia"], 2, "Beans", "Easy"),
    ("What is the traditional cappuccino milk ratio?", ["1:1:1 espresso:milk:foam", "1:2:1", "1:3:1", "2:1:1"], 0, "Methods", "Medium"),
    ("What is the main difference between Arabica and Robusta?", ["Color", "Shape", "Caffeine content and flavor", "Price only"], 2, "Beans", "Easy"),
    ("Which brewing method produces the cleanest cup?", ["French Press", "Turkish Coffee", "Pour Over with paper filter", "Moka Pot"], 2, "Methods", "Easy"),
    ("What causes coffee to taste sour?", ["Over-extraction", "Under-extraction", "Old beans", "Too hot water"], 1, "Tasting", "Medium"),
    ("What causes coffee to taste bitter?", ["Under-extraction", "Over-extraction", "Fresh beans", "Cold water"], 1, "Tasting", "Medium"),
    ("How long should coffee beans rest after roasting?", ["Use immediately", "1-3 days", "7-14 days", "30 days"], 2, "Beans", "Medium"),
    ("What is WDT (Weiss Distribution Technique) used for?", ["Cooling espresso", "Breaking up clumps for even extraction", "Adding flavor", "Speeding up brewing"], 1, "Techniques", "Medium"),
    ("Which brewing method originated in Italy?", ["V60", "French Press", "Moka Pot and Espresso", "Kalita Wave"], 2, "Methods", "Easy"),
    ("What is microfoam in milk steaming?", ["Burnt milk", "Velvety steamed milk with tiny bubbles", "Cold milk", "Milk powder"], 1, "Techniques", "Medium"),
    ("Which processing method is typically fastest?", ["Natural", "Washed", "Honey", "All are same speed"], 1, "Processing", "Medium"),
    ("What is the purpose of pre-infusion in espresso?", ["Cool the beans", "Saturate grounds evenly before full pressure", "Add pressure", "Clean machine"], 1, "Techniques", "Hard"),
    ("Which grind size extracts fastest?", ["Extra Coarse", "Coarse", "Medium", "Fine"], 3, "Techniques", "Easy"),
    ("What is a lungo shot?", ["Short shot", "Long shot with more water", "Double shot", "Iced shot"], 1, "Methods", "Medium"),
    ("Which coffee region is known for fruity flavors?", ["Brazil", "Indonesia", "East Africa (Ethiopia, Kenya)", "India"], 2, "Beans", "Easy"),
    ("What does TDS stand for in coffee?", ["Total Drink Strength", "Total Dissolved Solids", "Temperature During Service", "Taste Determination Scale"], 1, "Tasting", "Hard"),
    ("What does SCA stand for?", ["Specialty Coffee Association", "Strong Coffee Arabica", "Sweet Coffee Aroma", "Standard Coffee Analysis"], 0, "Tasting", "Medium"),
    ("Which method is most portable for camping?", ["V60 setup", "Espresso machine", "AeroPress", "Siphon"], 2, "Methods", "Easy"),
    ("What is the typical water-to-coffee ratio for espresso?", ["1:1", "1:2", "1:15", "1:20"], 1, "Methods", "Medium"),
    ("Which storage method keeps coffee freshest longest?", ["Open air", "Refrigerator", "Freezer", "Airtight container at room temp"], 3, "Beans", "Easy"),
]

# Read current content_seed.dart
with open('lib/src/database/content_seed.dart', 'r') as f:
    lines = f.readlines()

# Find where quizzes start
quiz_start_idx = None
quiz_end_idx = None
for i, line in enumerate(lines):
    if 'static List<QuizData> getQuizzes()' in line:
        quiz_start_idx = i
    if quiz_start_idx is not None and '    ];' in line and 'return [' in ''.join(lines[quiz_start_idx:i]):
        quiz_end_idx = i
        break

if quiz_start_idx and quiz_end_idx:
    # Rebuild quiz section
    new_lines = lines[:quiz_start_idx]
    new_lines.append('  static List<QuizData> getQuizzes() {\n')
    new_lines.append('    final now = DateTime.now();\n')
    new_lines.append('    return [\n')
    
    for i, (question, options, correct, category, difficulty) in enumerate(real_questions):
        comma = '' if i == len(real_questions) - 1 else ','
        # Escape single quotes in question and options
        safe_question = question.replace("'", "\\'")
        safe_options = [opt.replace("'", "\\'") for opt in options]
        safe_explanation = f"The correct answer is {options[correct]}. {question}".replace("'", "\\'")
        
        new_lines.append(f"      QuizData(\n")
        new_lines.append(f"        id: 'q{i+1:03d}',\n")
        new_lines.append(f"        question: '{safe_question}',\n")
        new_lines.append(f"        options: ['{safe_options[0]}', '{safe_options[1]}', '{safe_options[2]}', '{safe_options[3]}'],\n")
        new_lines.append(f"        correctAnswerIndex: {correct},\n")
        new_lines.append(f"        explanation: '{safe_explanation}',\n")
        new_lines.append(f"        category: '{category}',\n")
        new_lines.append(f"        difficulty: '{difficulty}',\n")
        new_lines.append(f"        createdAt: now,\n")
        new_lines.append(f"      ){comma}\n")
    
    new_lines.append('    ];\n')
    new_lines.append('  }\n')
    new_lines.append('}\n')
    
    # Write back
    with open('lib/src/database/content_seed.dart', 'w') as f:
        f.writelines(new_lines)
    
    print("Fixed 50 real quiz questions!")
else:
    print("Could not find quiz section")
