#!/usr/bin/env python3
"""Generate 50 real coffee glossary terms for content_seed.dart"""

glossary_terms = [
    # Brewing (10)
    ("Bloom", "The initial phase of pour-over brewing where hot water is poured over freshly ground coffee, causing it to release CO2 gas and expand. This creates better extraction.", "Brewing", "When brewing with V60, allow coffee to bloom for 30-45 seconds before continuing to pour."),
    ("Extraction", "The process of dissolving soluble compounds from coffee grounds into water. Under-extraction results in sour, weak coffee; over-extraction results in bitter coffee.", "Brewing", "Proper extraction yields balanced sweetness and acidity."),
    ("Pour-Over", "A manual brewing method where hot water is poured over coffee grounds in a filter, allowing gravity to pull the water through.", "Brewing", "V60, Chemex, and Kalita Wave are popular pour-over devices."),
    ("Immersion", "A brewing method where coffee grounds are fully submerged in water for a period of time before separation.", "Brewing", "French Press and cold brew use immersion brewing."),
    ("Drip Rate", "The speed at which water passes through coffee grounds during brewing. Slower drip rates generally increase extraction.", "Brewing", "Adjust grind size to control drip rate in pour-over."),
    ("Brew Ratio", "The proportion of coffee to water used in brewing, typically expressed as 1:15 or 1:16 for balanced coffee.", "Brewing", "Use 18g coffee to 270ml water for a 1:15 ratio."),
    ("Water Temperature", "The temperature of water used for brewing, typically between 90-96°C (195-205°F) for optimal extraction.", "Brewing", "Lower temperatures for light roasts, higher for dark roasts."),
    ("Contact Time", "The duration that water and coffee grounds are in contact during brewing. Longer contact times require coarser grinds.", "Brewing", "French Press uses 4 minutes contact time."),
    ("Agitation", "Stirring or disturbing coffee grounds during brewing to promote even extraction.", "Brewing", "Gently stir during bloom phase in pour-over brewing."),
    ("Channeling", "When water finds paths of least resistance through coffee grounds, causing uneven extraction. Often caused by poor tamping or distribution.", "Brewing", "Use WDT tool to prevent channeling in espresso."),

    # Beans (10)
    ("Arabica", "The most common coffee species (Coffea arabica), known for complex flavors, sweetness, and higher acidity. Grown at higher altitudes.", "Beans", "Colombian and Ethiopian coffees are typically Arabica."),
    ("Robusta", "Coffee species (Coffea canephora) with higher caffeine content, stronger/bitter taste, and easier cultivation than Arabica.", "Beans", "Vietnamese coffee often uses Robusta beans."),
    ("Single Origin", "Coffee from one geographic location (country, region, or farm), showcasing unique terroir characteristics.", "Beans", "Ethiopian Yirgacheffe is a prized single origin coffee."),
    ("Blend", "Coffee made from beans of different origins, combined to achieve consistent flavor profile or complexity.", "Beans", "Espresso blends often mix beans from multiple regions."),
    ("Varietal", "A distinct genetic variety of coffee plant within a species, each with unique characteristics.", "Beans", "Geisha, Bourbon, and Typica are popular varietals."),
    ("Terroir", "The environmental factors (soil, climate, altitude) that influence coffee flavor from a specific region.", "Beans", "High altitude and volcanic soil create complex flavors."),
    ("Crop Year", "The harvest year of coffee beans. Freshness significantly affects flavor, with coffee best used within 3-12 months of roasting.", "Beans", "Check roast date to ensure fresh beans."),
    ("Green Coffee", "Unroasted coffee beans. They are stable for months or years before roasting transforms them.", "Beans", "Green coffee must be roasted before brewing."),
    ("Peaberry", "A coffee bean mutation where only one round bean develops in the cherry instead of two flat-sided beans. Considered special by some.", "Beans", "Tanzanian Peaberry is highly sought after."),
    ("Screen Size", "The size classification of coffee beans based on grading screens, measured in 64ths of an inch.", "Beans", "Screen size 18 means beans are 18/64 inch diameter."),

    # Equipment (8)
    ("Burr Grinder", "A coffee grinder using two revolving abrasive surfaces (burrs) to produce uniform particle size. Superior to blade grinders.", "Equipment", "Invest in burr grinder for consistent extraction."),
    ("Portafilter", "The handled device on espresso machines that holds the ground coffee basket and locks into the group head.", "Equipment", "Preheat portafilter before pulling espresso shots."),
    ("Tamper", "A tool used to compress ground coffee evenly in the portafilter basket before brewing espresso.", "Equipment", "Apply 30 lbs of pressure when tamping."),
    ("Gooseneck Kettle", "A kettle with a long, narrow spout for precise water pouring control, essential for pour-over brewing.", "Equipment", "Gooseneck kettle allows circular pouring patterns."),
    ("Scale", "A digital scale for accurately measuring coffee and water to maintain consistent brew ratios.", "Equipment", "Use 0.1g precision scale for best results."),
    ("Grind Size", "The coarseness or fineness of ground coffee particles, which dramatically affects extraction rate and brew time.", "Equipment", "Espresso requires fine grind; French Press needs coarse."),
    ("Group Head", "The component on an espresso machine where the portafilter locks in and hot water is dispensed.", "Equipment", "Flush group head before each shot to stabilize temperature."),
    ("Steam Wand", "The tube on espresso machines that releases pressurized steam for heating and texturing milk.", "Equipment", "Purge steam wand before and after steaming milk."),

    # Tasting (8)
    ("Acidity", "A desirable bright, tangy quality in coffee, often described as citrus-like or wine-like. Not the same as sour.", "Tasting", "African coffees often have vibrant acidity."),
    ("Body", "The weight, thickness, or mouthfeel of coffee on the palate. Ranges from light and tea-like to heavy and syrupy.", "Tasting", "Sumatra coffee has heavy body; Kenya has lighter body."),
    ("Aroma", "The smell of brewed coffee, encompassing fragrances from floral to nutty to chocolatey notes.", "Tasting", "Aroma is a key component of coffee flavor perception."),
    ("Flavor Notes", "The specific taste characteristics identified in coffee, such as chocolate, berry, caramel, or floral notes.", "Tasting", "Ethiopian coffee may have blueberry and jasmine notes."),
    ("Mouthfeel", "The physical sensations of coffee in the mouth, including body, texture, and astringency.", "Tasting", "Oily mouthfeel indicates dark roast or full body coffee."),
    ("Sweetness", "Natural sugars and sweet perception in coffee, balanced against acidity and bitterness.", "Tasting", "Proper extraction brings out coffee's natural sweetness."),
    ("Aftertaste", "The lingering flavor sensations after swallowing coffee, also called finish. Can be short or long, pleasant or unpleasant.", "Tasting", "Quality coffee has clean, pleasant aftertaste."),
    ("Cupping", "Professional coffee tasting method using standardized procedures to evaluate coffee quality and characteristics.", "Tasting", "Cupping involves slurping coffee from spoons to aerate it."),

    # Processing (7)
    ("Washed Process", "Coffee processing method where fruit is removed before drying, resulting in clean, bright, acidic flavors.", "Processing", "Most specialty coffee uses washed processing."),
    ("Natural Process", "Coffee beans dried inside the fruit/cherry, creating fruity, wine-like, complex flavors with heavy body.", "Processing", "Ethiopian natural coffees have intense berry flavors."),
    ("Honey Process", "Processing method where some fruit mucilage remains on beans during drying, between washed and natural.", "Processing", "Costa Rican honey process creates sweet, balanced coffee."),
    ("Pulping", "The step in washed processing where outer fruit skin is mechanically removed from coffee cherries.", "Processing", "Pulping occurs within 24 hours of harvesting."),
    ("Fermentation", "The breakdown of remaining fruit sugars after pulping, which can significantly affect final flavor.", "Processing", "Controlled fermentation enhances coffee complexity."),
    ("Drying", "The process of reducing moisture content in coffee beans to 10-12% for stable storage and proper roasting.", "Processing", "Sun-drying on patios is traditional in many regions."),
    ("Parchment", "The protective layer around coffee beans after pulping, removed before roasting in a process called hulling.", "Processing", "Coffee stored in parchment maintains quality longer."),

    # Techniques (7)
    ("Tamping", "The act of compressing ground coffee in the portafilter basket to create even resistance for espresso extraction.", "Techniques", "Tamp level and firm, with 30 pounds of pressure."),
    ("WDT", "Weiss Distribution Technique - using a needle tool to break up clumps and evenly distribute grounds in the portafilter.", "Techniques", "WDT prevents channeling and improves extraction."),
    ("Pre-infusion", "Briefly wetting coffee grounds at low pressure before full pressure extraction, promoting even saturation.", "Techniques", "Pre-infusion helps prevent channeling in espresso."),
    ("Steaming Milk", "The process of heating and aerating milk using steam wand pressure to create microfoam for lattes and cappuccinos.", "Techniques", "Steam milk to 65-70°C for optimal sweetness."),
    ("Latte Art", "Patterns created in espresso drinks by pouring steamed milk, requiring proper microfoam texture and technique.", "Techniques", "Hearts and rosettas are basic latte art patterns."),
    ("Dialing In", "The iterative process of adjusting grind size, dose, and time to achieve optimal espresso extraction.", "Techniques", "Dial in new beans by tasting and adjusting variables."),
    ("Stirring", "Gently mixing coffee slurry during brewing to promote even extraction and temperature distribution.", "Techniques", "Stir gently during bloom in pour-over brewing.")
]

