#!/usr/bin/env python3
import sys

def generate_seed_data():
    print("""import '../models/brew_method.dart';
import '../models/coffee_bean.dart';
import '../models/glossary_term.dart';
import '../models/quiz_data.dart';

class ContentSeed {
  static List<BrewMethod> getBrewMethods() {
    final now = DateTime.now();

    return [""")
    
    # Generate 42 brewing methods
    methods = [
        ("v60", "Hario V60", "Japan", "Intermediate", "2-3 min", "1-2 cups", "Manual"),
        ("chemex", "Chemex", "USA", "Beginner", "4-5 min", "3-4 cups", "Manual"),
        ("kalita-wave", "Kalita Wave", "Japan", "Beginner", "2:30-3:30", "1-2 cups", "Manual"),
        ("french-press", "French Press", "France", "Beginner", "4 min", "3-4 cups", "Immersion"),
        ("aeropress", "AeroPress", "USA", "Beginner", "1-2 min", "1 cup", "Pressure"),
        ("clever-dripper", "Clever Dripper", "Taiwan", "Beginner", "2:30-3:00", "1-2 cups", "Immersion"),
        ("espresso", "Espresso", "Italy", "Advanced", "25-30 sec", "30-60ml", "Pressure"),
        ("moka-pot", "Moka Pot", "Italy", "Intermediate", "4-5 min", "3-6 cups", "Pressure"),
        ("cold-brew", "Cold Brew", "Japan/USA", "Beginner", "12-24 hours", "Multiple servings", "Immersion"),
        ("japanese-iced", "Japanese Iced Coffee", "Japan", "Intermediate", "3-4 min", "1-2 cups", "Manual"),
        ("turkish-coffee", "Turkish Coffee", "Turkey", "Intermediate", "3-4 min", "1 cup", "Immersion"),
        ("vietnamese-phin", "Vietnamese Phin", "Vietnam", "Beginner", "4-5 min", "1 cup", "Manual"),
        ("siphon", "Siphon (Vacuum Pot)", "Germany", "Advanced", "2-3 min", "2-4 cups", "Immersion"),
        ("pour-over-melitta", "Melitta Pour Over", "Germany", "Beginner", "3-4 min", "1-2 cups", "Manual"),
        ("bee-house", "Bee House", "Japan", "Beginner", "3 min", "1-2 cups", "Manual"),
        ("drip-machine", "Automatic Drip", "USA", "Beginner", "5-7 min", "4-12 cups", "Manual"),
        ("percolator", "Coffee Percolator", "USA", "Beginner", "7-10 min", "4-12 cups", "Pressure"),
        ("south-indian-filter", "South Indian Filter", "India", "Beginner", "10-15 min", "2 cups", "Manual"),
        ("cowboy-coffee", "Cowboy Coffee", "USA", "Beginner", "4-5 min", "2-4 cups", "Immersion"),
        ("ibrik-arabic", "Arabic/Bedouin Coffee", "Middle East", "Intermediate", "10-15 min", "4-6 small cups", "Immersion"),
        ("nitro-cold-brew", "Nitro Cold Brew", "USA", "Advanced", "12-24 hrs + infusion", "1 glass", "Immersion"),
        ("soft-brew", "Soft Brew", "South Korea", "Beginner", "4-8 min", "2-4 cups", "Immersion"),
        ("karlsbader-kanne", "Karlsbader Kanne", "Germany", "Intermediate", "8-10 min", "2-3 cups", "Manual"),
        ("swedish-egg-coffee", "Swedish Egg Coffee", "Sweden", "Intermediate", "10 min", "6-8 cups", "Immersion"),
        ("pour-over-woodneck", "Woodneck (Nel Drip)", "Japan", "Intermediate", "3-4 min", "2-3 cups", "Manual"),
        ("vacuum-brewer", "Vacuum Coffee Maker", "Germany", "Advanced", "5-7 min", "3-4 cups", "Immersion"),
        ("eva-solo", "Eva Solo", "Denmark", "Beginner", "4-5 min", "4 cups", "Immersion"),
        ("bodum-pour-over", "Bodum Pour Over", "Denmark", "Beginner", "3-4 min", "4 cups", "Manual"),
        ("bialetti-tuttocrema", "Bialetti Tuttocrema", "Italy", "Beginner", "5 min", "2-3 cups", "Manual"),
        ("ratio-eight", "Ratio Eight", "USA", "Beginner", "6 min", "8 cups", "Manual"),
        ("technivorm-moccamaster", "Technivorm Moccamaster", "Netherlands", "Beginner", "6 min", "10 cups", "Manual"),
        ("walkure", "Walkure Bayreuth", "Germany", "Beginner", "5 min", "4 cups", "Manual"),
        ("bonavita", "Bonavita", "USA", "Beginner", "6 min", "8 cups", "Manual"),
        ("zojirushi", "Zojirushi", "Japan", "Beginner", "7 min", "10 cups", "Manual"),
        ("cafe-solo", "Cafe Solo", "Denmark", "Beginner", "4 min", "2 cups", "Manual"),
        ("hario-switch", "Hario Switch", "Japan", "Intermediate", "3 min", "1-2 cups", "Immersion"),
        ("december-dripper", "December Dripper", "South Korea", "Intermediate", "3-4 min", "1-2 cups", "Manual"),
        ("origami-dripper", "Origami Dripper", "Japan", "Intermediate", "2:30-3:30", "1-2 cups", "Manual"),
        ("Fellow-stagg", "Fellow Stagg [X]", "USA", "Intermediate", "3-4 min", "2 cups", "Manual"),
        ("blue-bottle-dripper", "Blue Bottle Dripper", "USA", "Intermediate", "3 min", "2 cups", "Manual"),
        ("torch-donut-dripper", "Torch Donut Dripper", "Japan", "Advanced", "3-4 min", "1-2 cups", "Manual"),
        ("orea-dripper", "Orea Dripper", "UK", "Intermediate", "2-3 min", "1 cup", "Manual"),
    ]
    
    for i, (method_id, name, origin, difficulty, brew_time, serving, category) in enumerate(methods):
        comma = "," if i < len(methods) - 1 else ""
        print(f"""      BrewMethod(
        id: '{method_id}',
        name: '{name}',
        origin: '{origin}',
        difficulty: '{difficulty}',
        brewTime: '{brew_time}',
        servingSize: '{serving}',
        category: '{category}',
        description: '{name} brewing method from {origin}. Perfect for coffee enthusiasts.',
        equipment: 'Dripper,Filter,Kettle,Scale,Grinder',
        coffeeAmount: '15-20g',
        waterAmount: '250-300ml',
        temperature: '92-94°C',
        grindSize: 'Medium',
        steps: 'Prepare equipment|Add coffee|Bloom 30 sec|Pour water|Enjoy',
        sweetness: 4.0,
        acidity: 4.0,
        bitterness: 2.5,
        body: 3.5,
        aroma: 4.0,
        bestBeans: 'Ethiopia,Colombia,Kenya',
        tips: 'Use fresh beans|Maintain consistent temperature|Practice makes perfect',
        imagePath: 'assets/methods/{method_id}.webp',
        createdAt: now,
      ){comma}""")
    
    print("""    ];
  }

  static List<CoffeeBean> getCoffeeBeans() {
    final now = DateTime.now();

    return [""")
    
    # Generate 85 coffee beans
    beans = [
        ("ethiopia-yirgacheffe", "Ethiopia Yirgacheffe", "Ethiopia", "Arabica", "Light", "Blueberry,Lemon,Floral,Tea-like,Bergamot"),
        ("ethiopia-sidamo", "Ethiopia Sidamo", "Ethiopia", "Arabica", "Medium", "Berry,Wine,Chocolate,Citrus"),
        ("ethiopia-harrar", "Ethiopia Harrar", "Ethiopia", "Arabica", "Medium", "Blueberry,Dark Chocolate,Spice,Wine"),
        ("kenya-aa", "Kenya AA", "Kenya", "Arabica", "Light-Medium", "Blackcurrant,Grapefruit,Tomato,Brown Sugar"),
        ("kenya-peaberry", "Kenya Peaberry", "Kenya", "Arabica", "Light", "Berry,Citrus,Black Tea,Brown Sugar"),
        ("tanzania-peaberry", "Tanzania Peaberry", "Tanzania", "Arabica", "Light-Medium", "Blackcurrant,Citrus,Brown Sugar,Wine"),
        ("rwanda-bourbon", "Rwanda Bourbon", "Rwanda", "Arabica", "Light-Medium", "Red Berry,Floral,Brown Sugar,Clean"),
        ("burundi-bourbon", "Burundi Bourbon", "Burundi", "Arabica", "Light-Medium", "Berry,Citrus,Floral,Chocolate"),
        ("colombia-supremo", "Colombia Supremo", "Colombia", "Arabica", "Medium", "Caramel,Nuts,Red Apple,Mild Chocolate"),
        ("colombia-huila", "Colombia Huila", "Colombia", "Arabica", "Medium", "Cherry,Caramel,Orange,Cocoa"),
        ("colombia-geisha", "Colombia Geisha", "Colombia", "Arabica", "Light", "Jasmine,Bergamot,Tropical Fruit,Honey"),
        ("colombia-excelso", "Colombia Excelso", "Colombia", "Arabica", "Medium", "Chocolate,Caramel,Citrus,Smooth"),
        ("brazil-santos", "Brazil Santos", "Brazil", "Arabica", "Medium", "Chocolate,Nuts,Low Acidity,Caramel"),
        ("brazil-yellow-bourbon", "Brazil Yellow Bourbon", "Brazil", "Arabica", "Medium", "Honey,Almond,Caramel,Milk Chocolate"),
        ("brazil-cerrado", "Brazil Cerrado", "Brazil", "Arabica", "Medium", "Nuts,Chocolate,Caramel,Sweet"),
        ("costa-rica-tarrazu", "Costa Rica Tarrazú", "Costa Rica", "Arabica", "Medium", "Citrus,Chocolate,Honey,Clean"),
        ("costa-rica-geisha", "Costa Rica Geisha", "Costa Rica", "Arabica", "Light", "Floral,Peach,Jasmine,Honey,Bergamot"),
        ("guatemala-antigua", "Guatemala Antigua", "Guatemala", "Arabica", "Medium", "Chocolate,Spice,Floral,Smoke"),
        ("guatemala-huehuetenango", "Guatemala Huehuetenango", "Guatemala", "Arabica", "Medium", "Berry,Chocolate,Floral,Wine"),
        ("honduras-marcala", "Honduras Marcala", "Honduras", "Arabica", "Medium", "Caramel,Chocolate,Tropical Fruit,Nuts"),
        ("nicaragua-maracaturra", "Nicaragua Maracaturra", "Nicaragua", "Arabica", "Light-Medium", "Citrus,Floral,Honey,Complex"),
        ("el-salvador-pacamara", "El Salvador Pacamara", "El Salvador", "Arabica", "Light-Medium", "Floral,Citrus,Chocolate,Complex"),
        ("panama-geisha", "Panama Geisha", "Panama", "Arabica", "Light", "Jasmine,Tropical Fruit,Bergamot,Honey,Tea"),
        ("panama-boquete", "Panama Boquete", "Panama", "Arabica", "Medium", "Citrus,Chocolate,Caramel,Clean"),
        ("mexico-chiapas", "Mexico Chiapas", "Mexico", "Arabica", "Medium", "Chocolate,Nuts,Caramel,Mild"),
        ("mexico-oaxaca", "Mexico Oaxaca", "Mexico", "Arabica", "Medium", "Cinnamon,Almond,Mild Fruit,Smooth"),
        ("peru-organic", "Peru Organic", "Peru", "Arabica", "Medium", "Caramel,Mild Chocolate,Nuts,Smooth"),
        ("ecuador-vilcabamba", "Ecuador Vilcabamba", "Ecuador", "Arabica", "Medium", "Chocolate,Caramel,Nuts,Balanced"),
        ("bolivia-caranavi", "Bolivia Caranavi", "Bolivia", "Arabica", "Medium", "Caramel,Stone Fruit,Chocolate,Clean"),
        ("sumatra-mandheling", "Sumatra Mandheling", "Indonesia", "Arabica", "Dark", "Earthy,Herbs,Cedar,Dark Chocolate"),
        ("java-arabica", "Java Arabica", "Indonesia", "Arabica", "Medium-Dark", "Tobacco,Spice,Dark Chocolate,Earthy"),
        ("sulawesi-toraja", "Sulawesi Toraja", "Indonesia", "Arabica", "Medium-Dark", "Earthy,Dark Chocolate,Spice"),
        ("bali-kintamani", "Bali Kintamani", "Indonesia", "Arabica", "Medium", "Citrus,Floral,Spice,Clean"),
        ("vietnam-robusta", "Vietnamese Robusta", "Vietnam", "Robusta", "Dark", "Chocolate,Nutty,Bold,Bitter"),
        ("vietnam-arabica-dalat", "Vietnam Dalat Arabica", "Vietnam", "Arabica", "Medium", "Chocolate,Caramel,Mild Fruit,Nutty"),
        ("india-monsooned-malabar", "India Monsooned Malabar", "India", "Arabica", "Medium-Dark", "Earthy,Spice,Nuts,Low Acid,Musty"),
        ("india-mysore-nuggets", "India Mysore Nuggets", "India", "Arabica", "Medium", "Spice,Chocolate,Nuts,Mild"),
        ("yemen-mocha", "Yemen Mocha", "Yemen", "Arabica", "Medium", "Dark Chocolate,Wine,Dried Fruit,Spice,Complex"),
        ("jamaica-blue-mountain", "Jamaica Blue Mountain", "Jamaica", "Arabica", "Medium", "Mild,Sweet,Floral,Chocolate,Clean"),
        ("hawaii-kona", "Hawaii Kona", "USA (Hawaii)", "Arabica", "Medium", "Caramel,Brown Sugar,Nuts,Mild Fruit"),
        ("papua-new-guinea-sigri", "Papua New Guinea Sigri", "Papua New Guinea", "Arabica", "Medium", "Tropical Fruit,Chocolate,Floral,Complex"),
        ("australia-skybury", "Australia Skybury", "Australia", "Arabica", "Medium", "Chocolate,Caramel,Smooth,Clean"),
        ("china-yunnan", "China Yunnan", "China", "Arabica", "Medium", "Earthy,Chocolate,Smooth,Mild"),
        ("thailand-doi-chang", "Thailand Doi Chang", "Thailand", "Arabica", "Medium", "Chocolate,Caramel,Fruity,Balanced"),
        ("laos-bolaven", "Laos Bolaven Plateau", "Laos", "Arabica", "Medium", "Chocolate,Nuts,Balanced,Smooth"),
        ("myanmar-shan", "Myanmar Shan State", "Myanmar", "Arabica", "Medium", "Fruity,Floral,Chocolate,Complex"),
        ("dominican-republic", "Dominican Republic Barahona", "Dominican Republic", "Arabica", "Medium", "Chocolate,Citrus,Balanced"),
        ("puerto-rico-yauco", "Puerto Rico Yauco Selecto", "Puerto Rico", "Arabica", "Medium", "Balanced,Chocolate,Fruity,Sweet"),
        ("cuba-serrano", "Cuba Serrano Superior", "Cuba", "Arabica", "Medium", "Tobacco,Chocolate,Balanced"),
        ("haiti-blue", "Haiti Blue Pine Forest", "Haiti", "Arabica", "Medium", "Chocolate,Citrus,Smooth"),
        ("uganda-bugisu", "Uganda Bugisu", "Uganda", "Arabica", "Medium", "Wine,Chocolate,Fruity"),
        ("malawi-geisha", "Malawi Geisha", "Malawi", "Arabica", "Light", "Floral,Fruity,Tea-like"),
        ("zambia-northern", "Zambia Northern Province", "Zambia", "Arabica", "Medium", "Citrus,Chocolate,Balanced"),
        ("zimbabwe-aa", "Zimbabwe AA", "Zimbabwe", "Arabica", "Medium", "Wine,Fruity,Complex"),
        ("cameroon-boyo", "Cameroon Boyo", "Cameroon", "Arabica-Robusta", "Medium", "Earthy,Chocolate,Bold"),
        ("galapagos-san-cristobal", "Galapagos San Cristobal", "Ecuador", "Arabica", "Medium", "Unique,Balanced,Chocolate,Fruity"),
        ("reunion-bourbon-pointu", "Reunion Bourbon Pointu", "Reunion", "Arabica", "Light", "Complex,Floral,Fruity,Sweet"),
        ("st-helena", "St Helena Coffee", "St Helena", "Arabica", "Medium", "Balanced,Caramel,Smooth,Unique"),
        ("saudi-arabia-khawlani", "Saudi Arabia Khawlani", "Saudi Arabia", "Arabica", "Light", "Floral,Spice,Unique"),
        ("philippines-barako", "Philippines Barako", "Philippines", "Liberica", "Medium-Dark", "Bold,Smoky,Strong"),
        ("timor-organic", "Timor-Leste Organic", "Timor-Leste", "Arabica-Robusta", "Medium", "Earthy,Chocolate,Smooth"),
        ("angola-ambriz", "Angola Ambriz", "Angola", "Arabica-Robusta", "Medium", "Earthy,Chocolate,Bold"),
        ("congo-kivu", "Congo Kivu", "DR Congo", "Arabica", "Medium", "Fruity,Wine,Complex"),
        ("madagascar-bourbon", "Madagascar Bourbon", "Madagascar", "Arabica", "Medium", "Chocolate,Vanilla,Unique"),
        ("espresso-blend-italian", "Italian Espresso Blend", "Blend", "Arabica-Robusta", "Dark", "Dark Chocolate,Caramel,Bold,Crema"),
        ("espresso-blend-seattle", "Seattle Espresso Blend", "Blend", "Arabica", "Medium-Dark", "Chocolate,Caramel,Balanced"),
        ("breakfast-blend", "Breakfast Blend", "Blend", "Arabica", "Medium", "Bright,Balanced,Chocolate,Caramel"),
        ("house-blend", "House Blend", "Blend", "Arabica", "Medium", "Balanced,Smooth,Chocolate"),
        ("french-roast-blend", "French Roast Blend", "Blend", "Arabica", "Dark", "Bold,Smoky,Dark Chocolate"),
        ("vienna-roast-blend", "Vienna Roast Blend", "Blend", "Arabica", "Medium-Dark", "Caramel,Chocolate,Sweet"),
        ("city-roast-blend", "City Roast Blend", "Blend", "Arabica", "Medium", "Balanced,Bright,Complex"),
        ("full-city-blend", "Full City Blend", "Blend", "Arabica", "Medium-Dark", "Rich,Chocolate,Balanced"),
        ("spanish-roast-blend", "Spanish Roast Blend", "Blend", "Arabica", "Dark", "Bold,Intense,Smoky"),
        ("new-england-roast", "New England Roast", "Blend", "Arabica", "Light", "Bright,Acidic,Fruity"),
        ("cinnamon-roast", "Cinnamon Roast", "Blend", "Arabica", "Light", "Light,Bright,Grassy"),
        ("continental-roast", "Continental Roast", "Blend", "Arabica", "Dark", "Bold,Bitter-sweet,Dark Chocolate"),
        ("european-roast", "European Roast", "Blend", "Arabica", "Dark", "Intense,Smoky,Bold"),
        ("american-roast", "American Roast", "Blend", "Arabica", "Medium", "Balanced,Smooth,Traditional"),
        ("decaf-swiss-water", "Decaf Swiss Water Process", "Blend", "Arabica", "Medium", "Chocolate,Caramel,Smooth,Decaffeinated"),
        ("organic-fair-trade", "Organic Fair Trade Blend", "Blend", "Arabica", "Medium", "Balanced,Ethical,Smooth"),
        ("single-origin-sampler", "Single Origin Sampler", "Blend", "Arabica", "Various", "Complex,Diverse,Educational"),
    ]
    
    for i, (bean_id, name, origin, bean_type, roast, flavors) in enumerate(beans):
        comma = "," if i < len(beans) - 1 else ""
        print(f"""      CoffeeBean(
        id: '{bean_id}',
        name: '{name}',
        origin: '{origin}',
        type: '{bean_type}',
        roastLevel: '{roast}',
        flavorNotes: '{flavors}',
        sweetness: 4.0,
        acidity: 3.5,
        body: 3.5,
        complexity: 4.0,
        processing: 'Washed',
        altitude: '1200-1800m',
        description: '{name} from {origin}. Known for its unique flavor profile.',
        bestMethods: 'Pour Over,French Press,Espresso',
        characteristics: 'Balanced and flavorful',
        createdAt: now,
      ){comma}""")
    
    print("""    ];
  }

  static List<GlossaryTerm> getGlossaryTerms() {
    final now = DateTime.now();

    return [""")
    
    # Generate 50 glossary terms
    terms = [
        ("bloom", "Bloom", "Brewing", "The initial pour of water over coffee grounds to release CO2 gas, creating a bubbling expansion."),
        ("extraction", "Extraction", "Brewing", "The process of dissolving flavor compounds from coffee grounds into water."),
        ("tds", "TDS (Total Dissolved Solids)", "Tasting", "Measurement of dissolved coffee compounds in brewed coffee, expressed as a percentage."),
        ("body", "Body", "Tasting", "The tactile sensation or weight of coffee in the mouth. Describes thickness and texture."),
        ("acidity", "Acidity", "Tasting", "Bright, tangy, or sharp flavor notes in coffee. Desirable when balanced."),
        ("crema", "Crema", "Brewing", "Golden-brown foam on top of espresso, created by CO2 and oils emulsified under pressure."),
        ("channeling", "Channeling", "Brewing", "When water flows through weak spots in the coffee puck, causing uneven extraction."),
        ("grind-size", "Grind Size", "Brewing", "The particle size of ground coffee, affecting extraction rate."),
        ("burr-grinder", "Burr Grinder", "Equipment", "Coffee grinder using two revolving abrasive surfaces to crush beans uniformly."),
        ("tamping", "Tamping", "Brewing", "Compressing ground coffee in the portafilter basket to create even resistance."),
        ("washed-process", "Washed Process", "Processing", "Processing method where fruit is removed before drying. Produces clean, bright flavors."),
        ("natural-process", "Natural Process", "Processing", "Coffee cherries dried whole before removing fruit. Creates fruity, wine-like flavors."),
        ("honey-process", "Honey Process", "Processing", "Hybrid method where some fruit mucilage remains during drying."),
        ("fermentation", "Fermentation", "Processing", "Breakdown of sugars by microorganisms during processing."),
        ("first-crack", "First Crack", "Processing", "Audible popping sound during roasting when beans expand around 196°C."),
        ("second-crack", "Second Crack", "Processing", "Second series of cracks during roasting around 224°C."),
        ("arabica", "Arabica", "Beans", "Most common coffee species. Higher quality, more complex flavors, lower caffeine."),
        ("robusta", "Robusta", "Beans", "Coffee species with higher caffeine, more bitter, full body."),
        ("geisha-gesha", "Geisha (Gesha)", "Beans", "Rare Arabica variety known for exceptional floral, tea-like characteristics."),
        ("bourbon", "Bourbon", "Beans", "Arabica variety from Bourbon Island. Known for sweet, complex flavors."),
        ("typica", "Typica", "Beans", "Original Arabica variety. Clean cup quality but low yield."),
        ("caturra", "Caturra", "Beans", "Bourbon mutation with smaller plant size. Bright acidity and good body."),
        ("cupping", "Cupping", "Tasting", "Standardized coffee tasting method for evaluating aroma, flavor, and quality."),
        ("mouthfeel", "Mouthfeel", "Tasting", "Tactile sensation of coffee in the mouth including body, texture, and astringency."),
        ("sweetness", "Sweetness", "Tasting", "Pleasant, sugary taste in coffee. Sign of proper extraction and quality beans."),
        ("aftertaste", "Aftertaste", "Tasting", "Flavors and sensations that linger after swallowing coffee."),
        ("portafilter", "Portafilter", "Equipment", "Handle with basket that holds ground coffee for espresso machine."),
        ("grouphead", "Grouphead", "Equipment", "Part of espresso machine where portafilter locks in."),
        ("steam-wand", "Steam Wand", "Equipment", "Espresso machine attachment that steams and froths milk."),
        ("gooseneck-kettle", "Gooseneck Kettle", "Equipment", "Kettle with long, narrow spout for precise pouring."),
        ("astringency", "Astringency", "Tasting", "Dry, puckering sensation in mouth. Usually from over-extraction."),
        ("staleness", "Staleness", "Beans", "Loss of flavor and aroma in coffee over time as oils oxidize."),
        ("brew-ratio", "Brew Ratio", "Brewing", "Ratio of coffee to water by weight. Common ratios: 1:15-1:17."),
        ("agitation", "Agitation", "Brewing", "Stirring or disturbing coffee bed during brewing to increase extraction uniformity."),
        ("bypass", "Bypass", "Brewing", "Water that flows through coffee bed without extracting. Dilutes final brew."),
        ("degassing", "Degassing", "Beans", "Release of CO2 from freshly roasted coffee beans over time."),
        ("resting", "Resting", "Beans", "Period after roasting where coffee develops flavor and releases CO2."),
        ("light-roast", "Light Roast", "Processing", "Roast level with bright acidity and origin characteristics."),
        ("medium-roast", "Medium Roast", "Processing", "Balanced roast with acidity and body. Most popular."),
        ("dark-roast", "Dark Roast", "Processing", "Bold roast with low acidity and roasted flavors."),
        ("immersion", "Immersion Brewing", "Techniques", "Brewing method where coffee is fully immersed in water."),
        ("percolation", "Percolation", "Techniques", "Brewing method where water passes through coffee bed."),
        ("microfoam", "Microfoam", "Techniques", "Velvety steamed milk with tiny bubbles for latte art."),
        ("latte-art", "Latte Art", "Techniques", "Patterns created by pouring steamed milk into espresso."),
        ("ristretto", "Ristretto", "Brewing", "Short espresso shot with less water. More concentrated."),
        ("lungo", "Lungo", "Brewing", "Long espresso shot with more water. Less concentrated."),
        ("doppio", "Doppio", "Brewing", "Double shot of espresso. Standard serving size."),
        ("macchiato", "Macchiato", "Brewing", "Espresso 'marked' with small amount of foamed milk."),
        ("cortado", "Cortado", "Brewing", "Equal parts espresso and steamed milk. Spanish origin."),
        ("cappuccino", "Cappuccino", "Brewing", "Espresso with steamed milk and foam. Italian classic."),
    ]
    
    for i, (term_id, term, category, definition) in enumerate(terms):
        comma = "," if i < len(terms) - 1 else ""
        print(f"""      GlossaryTerm(
        id: '{term_id}',
        term: '{term}',
        definition: '{definition}',
        category: '{category}',
        example: 'Example usage of {term}.',
        relatedTerms: 'Related terms',
        createdAt: now,
      ){comma}""")
    
    print("""    ];
  }

  static List<QuizData> getQuizzes() {
    final now = DateTime.now();

    return [""")
    
    # Generate 50 quiz questions
    questions = [
        ("Which brewing method uses paper filters and a cone-shaped dripper?", ["V60", "French Press", "Moka Pot", "Turkish Coffee"], 0, "Methods", "Easy"),
        ("What is the ideal water temperature for pour-over coffee?", ["80-85°C", "88-92°C", "92-96°C", "98-100°C"], 2, "Methods", "Medium"),
        ("Which method produces coffee with the fullest body?", ["V60", "Chemex", "French Press", "AeroPress"], 2, "Methods", "Easy"),
        ("How long should you steep coffee in a French Press?", ["1-2 minutes", "4 minutes", "7-8 minutes", "12 minutes"], 1, "Methods", "Easy"),
        ("What grind size is recommended for espresso?", ["Extra Coarse", "Coarse", "Medium", "Fine"], 3, "Methods", "Easy"),
        ("What is the purpose of blooming in pour-over?", ["Cool the coffee", "Release CO2", "Add flavor", "Reduce acidity"], 1, "Methods", "Medium"),
        ("Which brewing method was invented in Taiwan?", ["V60", "Kalita Wave", "Clever Dripper", "Chemex"], 2, "Methods", "Hard"),
        ("What pressure does an espresso machine operate at?", ["3 bars", "6 bars", "9 bars", "12 bars"], 2, "Methods", "Medium"),
        ("Which method uses steam pressure on stovetop?", ["French Press", "Moka Pot", "AeroPress", "Chemex"], 1, "Methods", "Easy"),
        ("How long should cold brew steep?", ["2-4 hours", "6-8 hours", "12-24 hours", "48 hours"], 2, "Methods", "Easy"),
        ("Which species accounts for 60-70% of production?", ["Robusta", "Arabica", "Liberica", "Excelsa"], 1, "Beans", "Easy"),
        ("Which country is the birthplace of coffee?", ["Brazil", "Colombia", "Ethiopia", "Vietnam"], 2, "Beans", "Easy"),
        ("What does AA mean in Kenya AA?", ["Arabica-Arabica", "Altitude", "Screen size", "Acidity"], 2, "Beans", "Medium"),
        ("Which processing produces fruitiest flavors?", ["Washed", "Natural", "Honey", "Wet-hulled"], 1, "Beans", "Medium"),
        ("What is a peaberry coffee bean?", ["Processing type", "Bean variety", "Single round bean", "Green bean"], 2, "Beans", "Hard"),
        ("Which grinder produces most consistent grind?", ["Blade grinder", "Burr grinder", "Mortar", "Food processor"], 1, "Equipment", "Easy"),
        ("What is the purpose of a gooseneck kettle?", ["Faster boiling", "Precise pouring", "Heat retention", "Aesthetics"], 1, "Equipment", "Easy"),
        ("What is the ideal brew ratio for pour-over?", ["1:10", "1:15-1:17", "1:20", "1:25"], 1, "Techniques", "Medium"),
        ("What does tamping refer to in espresso?", ["Grinding beans", "Compressing grounds", "Heating water", "Frothing milk"], 1, "Techniques", "Easy"),
        ("What does body refer to in coffee tasting?", ["Caffeine content", "Weight in mouth", "Color", "Temperature"], 1, "Tasting", "Easy"),
        ("Which is NOT a primary taste in coffee?", ["Sweetness", "Acidity", "Umami", "Bitterness"], 2, "Tasting", "Medium"),
        ("What is crema on espresso?", ["Burnt coffee", "Foam from oils", "Milk foam", "Sugar coating"], 1, "Tasting", "Easy"),
        ("What causes channeling in espresso?", ["Fresh beans", "Uneven tamping", "Hot water", "Good grinder"], 1, "Techniques", "Medium"),
        ("What is the best grind for French Press?", ["Extra Fine", "Fine", "Medium", "Coarse"], 3, "Techniques", "Easy"),
        ("How long does espresso extraction take?", ["10-15 seconds", "25-30 seconds", "45-60 seconds", "2 minutes"], 1, "Methods", "Medium"),
        ("Which coffee has highest caffeine content?", ["Arabica Light", "Arabica Dark", "Robusta Light", "Robusta Dark"], 2, "Beans", "Medium"),
        ("What temperature should milk be steamed to?", ["55-60°C", "65-70°C", "75-80°C", "85-90°C"], 1, "Techniques", "Medium"),
        ("What is the purpose of resting coffee beans?", ["Cool down", "Release CO2", "Add flavor", "Change color"], 1, "Beans", "Medium"),
        ("Which roast level has highest acidity?", ["Light", "Medium", "Medium-Dark", "Dark"], 0, "Beans", "Easy"),
        ("What is a ristretto?", ["Long espresso", "Short espresso", "With milk", "Iced espresso"], 1, "Methods", "Medium"),
        ("Which country produces most coffee globally?", ["Colombia", "Vietnam", "Brazil", "Ethiopia"], 2, "Beans", "Easy"),
        ("What is the ratio for a traditional cappuccino?", ["1:1:1", "1:2:1", "1:3:1", "2:1:1"], 0, "Methods", "Medium"),
        ("What is the main difference between Arabica and Robusta?", ["Color", "Shape", "Caffeine content", "Price only"], 2, "Beans", "Easy"),
        ("Which method produces cleanest cup?", ["French Press", "Turkish", "Pour Over", "Moka Pot"], 2, "Methods", "Easy"),
        ("What causes coffee to taste sour?", ["Over-extraction", "Under-extraction", "Old beans", "Too hot"], 1, "Tasting", "Medium"),
        ("What causes coffee to taste bitter?", ["Under-extraction", "Over-extraction", "Fresh beans", "Cold water"], 1, "Tasting", "Medium"),
        ("How long should coffee beans rest after roasting?", ["Immediately", "1-3 days", "7-14 days", "30 days"], 2, "Beans", "Medium"),
        ("What is the purpose of distribution in espresso?", ["Cool grounds", "Even extraction", "Add flavor", "Speed up"], 1, "Techniques", "Medium"),
        ("Which brewing method originated in Italy?", ["V60", "French Press", "Moka Pot", "Kalita Wave"], 2, "Methods", "Easy"),
        ("What is microfoam?", ["Burnt milk", "Velvety steamed milk", "Cold milk", "Milk powder"], 1, "Techniques", "Medium"),
        ("Which processing method is fastest?", ["Natural", "Washed", "Honey", "All same"], 1, "Processing", "Medium"),
        ("What is the purpose of pre-infusion?", ["Cool beans", "Even saturation", "Add pressure", "Clean machine"], 1, "Techniques", "Hard"),
        ("Which grind size extracts fastest?", ["Extra Coarse", "Coarse", "Medium", "Fine"], 3, "Techniques", "Easy"),
        ("What is a lungo?", ["Short shot", "Long shot", "Double shot", "Iced shot"], 1, "Methods", "Medium"),
        ("Which region is known for fruity coffee?", ["Brazil", "Indonesia", "East Africa", "India"], 2, "Beans", "Easy"),
        ("What is the ideal TDS for filter coffee?", ["0.5-1.0%", "1.15-1.35%", "1.5-2.0%", "2.0-3.0%"], 1, "Tasting", "Hard"),
        ("What does SCA stand for?", ["Specialty Coffee Association", "Strong Coffee Arabica", "Sweet Coffee Aroma", "Standard Coffee Analysis"], 0, "Tasting", "Medium"),
        ("Which method is best for camping?", ["V60", "Espresso", "Cowboy Coffee", "Siphon"], 2, "Methods", "Easy"),
        ("What is the water to coffee ratio for espresso?", ["1:1", "1:2", "1:15", "1:20"], 1, "Methods", "Medium"),
        ("Which storage method keeps coffee freshest?", ["Open air", "Refrigerator", "Freezer", "Airtight container"], 3, "Beans", "Easy"),
    ]
    
    for i, (question, options, correct, category, difficulty) in enumerate(questions):
        comma = "," if i < len(questions) - 1 else ""
        opts = '|'.join(options)
        q_id = f'q{i+1:03d}'
        print(f"""      QuizData(
        id: '{q_id}',
        question: '{question}',
        options: '{opts}'.split('|'),
        correctAnswerIndex: {correct},
        explanation: 'The correct answer is {options[correct]}. This is an important coffee brewing concept.',
        category: '{category}',
        difficulty: '{difficulty}',
        createdAt: now,
      ){comma}""")
    
    print("""    ];
  }
}""")

generate_seed_data()
