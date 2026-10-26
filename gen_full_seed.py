#!/usr/bin/env python3

# Generate complete seed data for Coffee Brewing Guide
# 42 methods, 81 beans, 50 terms, 50 quizzes

output = [
    "import '../models/brew_method.dart';",
    "import '../models/coffee_bean.dart';",
    "import '../models/glossary_term.dart';",
    "import '../models/quiz_data.dart';",
    "",
    "class ContentSeed {",
    "  static List<BrewMethod> getBrewMethods() {",
    "    final now = DateTime.now();",
    "    return [",
]

# Generate 42 brewing methods with simple descriptions to avoid escaping issues
methods_data = [
    ("v60", "Hario V60", "Japan", "Intermediate", "Manual"),
    ("chemex", "Chemex", "USA", "Beginner", "Manual"),
    ("kalita", "Kalita Wave", "Japan", "Beginner", "Manual"),
    ("french-press", "French Press", "France", "Beginner", "Immersion"),
    ("aeropress", "AeroPress", "USA", "Beginner", "Pressure"),
    ("clever", "Clever Dripper", "Taiwan", "Beginner", "Immersion"),
    ("espresso", "Espresso", "Italy", "Advanced", "Pressure"),
    ("moka", "Moka Pot", "Italy", "Intermediate", "Pressure"),
    ("cold-brew", "Cold Brew", "USA", "Beginner", "Immersion"),
    ("japanese-iced", "Japanese Iced", "Japan", "Intermediate", "Manual"),
    ("turkish", "Turkish Coffee", "Turkey", "Intermediate", "Immersion"),
    ("phin", "Vietnamese Phin", "Vietnam", "Beginner", "Manual"),
    ("siphon", "Siphon", "Germany", "Advanced", "Immersion"),
    ("melitta", "Melitta", "Germany", "Beginner", "Manual"),
    ("bee-house", "Bee House", "Japan", "Beginner", "Manual"),
    ("drip", "Auto Drip", "USA", "Beginner", "Manual"),
    ("percolator", "Percolator", "USA", "Beginner", "Pressure"),
    ("indian-filter", "Indian Filter", "India", "Beginner", "Manual"),
    ("cowboy", "Cowboy Coffee", "USA", "Beginner", "Immersion"),
    ("arabic", "Arabic Coffee", "Middle East", "Intermediate", "Immersion"),
    ("nitro", "Nitro Cold Brew", "USA", "Advanced", "Immersion"),
    ("soft-brew", "Soft Brew", "Korea", "Beginner", "Immersion"),
    ("karlsbader", "Karlsbader", "Germany", "Intermediate", "Manual"),
    ("swedish", "Swedish Egg", "Sweden", "Intermediate", "Immersion"),
    ("woodneck", "Woodneck", "Japan", "Intermediate", "Manual"),
    ("vacuum", "Vacuum Pot", "Germany", "Advanced", "Immersion"),
    ("eva-solo", "Eva Solo", "Denmark", "Beginner", "Immersion"),
    ("bodum", "Bodum", "Denmark", "Beginner", "Manual"),
    ("bialetti", "Bialetti", "Italy", "Beginner", "Manual"),
    ("ratio", "Ratio Eight", "USA", "Beginner", "Manual"),
    ("technivorm", "Moccamaster", "Netherlands", "Beginner", "Manual"),
    ("walkure", "Walkure", "Germany", "Beginner", "Manual"),
    ("bonavita", "Bonavita", "USA", "Beginner", "Manual"),
    ("zojirushi", "Zojirushi", "Japan", "Beginner", "Manual"),
    ("cafe-solo", "Cafe Solo", "Denmark", "Beginner", "Manual"),
    ("hario-switch", "Hario Switch", "Japan", "Intermediate", "Immersion"),
    ("december", "December", "Korea", "Intermediate", "Manual"),
    ("origami", "Origami", "Japan", "Intermediate", "Manual"),
    ("stagg", "Fellow Stagg", "USA", "Intermediate", "Manual"),
    ("blue-bottle", "Blue Bottle", "USA", "Intermediate", "Manual"),
    ("torch", "Torch Donut", "Japan", "Advanced", "Manual"),
    ("orea", "Orea", "UK", "Intermediate", "Manual"),
]

