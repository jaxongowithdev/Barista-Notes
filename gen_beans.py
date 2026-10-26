#!/usr/bin/env python3
"""Generate 81 real coffee beans for content_seed.dart"""

coffee_beans = [
    # Ethiopia (10) - Birthplace of coffee
    ("Ethiopian Yirgacheffe", "Ethiopia", "Arabica", "Light", "Floral, Citrus, Bergamot, Honey", "Famous light roast with floral and citrus notes", "1700-2200m", "Washed", 4.5, 3.0, 4.0),
    ("Ethiopian Sidamo", "Ethiopia", "Arabica", "Light", "Blueberry, Wine, Dark Chocolate", "Wine-like acidity with berry notes", "1500-2200m", "Natural", 4.5, 3.5, 4.0),
    ("Ethiopian Harrar", "Ethiopia", "Arabica", "Medium", "Blueberry, Winey, Earthy", "Bold, winey, blueberry notes", "1500-2100m", "Natural", 4.0, 4.0, 3.5),
    ("Ethiopian Limu", "Ethiopia", "Arabica", "Light", "Fruity, Spice, Wine-like", "Balanced acidity with spice notes", "1100-1900m", "Washed", 4.0, 3.5, 4.0),
    ("Ethiopian Genika", "Ethiopia", "Arabica", "Light", "Jasmine, Peach, Bergamot", "Delicate floral with stone fruit", "1800-2100m", "Washed", 4.5, 3.0, 4.5),
    ("Ethiopian Guji", "Ethiopia", "Arabica", "Light", "Strawberry, Peach, Chocolate", "Sweet and fruity with chocolate finish", "1800-2300m", "Natural", 4.0, 3.5, 4.5),
    ("Ethiopian Kochere", "Ethiopia", "Arabica", "Light", "Lemon, Tea, Floral", "Tea-like body with citrus brightness", "1800-2100m", "Washed", 5.0, 2.5, 4.0),
    ("Ethiopian Gesha Village", "Ethiopia", "Arabica", "Light", "Jasmine, Mango, Peach", "Complex floral and tropical notes", "1900-2100m", "Washed", 4.5, 3.0, 5.0),
    ("Ethiopian Nekemte", "Ethiopia", "Arabica", "Medium", "Wine, Berry, Cocoa", "Full-bodied with wine-like complexity", "1500-2000m", "Natural", 4.0, 4.0, 3.5),
    ("Ethiopian Bebeka", "Ethiopia", "Arabica", "Medium", "Chocolate, Nuts, Spice", "Balanced with chocolate and spice", "1000-1500m", "Washed", 3.5, 4.0, 3.5),

    # Kenya (8) - Known for bright acidity
    ("Kenyan AA", "Kenya", "Arabica", "Light", "Blackcurrant, Grapefruit, Wine", "Bright acidity with blackcurrant notes", "1400-2000m", "Washed", 5.0, 4.0, 4.0),
    ("Kenyan Peaberry", "Kenya", "Arabica", "Light", "Berry, Citrus, Black Tea", "Concentrated flavor, bright and clean", "1500-2100m", "Washed", 5.0, 3.5, 4.0),
    ("Kenyan Nyeri", "Kenya", "Arabica", "Light", "Tomato, Blackcurrant, Citrus", "Complex with tomato and berry notes", "1200-2300m", "Washed", 5.0, 4.0, 4.0),
    ("Kenyan Kiambu", "Kenya", "Arabica", "Light", "Grapefruit, Brown Sugar, Floral", "Sweet citrus with floral hints", "1500-2200m", "Washed", 4.5, 3.5, 4.5),
    ("Kenyan Kirinyaga", "Kenya", "Arabica", "Light", "Blackberry, Caramel, Citrus", "Rich berry with caramel sweetness", "1300-1900m", "Washed", 4.5, 4.0, 4.5),
    ("Kenyan Embu", "Kenya", "Arabica", "Light", "Red Currant, Lemon, Honey", "Bright acidity with honey sweetness", "1200-1800m", "Washed", 5.0, 3.5, 4.0),
    ("Kenyan Murang'a", "Kenya", "Arabica", "Medium", "Blackcurrant, Chocolate, Wine", "Full body with wine-like complexity", "1400-2000m", "Washed", 4.5, 4.5, 4.0),
    ("Kenyan Machakos", "Kenya", "Arabica", "Light", "Citrus, Floral, Stone Fruit", "Clean and bright with fruit notes", "1200-1700m", "Washed", 4.5, 3.5, 4.0),

    # Colombia (10) - Balanced and sweet
    ("Colombian Supremo", "Colombia", "Arabica", "Medium", "Caramel, Nuts, Chocolate", "Well-balanced with caramel sweetness", "1200-1800m", "Washed", 4.0, 4.0, 4.0),
    ("Colombian Huila", "Colombia", "Arabica", "Medium", "Peach, Caramel, Citrus", "Sweet and fruity with citrus acidity", "1200-2100m", "Washed", 4.0, 3.5, 4.5),
    ("Colombian Nariño", "Colombia", "Arabica", "Light", "Orange, Honey, Floral", "Bright citrus with floral notes", "1500-2300m", "Washed", 4.5, 3.5, 4.5),
    ("Colombian Antioquia", "Colombia", "Arabica", "Medium", "Chocolate, Red Apple, Nuts", "Smooth with chocolate and fruit", "1300-2000m", "Washed", 4.0, 4.0, 4.0),
    ("Colombian Tolima", "Colombia", "Arabica", "Medium", "Apple, Caramel, Cocoa", "Balanced sweetness and acidity", "1200-1900m", "Washed", 4.0, 4.0, 4.5),
    ("Colombian Cauca", "Colombia", "Arabica", "Light", "Tropical Fruit, Honey, Floral", "Complex with tropical fruit notes", "1400-2100m", "Washed", 4.5, 3.5, 4.5),
    ("Colombian Magdalena", "Colombia", "Arabica", "Medium", "Chocolate, Caramel, Citrus", "Rich chocolate with citrus brightness", "900-1700m", "Washed", 3.5, 4.0, 4.0),
    ("Colombian Santander", "Colombia", "Arabica", "Medium", "Nuts, Chocolate, Molasses", "Full body with sweet molasses", "1200-2000m", "Washed", 3.5, 4.5, 4.0),
    ("Colombian Pink Bourbon", "Colombia", "Arabica", "Light", "Strawberry, Grape, Floral", "Unique varietal with berry notes", "1500-2100m", "Washed", 4.5, 3.5, 5.0),
    ("Colombian Caturra", "Colombia", "Arabica", "Medium", "Caramel, Orange, Chocolate", "Classic Colombian profile", "1300-1900m", "Washed", 4.0, 4.0, 4.0),

    # Brazil (8) - Nutty and chocolatey
    ("Brazilian Santos", "Brazil", "Arabica", "Medium", "Chocolate, Nuts, Caramel", "Low acidity, nutty and sweet", "800-1300m", "Natural", 2.5, 4.5, 4.0),
    ("Brazilian Cerrado", "Brazil", "Arabica", "Medium", "Nuts, Chocolate, Toffee", "Smooth body with nutty flavor", "800-1200m", "Natural", 2.5, 4.5, 4.0),
    ("Brazilian Bourbon Santos", "Brazil", "Arabica", "Medium", "Caramel, Cocoa, Almond", "Classic Brazilian sweetness", "1000-1300m", "Natural", 3.0, 4.0, 4.5),
    ("Brazilian Minas Gerais", "Brazil", "Arabica", "Medium", "Chocolate, Hazelnut, Sugar", "Heavy body with chocolate notes", "900-1400m", "Natural", 2.5, 5.0, 4.0),
    ("Brazilian Sul de Minas", "Brazil", "Arabica", "Medium-Dark", "Dark Chocolate, Nuts, Spice", "Rich and full-bodied", "800-1300m", "Natural", 2.0, 5.0, 3.5),
    ("Brazilian Mogiana", "Brazil", "Arabica", "Medium", "Caramel, Chocolate, Citrus", "Sweet with mild acidity", "900-1400m", "Pulped Natural", 3.0, 4.5, 4.5),
    ("Brazilian Bahia", "Brazil", "Arabica", "Medium", "Chocolate, Nuts, Brown Sugar", "Smooth and sweet", "700-1100m", "Natural", 2.5, 4.0, 4.0),
    ("Brazilian Yellow Bourbon", "Brazil", "Arabica", "Medium", "Honey, Caramel, Citrus", "Unique sweetness and complexity", "1000-1400m", "Natural", 3.5, 4.0, 5.0),

    # Central America (15)
    ("Guatemalan Antigua", "Guatemala", "Arabica", "Medium", "Cocoa, Spice, Floral", "Rich chocolate with spice notes", "1200-1800m", "Washed", 4.0, 4.5, 4.0),
    ("Guatemalan Huehuetenango", "Guatemala", "Arabica", "Medium", "Apple, Caramel, Chocolate", "Balanced fruit and chocolate", "1500-2000m", "Washed", 4.0, 4.0, 4.5),
    ("Costa Rican Tarrazú", "Costa Rica", "Arabica", "Medium", "Citrus, Honey, Chocolate", "Clean and bright with honey sweetness", "1200-1700m", "Washed", 4.5, 3.5, 4.5),
    ("Costa Rican Tres Rios", "Costa Rica", "Arabica", "Light", "Lemon, Caramel, Cocoa", "Bright acidity with balanced body", "1200-1650m", "Washed", 4.5, 3.5, 4.0),
    ("Panamanian Geisha", "Panama", "Arabica", "Light", "Jasmine, Peach, Bergamot, Mango", "World-famous with floral complexity", "1400-1900m", "Washed", 5.0, 2.5, 5.0),
    ("Panamanian Boquete", "Panama", "Arabica", "Medium", "Orange, Honey, Chocolate", "Sweet and balanced", "1000-1800m", "Washed", 4.0, 3.5, 4.5),
    ("Honduran Marcala", "Honduras", "Arabica", "Medium", "Caramel, Citrus, Nuts", "Sweet with nutty finish", "1000-1500m", "Washed", 4.0, 4.0, 4.0),
    ("Honduran Copán", "Honduras", "Arabica", "Medium", "Chocolate, Nuts, Caramel", "Smooth and sweet", "1000-1500m", "Washed", 3.5, 4.0, 4.0),
    ("Nicaraguan Jinotega", "Nicaragua", "Arabica", "Medium", "Chocolate, Caramel, Orange", "Balanced with chocolate notes", "900-1700m", "Washed", 4.0, 4.0, 4.0),
    ("Nicaraguan Matagalpa", "Nicaragua", "Arabica", "Medium", "Nuts, Chocolate, Citrus", "Full body with nutty flavor", "1000-1400m", "Washed", 3.5, 4.5, 4.0),
    ("El Salvador Pacamara", "El Salvador", "Arabica", "Medium", "Floral, Citrus, Chocolate", "Large bean with complex flavor", "900-1700m", "Washed", 4.0, 4.0, 4.5),
    ("Peruvian Chanchamayo", "Peru", "Arabica", "Medium", "Chocolate, Nuts, Caramel", "Smooth and sweet", "1000-1800m", "Washed", 3.5, 4.0, 4.0),
    ("Peruvian Cusco", "Peru", "Arabica", "Light", "Citrus, Floral, Honey", "Bright with floral notes", "1200-2000m", "Washed", 4.5, 3.0, 4.0),
    ("Mexican Chiapas", "Mexico", "Arabica", "Medium", "Chocolate, Nuts, Caramel", "Light body with chocolate notes", "900-1700m", "Washed", 3.5, 3.5, 4.0),
    ("Mexican Oaxaca", "Mexico", "Arabica", "Light", "Citrus, Almond, Caramel", "Delicate with nutty sweetness", "900-1650m", "Washed", 4.0, 3.0, 4.0),

    # Asia Pacific (15)
    ("Vietnamese Robusta", "Vietnam", "Robusta", "Dark", "Chocolate, Nuts, Earthy", "Strong and bold with high caffeine", "500-1000m", "Natural", 2.0, 5.0, 2.5),
    ("Vietnamese Arabica Da Lat", "Vietnam", "Arabica", "Medium", "Chocolate, Caramel, Nuts", "Smooth with chocolate notes", "1200-1600m", "Washed", 3.5, 4.0, 4.0),
    ("Indonesian Sumatra Mandheling", "Indonesia", "Arabica", "Dark", "Earthy, Herbal, Cedar, Tobacco", "Heavy body with earthy notes", "1000-1500m", "Wet-Hulled", 2.5, 5.0, 3.0),
    ("Indonesian Java", "Indonesia", "Arabica", "Medium-Dark", "Spice, Tobacco, Earthy", "Full body with spicy notes", "900-1800m", "Wet-Hulled", 2.5, 4.5, 3.5),
    ("Indonesian Sulawesi Toraja", "Indonesia", "Arabica", "Medium-Dark", "Chocolate, Earthy, Herbal", "Rich and earthy", "1200-1800m", "Wet-Hulled", 3.0, 4.5, 3.5),
    ("Indonesian Bali Kintamani", "Indonesia", "Arabica", "Medium", "Citrus, Floral, Spice", "Bright with floral notes", "900-1500m", "Washed", 4.0, 3.5, 4.0),
    ("Papua New Guinea", "Papua New Guinea", "Arabica", "Medium", "Fruity, Floral, Chocolate", "Complex with fruit and chocolate", "1200-1800m", "Washed", 4.0, 4.0, 4.0),
    ("Indian Monsooned Malabar", "India", "Arabica", "Medium-Dark", "Spice, Nuts, Earthy, Low Acid", "Unique monsoon processing", "1000-1500m", "Monsooned", 1.5, 5.0, 3.0),
    ("Indian Mysore Nuggets", "India", "Arabica", "Medium", "Spice, Nuts, Chocolate", "Balanced with spice notes", "1000-1600m", "Washed", 3.0, 4.0, 3.5),
    ("Indian Malabar", "India", "Arabica", "Medium", "Chocolate, Spice, Nuts", "Full body with chocolate", "900-1400m", "Washed", 3.0, 4.5, 3.5),
    ("Yemeni Mocha", "Yemen", "Arabica", "Medium", "Wine, Chocolate, Spice, Berries", "Ancient variety with wine-like notes", "1000-2400m", "Natural", 4.0, 4.0, 4.0),
    ("Hawaiian Kona", "Hawaii, USA", "Arabica", "Medium", "Caramel, Nuts, Brown Sugar, Citrus", "Smooth and balanced premium coffee", "150-900m", "Washed", 3.5, 3.5, 4.5),
    ("Hawaiian Maui Mokka", "Hawaii, USA", "Arabica", "Light", "Chocolate, Caramel, Floral", "Small bean with intense flavor", "300-900m", "Washed", 4.0, 3.0, 4.5),
    ("Jamaican Blue Mountain", "Jamaica", "Arabica", "Light", "Chocolate, Nuts, Herbal, Mild", "Extremely smooth, low acidity", "900-1700m", "Washed", 2.5, 3.5, 4.5),
    ("Taiwan Alishan", "Taiwan", "Arabica", "Light", "Floral, Citrus, Honey", "High elevation with floral notes", "1000-1600m", "Washed", 4.5, 3.0, 4.5),

    # Specialty & Rare (15)
    ("Rwanda Bourbon", "Rwanda", "Arabica", "Light", "Red Fruits, Caramel, Floral", "Clean and sweet with fruit notes", "1700-2000m", "Washed", 4.5, 3.5, 4.5),
    ("Burundi", "Burundi", "Arabica", "Light", "Citrus, Berry, Floral", "Bright acidity with fruit notes", "1250-2000m", "Washed", 4.5, 3.5, 4.0),
    ("Tanzania Peaberry", "Tanzania", "Arabica", "Medium", "Blackcurrant, Citrus, Wine", "Concentrated flavor, wine-like", "1100-1800m", "Washed", 4.5, 4.0, 4.0),
    ("Malawi", "Malawi", "Arabica", "Light", "Citrus, Floral, Stone Fruit", "Clean and bright", "900-2000m", "Washed", 4.5, 3.5, 4.0),
    ("Zimbabwe", "Zimbabwe", "Arabica", "Light", "Citrus, Wine, Chocolate", "Balanced with wine-like notes", "1000-2000m", "Washed", 4.0, 3.5, 4.0),
    ("Uganda Bugisu", "Uganda", "Arabica", "Medium", "Wine, Chocolate, Citrus", "Full body with wine notes", "1200-2300m", "Washed", 4.0, 4.5, 4.0),
    ("Zambia", "Zambia", "Arabica", "Light", "Citrus, Honey, Floral", "Clean and sweet", "900-1800m", "Washed", 4.0, 3.5, 4.0),
    ("Congo Kivu", "Democratic Republic of Congo", "Arabica", "Medium", "Citrus, Chocolate, Fruity", "Complex with fruit notes", "1400-2100m", "Washed", 4.0, 4.0, 4.0),
    ("Cameroon", "Cameroon", "Robusta", "Medium-Dark", "Chocolate, Nuts, Earthy", "Full body with chocolate", "600-1400m", "Natural", 2.5, 4.5, 3.0),
    ("Thai Doi Chaang", "Thailand", "Arabica", "Medium", "Chocolate, Caramel, Nuts", "Smooth with chocolate notes", "1000-1700m", "Washed", 3.5, 4.0, 4.0),
    ("Laos Bolaven Plateau", "Laos", "Arabica", "Medium", "Chocolate, Nuts, Citrus", "Balanced with chocolate", "1000-1350m", "Washed", 3.5, 4.0, 4.0),
    ("Myanmar", "Myanmar", "Arabica", "Light", "Floral, Citrus, Honey", "Emerging origin with potential", "1000-1800m", "Washed", 4.0, 3.5, 4.0),
    ("Ecuador", "Ecuador", "Arabica", "Medium", "Chocolate, Nuts, Caramel", "Smooth and balanced", "900-1800m", "Washed", 3.5, 4.0, 4.0),
    ("Bolivia", "Bolivia", "Arabica", "Light", "Chocolate, Citrus, Floral", "Clean with chocolate notes", "1200-2300m", "Washed", 4.0, 3.5, 4.5),
    ("Dominican Republic", "Dominican Republic", "Arabica", "Medium", "Chocolate, Nuts, Citrus", "Balanced and smooth", "500-1500m", "Washed", 3.5, 4.0, 4.0),
]