def escape_string(s):
    """Escape special characters for Dart string"""
    return s.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n")

print("  static List<GlossaryTerm> getGlossaryTerms() {")
print("    final now = DateTime.now();")
print("    return [")

for i, (term, definition, category, example) in enumerate(glossary_terms, 1):
    term_id = term.lower().replace(" ", "-").replace("(", "").replace(")", "")

    print(f"      GlossaryTerm(")
    print(f"        id: '{term_id}',")
    print(f"        term: '{escape_string(term)}',")
    print(f"        definition: '{escape_string(definition)}',")
    print(f"        category: '{category}',")
    print(f"        example: '{escape_string(example)}',")
    print(f"        createdAt: now,")
    print(f"      ),")

print("    ];")
print("  }")

print(f"\n// Generated {len(glossary_terms)} glossary terms")
print(f"// Categories: Brewing={sum(1 for t in glossary_terms if t[2]=='Brewing')}, ", end="")
print(f"Beans={sum(1 for t in glossary_terms if t[2]=='Beans')}, ", end="")
print(f"Equipment={sum(1 for t in glossary_terms if t[2]=='Equipment')}, ", end="")
print(f"Tasting={sum(1 for t in glossary_terms if t[2]=='Tasting')}, ", end="")
print(f"Processing={sum(1 for t in glossary_terms if t[2]=='Processing')}, ", end="")
print(f"Techniques={sum(1 for t in glossary_terms if t[2]=='Techniques')}")