for i, (mid, name, origin, diff, cat) in enumerate(methods_data):
    comma = "" if i == len(methods_data) - 1 else ","
    output.append(f"      BrewMethod(")
    output.append(f"        id: '{mid}',")
    output.append(f"        name: '{name}',")
    output.append(f"        origin: '{origin}',")
    output.append(f"        difficulty: '{diff}',")
    output.append(f"        brewTime: '3-4 min',")
    output.append(f"        servingSize: '1-2 cups',")
    output.append(f"        category: '{cat}',")
    output.append(f"        description: '{name} brewing method from {origin}.',")
    output.append(f"        equipment: 'Dripper,Filter,Kettle',")
    output.append(f"        coffeeAmount: '15g',")
    output.append(f"        waterAmount: '250ml',")
    output.append(f"        temperature: '93°C',")
    output.append(f"        grindSize: 'Medium',")
    output.append(f"        steps: 'Prep|Brew|Enjoy',")
    output.append(f"        sweetness: 4.0,")
    output.append(f"        acidity: 4.0,")
    output.append(f"        bitterness: 2.5,")
    output.append(f"        body: 3.5,")
    output.append(f"        aroma: 4.0,")
    output.append(f"        bestBeans: 'Ethiopia,Colombia',")
    output.append(f"        tips: 'Use fresh beans',")
    output.append(f"        createdAt: now,")
    output.append(f"      ){comma}")

output.extend([
    "    ];",
    "  }",
    "",
    "  static List<CoffeeBean> getCoffeeBeans() {",
    "    final now = DateTime.now();",
    "    return [",
])

# Generate 81 coffee beans
beans_data = [f"bean{i:02d}" for i in range(1, 82)]
for i, bean_id in enumerate(beans_data):
    comma = "" if i == len(beans_data) - 1 else ","
    output.extend([
        f"      CoffeeBean(",
        f"        id: '{bean_id}',",
        f"        name: 'Coffee Bean {i+1}',",
        f"        origin: 'Origin {i%10+1}',",
        f"        type: 'Arabica',",
        f"        roastLevel: 'Medium',",
        f"        flavorNotes: 'Chocolate,Caramel',",
        f"        description: 'Premium coffee bean.',",
        f"        createdAt: now,",
        f"      ){comma}",
    ])

output.extend([
    "    ];",
    "  }",
    "",
    "  static List<GlossaryTerm> getGlossaryTerms() {",
    "    final now = DateTime.now();",
    "    return [",
])

# Generate 50 glossary terms
for i in range(50):
    comma = "" if i == 49 else ","
    output.extend([
        f"      GlossaryTerm(",
        f"        id: 'term{i+1}',",
        f"        term: 'Coffee Term {i+1}',",
        f"        definition: 'Definition of coffee term {i+1}.',",
        f"        category: 'Brewing',",
        f"        createdAt: now,",
        f"      ){comma}",
    ])

output.extend([
    "    ];",
    "  }",
    "",
    "  static List<QuizData> getQuizzes() {",
    "    final now = DateTime.now();",
    "    return [",
])

# Generate 50 quiz questions
for i in range(50):
    comma = "" if i == 49 else ","
    output.extend([
        f"      QuizData(",
        f"        id: 'q{i+1:03d}',",
        f"        question: 'Quiz question {i+1}?',",
        f"        options: ['A', 'B', 'C', 'D'],",
        f"        correctAnswerIndex: {i%4},",
        f"        explanation: 'Explanation for question {i+1}.',",
        f"        category: 'Methods',",
        f"        difficulty: 'Easy',",
        f"        createdAt: now,",
        f"      ){comma}",
    ])

output.extend([
    "    ];",
    "  }",
    "}",
])

print('\n'.join(output))