def escape_string(s):
    """Escape special characters for Dart string"""
    return s.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n")

print("  static List<CoffeeBean> getCoffeeBeans() {")
print("    final now = DateTime.now();")
print("    return [")

for i, (name, origin, bean_type, roast, flavor, desc, altitude, processing, acidity, body, sweetness) in enumerate(coffee_beans, 1):
    bean_id = name.lower().replace(" ", "-").replace(",", "").replace("'", "")

    print(f"      CoffeeBean(")
    print(f"        id: '{bean_id}',")
    print(f"        name: '{escape_string(name)}',")
    print(f"        origin: '{escape_string(origin)}',")
    print(f"        type: '{bean_type}',")
    print(f"        roastLevel: '{roast}',")
    print(f"        flavorNotes: '{escape_string(flavor)}',")
    print(f"        description: '{escape_string(desc)}',")
    print(f"        altitude: '{altitude}',")
    print(f"        processing: '{processing}',")
    print(f"        acidity: {acidity},")
    print(f"        body: {body},")
    print(f"        sweetness: {sweetness},")
    print(f"        createdAt: now,")
    print(f"      ),")

print("    ];")
print("  }")

print(f"\n// Generated {len(coffee_beans)} coffee beans")
print(f"// Types: Arabica={sum(1 for b in coffee_beans if b[2]=='Arabica')}, Robusta={sum(1 for b in coffee_beans if b[2]=='Robusta')}")
print(f"// Roasts: Light={sum(1 for b in coffee_beans if b[3]=='Light')}, Medium={sum(1 for b in coffee_beans if b[3]=='Medium')}, Medium-Dark={sum(1 for b in coffee_beans if b[3]=='Medium-Dark')}, Dark={sum(1 for b in coffee_beans if b[3]=='Dark')}")
