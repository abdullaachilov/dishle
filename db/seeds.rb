dishes = [
  # Italian (15)
  { name: "Carbonara", cuisine: "Italian", base: "Pasta", protein: "Egg", star: "Pecorino", fat: "Guanciale", heat: "Black Pepper", difficulty: "easy", description: "Roman pasta with egg, pecorino, cured pork cheek, and black pepper." },
  { name: "Bolognese", cuisine: "Italian", base: "Pasta", protein: "Beef", star: "Tomato", fat: "Olive Oil", heat: "Garlic", difficulty: "easy", description: "Slow-cooked meat sauce from Bologna." },
  { name: "Cacio e Pepe", cuisine: "Italian", base: "Pasta", protein: "None", star: "Pecorino", fat: "Butter", heat: "Black Pepper", difficulty: "medium", description: "Three-ingredient Roman pasta — cheese, pepper, pasta water." },
  { name: "Margherita Pizza", cuisine: "Italian", base: "Dough", protein: "Mozzarella", star: "Tomato", fat: "Olive Oil", heat: "Basil", difficulty: "easy", description: "Neapolitan pizza representing the Italian flag." },
  { name: "Risotto", cuisine: "Italian", base: "Rice", protein: "None", star: "Parmesan", fat: "Butter", heat: "White Wine", difficulty: "easy", description: "Creamy northern Italian rice dish." },
  { name: "Pesto Pasta", cuisine: "Italian", base: "Pasta", protein: "Pine Nuts", star: "Basil", fat: "Olive Oil", heat: "Garlic", difficulty: "easy", description: "Genovese sauce of basil, pine nuts, garlic, and parmesan." },
  { name: "Lasagna", cuisine: "Italian", base: "Pasta", protein: "Beef", star: "Tomato", fat: "Butter", heat: "Nutmeg", difficulty: "easy", description: "Layered pasta with meat sauce and béchamel." },
  { name: "Arancini", cuisine: "Italian", base: "Rice", protein: "Mozzarella", star: "Saffron", fat: "Olive Oil", heat: "Garlic", difficulty: "medium", description: "Sicilian fried rice balls stuffed with cheese." },
  { name: "Amatriciana", cuisine: "Italian", base: "Pasta", protein: "None", star: "Tomato", fat: "Guanciale", heat: "Chili Flakes", difficulty: "medium", description: "Roman pasta with tomato, guanciale, and pecorino." },
  { name: "Caprese Salad", cuisine: "Italian", base: "None", protein: "Mozzarella", star: "Tomato", fat: "Olive Oil", heat: "Basil", difficulty: "easy", description: "Simple salad of tomato, mozzarella, and basil." },
  { name: "Osso Buco", cuisine: "Italian", base: "Rice", protein: "Veal", star: "White Wine", fat: "Butter", heat: "Gremolata", difficulty: "hard", description: "Braised veal shanks with vegetables and gremolata." },
  { name: "Tiramisu", cuisine: "Italian", base: "Ladyfingers", protein: "Egg", star: "Mascarpone", fat: "Cream", heat: "Cocoa", difficulty: "medium", description: "Layered coffee-soaked dessert with mascarpone cream." },
  { name: "Focaccia", cuisine: "Italian", base: "Dough", protein: "None", star: "Rosemary", fat: "Olive Oil", heat: "Sea Salt", difficulty: "easy", description: "Fluffy Italian flatbread with olive oil and herbs." },
  { name: "Bruschetta", cuisine: "Italian", base: "Bread", protein: "None", star: "Tomato", fat: "Olive Oil", heat: "Garlic", difficulty: "easy", description: "Grilled bread topped with fresh tomatoes and basil." },
  { name: "Vitello Tonnato", cuisine: "Italian", base: "None", protein: "Veal", star: "Tuna", fat: "Mayonnaise", heat: "Capers", difficulty: "hard", description: "Cold sliced veal with creamy tuna sauce." },

  # Japanese (12)
  { name: "Ramen", cuisine: "Japanese", base: "Noodles", protein: "Pork", star: "Miso", fat: "Sesame Oil", heat: "Ginger", difficulty: "easy", description: "Japanese noodle soup with rich broth and toppings." },
  { name: "Sushi Roll", cuisine: "Japanese", base: "Rice", protein: "Salmon", star: "Nori", fat: "Sesame Oil", heat: "Wasabi", difficulty: "easy", description: "Vinegared rice wrapped in seaweed with fish." },
  { name: "Teriyaki Chicken", cuisine: "Japanese", base: "Rice", protein: "Chicken", star: "Soy Sauce", fat: "Sesame Oil", heat: "Ginger", difficulty: "easy", description: "Glazed chicken in sweet soy-based sauce." },
  { name: "Tonkatsu", cuisine: "Japanese", base: "Bread Crumbs", protein: "Pork", star: "Cabbage", fat: "Vegetable Oil", heat: "Mustard", difficulty: "medium", description: "Japanese deep-fried breaded pork cutlet." },
  { name: "Gyoza", cuisine: "Japanese", base: "Dough", protein: "Pork", star: "Cabbage", fat: "Sesame Oil", heat: "Ginger", difficulty: "medium", description: "Pan-fried Japanese dumplings." },
  { name: "Miso Soup", cuisine: "Japanese", base: "Dashi", protein: "Tofu", star: "Miso", fat: "None", heat: "Scallion", difficulty: "easy", description: "Traditional Japanese soup with fermented soybean paste." },
  { name: "Yakitori", cuisine: "Japanese", base: "None", protein: "Chicken", star: "Soy Sauce", fat: "None", heat: "Shichimi", difficulty: "medium", description: "Grilled chicken skewers with tare sauce." },
  { name: "Okonomiyaki", cuisine: "Japanese", base: "Flour", protein: "Egg", star: "Cabbage", fat: "Vegetable Oil", heat: "Bonito", difficulty: "hard", description: "Japanese savory pancake — 'as you like it'." },
  { name: "Katsu Curry", cuisine: "Japanese", base: "Rice", protein: "Pork", star: "Curry Roux", fat: "Vegetable Oil", heat: "Ginger", difficulty: "easy", description: "Breaded cutlet with Japanese curry sauce over rice." },
  { name: "Tempura", cuisine: "Japanese", base: "Flour", protein: "Shrimp", star: "Dashi", fat: "Vegetable Oil", heat: "Ginger", difficulty: "medium", description: "Light, crispy battered and fried seafood." },
  { name: "Udon", cuisine: "Japanese", base: "Noodles", protein: "None", star: "Dashi", fat: "None", heat: "Scallion", difficulty: "easy", description: "Thick wheat noodles in savory broth." },
  { name: "Takoyaki", cuisine: "Japanese", base: "Flour", protein: "Octopus", star: "Dashi", fat: "Vegetable Oil", heat: "Bonito", difficulty: "hard", description: "Osaka street food — crispy fried octopus balls." },

  # Mexican (10)
  { name: "Tacos Al Pastor", cuisine: "Mexican", base: "Tortilla", protein: "Pork", star: "Pineapple", fat: "Lard", heat: "Chili", difficulty: "medium", description: "Spit-grilled marinated pork with pineapple." },
  { name: "Guacamole", cuisine: "Mexican", base: "None", protein: "None", star: "Avocado", fat: "None", heat: "Jalapeno", difficulty: "easy", description: "Mashed avocado with lime, cilantro, and chili." },
  { name: "Burrito", cuisine: "Mexican", base: "Tortilla", protein: "Beef", star: "Beans", fat: "Sour Cream", heat: "Jalapeno", difficulty: "easy", description: "Large flour tortilla wrapped around a filling." },
  { name: "Enchiladas", cuisine: "Mexican", base: "Tortilla", protein: "Chicken", star: "Tomato", fat: "Cream", heat: "Chili", difficulty: "easy", description: "Rolled tortillas covered in chili sauce." },
  { name: "Quesadilla", cuisine: "Mexican", base: "Tortilla", protein: "Chicken", star: "Cheese", fat: "Butter", heat: "Jalapeno", difficulty: "easy", description: "Grilled tortilla filled with melted cheese." },
  { name: "Elote", cuisine: "Mexican", base: "Corn", protein: "None", star: "Cotija", fat: "Mayonnaise", heat: "Chili Powder", difficulty: "medium", description: "Mexican street corn with mayo, cheese, and chili." },
  { name: "Chilaquiles", cuisine: "Mexican", base: "Tortilla", protein: "Egg", star: "Salsa Verde", fat: "Sour Cream", heat: "Chili", difficulty: "medium", description: "Fried tortilla chips simmered in salsa with eggs." },
  { name: "Tamales", cuisine: "Mexican", base: "Corn", protein: "Pork", star: "Masa", fat: "Lard", heat: "Chili", difficulty: "hard", description: "Steamed corn dough stuffed with meat in corn husks." },
  { name: "Pozole", cuisine: "Mexican", base: "Hominy", protein: "Pork", star: "Cabbage", fat: "None", heat: "Chili", difficulty: "hard", description: "Traditional Mexican stew with hominy and pork." },
  { name: "Carnitas", cuisine: "Mexican", base: "Tortilla", protein: "Pork", star: "Orange", fat: "Lard", heat: "Cumin", difficulty: "medium", description: "Slow-braised pulled pork in citrus and spices." },

  # Thai (8)
  { name: "Pad Thai", cuisine: "Thai", base: "Noodles", protein: "Shrimp", star: "Tamarind", fat: "Peanuts", heat: "Chili Flakes", difficulty: "easy", description: "Thailand's iconic stir-fried rice noodle dish." },
  { name: "Green Curry", cuisine: "Thai", base: "Rice", protein: "Chicken", star: "Coconut Milk", fat: "Palm Oil", heat: "Green Chili", difficulty: "easy", description: "Aromatic Thai curry with green chili paste." },
  { name: "Tom Yum", cuisine: "Thai", base: "Broth", protein: "Shrimp", star: "Lemongrass", fat: "None", heat: "Chili", difficulty: "medium", description: "Hot and sour Thai soup." },
  { name: "Som Tum", cuisine: "Thai", base: "Papaya", protein: "Shrimp", star: "Lime", fat: "Peanuts", heat: "Chili", difficulty: "medium", description: "Spicy green papaya salad." },
  { name: "Massaman Curry", cuisine: "Thai", base: "Rice", protein: "Beef", star: "Coconut Milk", fat: "Peanuts", heat: "Cinnamon", difficulty: "medium", description: "Rich, mild Thai curry with Persian influence." },
  { name: "Pad See Ew", cuisine: "Thai", base: "Noodles", protein: "Chicken", star: "Soy Sauce", fat: "Vegetable Oil", heat: "Garlic", difficulty: "easy", description: "Wide rice noodles stir-fried with soy sauce." },
  { name: "Larb", cuisine: "Thai", base: "Rice", protein: "Pork", star: "Lime", fat: "None", heat: "Chili Flakes", difficulty: "medium", description: "Spicy minced meat salad with herbs and lime." },
  { name: "Khao Soi", cuisine: "Thai", base: "Noodles", protein: "Chicken", star: "Coconut Milk", fat: "Palm Oil", heat: "Turmeric", difficulty: "hard", description: "Northern Thai coconut curry noodle soup." },

  # Indian (12)
  { name: "Butter Chicken", cuisine: "Indian", base: "Rice", protein: "Chicken", star: "Tomato", fat: "Butter", heat: "Garam Masala", difficulty: "easy", description: "Creamy tomato-based chicken curry from Delhi." },
  { name: "Biryani", cuisine: "Indian", base: "Rice", protein: "Chicken", star: "Saffron", fat: "Ghee", heat: "Cardamom", difficulty: "easy", description: "Fragrant layered rice and meat dish." },
  { name: "Tikka Masala", cuisine: "Indian", base: "Rice", protein: "Chicken", star: "Tomato", fat: "Cream", heat: "Cumin", difficulty: "easy", description: "Chunks of chicken in spiced creamy tomato sauce." },
  { name: "Palak Paneer", cuisine: "Indian", base: "None", protein: "Paneer", star: "Spinach", fat: "Ghee", heat: "Cumin", difficulty: "medium", description: "Soft cheese cubes in creamy spinach sauce." },
  { name: "Dal Tadka", cuisine: "Indian", base: "Lentils", protein: "None", star: "Turmeric", fat: "Ghee", heat: "Cumin", difficulty: "medium", description: "Tempered lentil soup — Indian comfort food." },
  { name: "Samosa", cuisine: "Indian", base: "Dough", protein: "None", star: "Potato", fat: "Vegetable Oil", heat: "Cumin", difficulty: "easy", description: "Crispy fried pastry with spiced potato filling." },
  { name: "Naan", cuisine: "Indian", base: "Flour", protein: "None", star: "Yogurt", fat: "Ghee", heat: "Garlic", difficulty: "easy", description: "Leavened flatbread baked in tandoor oven." },
  { name: "Tandoori Chicken", cuisine: "Indian", base: "None", protein: "Chicken", star: "Yogurt", fat: "Ghee", heat: "Paprika", difficulty: "easy", description: "Yogurt-marinated chicken cooked in clay oven." },
  { name: "Chana Masala", cuisine: "Indian", base: "Rice", protein: "Chickpeas", star: "Tomato", fat: "Ghee", heat: "Garam Masala", difficulty: "medium", description: "Spiced chickpea curry in tomato sauce." },
  { name: "Vindaloo", cuisine: "Indian", base: "Rice", protein: "Pork", star: "Vinegar", fat: "Vegetable Oil", heat: "Chili", difficulty: "hard", description: "Fiery Goan curry with Portuguese influence." },
  { name: "Dosa", cuisine: "Indian", base: "Rice", protein: "None", star: "Potato", fat: "Ghee", heat: "Mustard Seeds", difficulty: "medium", description: "Crispy fermented rice crepe with potato filling." },
  { name: "Rogan Josh", cuisine: "Indian", base: "Rice", protein: "Lamb", star: "Yogurt", fat: "Ghee", heat: "Kashmiri Chili", difficulty: "hard", description: "Aromatic Kashmiri lamb curry in rich gravy." },

  # Chinese (12)
  { name: "Kung Pao Chicken", cuisine: "Chinese", base: "Rice", protein: "Chicken", star: "Peanuts", fat: "Sesame Oil", heat: "Sichuan Pepper", difficulty: "easy", description: "Spicy Sichuan stir-fry with peanuts and chili." },
  { name: "Mapo Tofu", cuisine: "Chinese", base: "Rice", protein: "Tofu", star: "Doubanjiang", fat: "Sesame Oil", heat: "Sichuan Pepper", difficulty: "medium", description: "Numbing-spicy tofu in fermented bean sauce." },
  { name: "Fried Rice", cuisine: "Chinese", base: "Rice", protein: "Egg", star: "Soy Sauce", fat: "Sesame Oil", heat: "Scallion", difficulty: "easy", description: "Wok-fried day-old rice with egg and vegetables." },
  { name: "Peking Duck", cuisine: "Chinese", base: "Pancake", protein: "Duck", star: "Hoisin", fat: "Duck Fat", heat: "Scallion", difficulty: "medium", description: "Crispy-skinned duck with thin pancakes and hoisin." },
  { name: "Dim Sum Dumplings", cuisine: "Chinese", base: "Dough", protein: "Shrimp", star: "Soy Sauce", fat: "Sesame Oil", heat: "Ginger", difficulty: "easy", description: "Cantonese steamed dumplings served at brunch." },
  { name: "Hot Pot", cuisine: "Chinese", base: "Broth", protein: "Beef", star: "Soy Sauce", fat: "Sesame Oil", heat: "Sichuan Pepper", difficulty: "medium", description: "Communal simmering pot of broth with dippable ingredients." },
  { name: "Chow Mein", cuisine: "Chinese", base: "Noodles", protein: "Chicken", star: "Soy Sauce", fat: "Sesame Oil", heat: "Ginger", difficulty: "easy", description: "Stir-fried noodles with vegetables and protein." },
  { name: "Sweet and Sour Pork", cuisine: "Chinese", base: "Rice", protein: "Pork", star: "Pineapple", fat: "Vegetable Oil", heat: "Ginger", difficulty: "easy", description: "Crispy pork in tangy sweet and sour sauce." },
  { name: "Wonton Soup", cuisine: "Chinese", base: "Dough", protein: "Pork", star: "Broth", fat: "Sesame Oil", heat: "Scallion", difficulty: "easy", description: "Silky pork dumplings in clear broth." },
  { name: "Dan Dan Noodles", cuisine: "Chinese", base: "Noodles", protein: "Pork", star: "Sesame Paste", fat: "Chili Oil", heat: "Sichuan Pepper", difficulty: "hard", description: "Sichuan street noodles with spicy sesame sauce." },
  { name: "Char Siu", cuisine: "Chinese", base: "Rice", protein: "Pork", star: "Hoisin", fat: "Honey", heat: "Five Spice", difficulty: "medium", description: "Cantonese BBQ pork with sweet sticky glaze." },
  { name: "Congee", cuisine: "Chinese", base: "Rice", protein: "Chicken", star: "Ginger", fat: "Sesame Oil", heat: "Scallion", difficulty: "easy", description: "Comforting rice porridge with savory toppings." },

  # Korean (8)
  { name: "Bibimbap", cuisine: "Korean", base: "Rice", protein: "Beef", star: "Gochujang", fat: "Sesame Oil", heat: "Gochugaru", difficulty: "easy", description: "Mixed rice bowl with vegetables, meat, and chili paste." },
  { name: "Kimchi Jjigae", cuisine: "Korean", base: "Rice", protein: "Pork", star: "Kimchi", fat: "Sesame Oil", heat: "Gochugaru", difficulty: "medium", description: "Fermented cabbage stew with pork and tofu." },
  { name: "Bulgogi", cuisine: "Korean", base: "Rice", protein: "Beef", star: "Soy Sauce", fat: "Sesame Oil", heat: "Garlic", difficulty: "easy", description: "Sweet soy-marinated grilled beef." },
  { name: "Korean Fried Chicken", cuisine: "Korean", base: "None", protein: "Chicken", star: "Gochujang", fat: "Vegetable Oil", heat: "Garlic", difficulty: "easy", description: "Double-fried crispy chicken with sweet-spicy glaze." },
  { name: "Tteokbokki", cuisine: "Korean", base: "Rice Cake", protein: "Fish Cake", star: "Gochujang", fat: "Sesame Oil", heat: "Gochugaru", difficulty: "medium", description: "Spicy stir-fried rice cakes in chili sauce." },
  { name: "Japchae", cuisine: "Korean", base: "Noodles", protein: "Beef", star: "Soy Sauce", fat: "Sesame Oil", heat: "Garlic", difficulty: "medium", description: "Sweet potato glass noodles with vegetables and beef." },
  { name: "Sundubu Jjigae", cuisine: "Korean", base: "Rice", protein: "Tofu", star: "Kimchi", fat: "Sesame Oil", heat: "Gochugaru", difficulty: "medium", description: "Spicy soft tofu stew with egg." },
  { name: "Kimbap", cuisine: "Korean", base: "Rice", protein: "Beef", star: "Nori", fat: "Sesame Oil", heat: "Pickled Radish", difficulty: "easy", description: "Korean seaweed rice roll with vegetables." },

  # Middle Eastern (8)
  { name: "Falafel", cuisine: "Middle Eastern", base: "None", protein: "Chickpeas", star: "Tahini", fat: "Vegetable Oil", heat: "Cumin", difficulty: "easy", description: "Deep-fried chickpea fritters in pita." },
  { name: "Shawarma", cuisine: "Middle Eastern", base: "Pita", protein: "Chicken", star: "Tahini", fat: "Olive Oil", heat: "Cumin", difficulty: "easy", description: "Spit-roasted meat wrapped in flatbread." },
  { name: "Hummus", cuisine: "Middle Eastern", base: "None", protein: "Chickpeas", star: "Tahini", fat: "Olive Oil", heat: "Paprika", difficulty: "easy", description: "Smooth chickpea and tahini dip." },
  { name: "Kebab", cuisine: "Middle Eastern", base: "Pita", protein: "Lamb", star: "Yogurt", fat: "Olive Oil", heat: "Sumac", difficulty: "easy", description: "Grilled meat skewers with flatbread." },
  { name: "Shakshuka", cuisine: "Middle Eastern", base: "Bread", protein: "Egg", star: "Tomato", fat: "Olive Oil", heat: "Cumin", difficulty: "medium", description: "Eggs poached in spiced tomato sauce." },
  { name: "Baba Ganoush", cuisine: "Middle Eastern", base: "None", protein: "None", star: "Eggplant", fat: "Olive Oil", heat: "Garlic", difficulty: "easy", description: "Smoky roasted eggplant dip with tahini." },
  { name: "Kibbeh", cuisine: "Middle Eastern", base: "Bulgur", protein: "Lamb", star: "Pine Nuts", fat: "Olive Oil", heat: "Allspice", difficulty: "hard", description: "Fried bulgur shell stuffed with spiced lamb." },
  { name: "Fattoush", cuisine: "Middle Eastern", base: "Pita", protein: "None", star: "Sumac", fat: "Olive Oil", heat: "Mint", difficulty: "easy", description: "Levantine bread salad with crispy pita chips." },

  # American (12)
  { name: "Cheeseburger", cuisine: "American", base: "Bun", protein: "Beef", star: "Cheese", fat: "Butter", heat: "Mustard", difficulty: "easy", description: "The American classic — beef patty with cheese." },
  { name: "Mac and Cheese", cuisine: "American", base: "Pasta", protein: "None", star: "Cheddar", fat: "Butter", heat: "Mustard", difficulty: "easy", description: "Baked pasta in creamy cheese sauce." },
  { name: "BBQ Ribs", cuisine: "American", base: "None", protein: "Pork", star: "BBQ Sauce", fat: "Lard", heat: "Paprika", difficulty: "easy", description: "Slow-smoked pork ribs with sticky glaze." },
  { name: "Clam Chowder", cuisine: "American", base: "Potato", protein: "Clam", star: "Cream", fat: "Butter", heat: "Thyme", difficulty: "medium", description: "New England-style creamy clam soup." },
  { name: "Buffalo Wings", cuisine: "American", base: "None", protein: "Chicken", star: "Hot Sauce", fat: "Butter", heat: "Cayenne", difficulty: "easy", description: "Fried chicken wings tossed in hot butter sauce." },
  { name: "Eggs Benedict", cuisine: "American", base: "English Muffin", protein: "Egg", star: "Hollandaise", fat: "Butter", heat: "Cayenne", difficulty: "medium", description: "Poached eggs with ham and hollandaise on muffin." },
  { name: "Philly Cheesesteak", cuisine: "American", base: "Hoagie Roll", protein: "Beef", star: "Provolone", fat: "Butter", heat: "Onion", difficulty: "medium", description: "Sliced beef with melted cheese on a long roll." },
  { name: "Pancakes", cuisine: "American", base: "Flour", protein: "Egg", star: "Maple Syrup", fat: "Butter", heat: "Vanilla", difficulty: "easy", description: "Fluffy American breakfast cakes." },
  { name: "Gumbo", cuisine: "American", base: "Rice", protein: "Shrimp", star: "Okra", fat: "Butter", heat: "Cayenne", difficulty: "hard", description: "Louisiana stew with the holy trinity and seafood." },
  { name: "Jambalaya", cuisine: "American", base: "Rice", protein: "Shrimp", star: "Tomato", fat: "Vegetable Oil", heat: "Cayenne", difficulty: "medium", description: "Cajun rice dish with sausage and seafood." },
  { name: "Lobster Roll", cuisine: "American", base: "Bun", protein: "Lobster", star: "Lemon", fat: "Butter", heat: "Chives", difficulty: "medium", description: "New England butter-poached lobster on a toasted bun." },
  { name: "Cornbread", cuisine: "American", base: "Cornmeal", protein: "Egg", star: "Honey", fat: "Butter", heat: "None", difficulty: "easy", description: "Sweet and savory Southern bread made with cornmeal." },

  # French (10)
  { name: "Croissant", cuisine: "French", base: "Flour", protein: "Egg", star: "Yeast", fat: "Butter", heat: "None", difficulty: "easy", description: "Flaky, buttery French pastry." },
  { name: "French Onion Soup", cuisine: "French", base: "Bread", protein: "Gruyere", star: "Onion", fat: "Butter", heat: "Thyme", difficulty: "easy", description: "Caramelized onion soup with cheese crouton." },
  { name: "Ratatouille", cuisine: "French", base: "None", protein: "None", star: "Tomato", fat: "Olive Oil", heat: "Herbs de Provence", difficulty: "easy", description: "Provencal stewed vegetables." },
  { name: "Coq au Vin", cuisine: "French", base: "Potato", protein: "Chicken", star: "Red Wine", fat: "Bacon", heat: "Thyme", difficulty: "medium", description: "Chicken braised in red wine with mushrooms." },
  { name: "Croque Monsieur", cuisine: "French", base: "Bread", protein: "Ham", star: "Gruyere", fat: "Butter", heat: "Nutmeg", difficulty: "medium", description: "French grilled ham and cheese sandwich." },
  { name: "Quiche Lorraine", cuisine: "French", base: "Pastry", protein: "Egg", star: "Gruyere", fat: "Cream", heat: "Nutmeg", difficulty: "medium", description: "Savory custard tart with bacon and cheese." },
  { name: "Bouillabaisse", cuisine: "French", base: "Bread", protein: "Fish", star: "Saffron", fat: "Olive Oil", heat: "Fennel", difficulty: "hard", description: "Provencal fish stew from Marseille." },
  { name: "Cassoulet", cuisine: "French", base: "Beans", protein: "Duck", star: "Sausage", fat: "Duck Fat", heat: "Thyme", difficulty: "hard", description: "Slow-cooked casserole of white beans and meat." },
  { name: "Nicoise Salad", cuisine: "French", base: "Potato", protein: "Tuna", star: "Olive", fat: "Olive Oil", heat: "Dijon", difficulty: "medium", description: "Classic French composed salad from Nice." },
  { name: "Beef Bourguignon", cuisine: "French", base: "Potato", protein: "Beef", star: "Red Wine", fat: "Butter", heat: "Thyme", difficulty: "hard", description: "Burgundian beef stew braised in red wine." },

  # Spanish (6)
  { name: "Paella", cuisine: "Spanish", base: "Rice", protein: "Shrimp", star: "Saffron", fat: "Olive Oil", heat: "Paprika", difficulty: "easy", description: "Valencian rice dish with seafood and saffron." },
  { name: "Tortilla Espanola", cuisine: "Spanish", base: "Potato", protein: "Egg", star: "Onion", fat: "Olive Oil", heat: "None", difficulty: "medium", description: "Spanish potato and egg omelette." },
  { name: "Patatas Bravas", cuisine: "Spanish", base: "Potato", protein: "None", star: "Tomato", fat: "Olive Oil", heat: "Paprika", difficulty: "easy", description: "Fried potatoes with spicy tomato sauce." },
  { name: "Gazpacho", cuisine: "Spanish", base: "Bread", protein: "None", star: "Tomato", fat: "Olive Oil", heat: "Garlic", difficulty: "medium", description: "Cold Spanish tomato soup." },
  { name: "Chorizo Tapas", cuisine: "Spanish", base: "Bread", protein: "Pork", star: "Paprika", fat: "Olive Oil", heat: "Garlic", difficulty: "easy", description: "Pan-fried Spanish cured sausage." },
  { name: "Gambas al Ajillo", cuisine: "Spanish", base: "Bread", protein: "Shrimp", star: "White Wine", fat: "Olive Oil", heat: "Garlic", difficulty: "medium", description: "Garlic shrimp sizzling in olive oil." },

  # Vietnamese (6)
  { name: "Pho", cuisine: "Vietnamese", base: "Noodles", protein: "Beef", star: "Star Anise", fat: "None", heat: "Chili", difficulty: "easy", description: "Vietnamese noodle soup with aromatic broth." },
  { name: "Banh Mi", cuisine: "Vietnamese", base: "Baguette", protein: "Pork", star: "Pickled Carrot", fat: "Mayonnaise", heat: "Jalapeno", difficulty: "easy", description: "Vietnamese sandwich on crispy baguette." },
  { name: "Spring Rolls", cuisine: "Vietnamese", base: "Rice Paper", protein: "Shrimp", star: "Mint", fat: "Peanuts", heat: "Chili", difficulty: "easy", description: "Fresh rice paper rolls with herbs and shrimp." },
  { name: "Bun Cha", cuisine: "Vietnamese", base: "Noodles", protein: "Pork", star: "Fish Sauce", fat: "None", heat: "Chili", difficulty: "hard", description: "Grilled pork meatballs with rice noodles — Hanoi classic." },
  { name: "Cao Lau", cuisine: "Vietnamese", base: "Noodles", protein: "Pork", star: "Soy Sauce", fat: "Pork Fat", heat: "Chili", difficulty: "hard", description: "Hoi An specialty noodles with pork and herbs." },
  { name: "Com Tam", cuisine: "Vietnamese", base: "Rice", protein: "Pork", star: "Fish Sauce", fat: "Vegetable Oil", heat: "Scallion", difficulty: "medium", description: "Broken rice with grilled pork chop." },

  # Greek (7)
  { name: "Moussaka", cuisine: "Greek", base: "Eggplant", protein: "Lamb", star: "Bechamel", fat: "Olive Oil", heat: "Cinnamon", difficulty: "medium", description: "Layered eggplant, meat, and bechamel casserole." },
  { name: "Gyros", cuisine: "Greek", base: "Pita", protein: "Lamb", star: "Tzatziki", fat: "Olive Oil", heat: "Oregano", difficulty: "easy", description: "Spit-roasted meat in pita with yogurt sauce." },
  { name: "Greek Salad", cuisine: "Greek", base: "None", protein: "Feta", star: "Olive", fat: "Olive Oil", heat: "Oregano", difficulty: "easy", description: "Fresh vegetables with feta and olives." },
  { name: "Spanakopita", cuisine: "Greek", base: "Phyllo", protein: "Feta", star: "Spinach", fat: "Butter", heat: "Dill", difficulty: "medium", description: "Flaky phyllo pastry with spinach and feta filling." },
  { name: "Souvlaki", cuisine: "Greek", base: "Pita", protein: "Chicken", star: "Lemon", fat: "Olive Oil", heat: "Oregano", difficulty: "easy", description: "Grilled meat skewers with lemon and herbs." },
  { name: "Pastitsio", cuisine: "Greek", base: "Pasta", protein: "Beef", star: "Bechamel", fat: "Butter", heat: "Cinnamon", difficulty: "hard", description: "Greek baked pasta with meat sauce and bechamel." },
  { name: "Dolma", cuisine: "Greek", base: "Rice", protein: "Lamb", star: "Grape Leaves", fat: "Olive Oil", heat: "Dill", difficulty: "hard", description: "Stuffed grape leaves with rice and herbs." },

  # British (5)
  { name: "Fish and Chips", cuisine: "British", base: "Potato", protein: "Fish", star: "Vinegar", fat: "Vegetable Oil", heat: "None", difficulty: "easy", description: "Battered fried fish with thick-cut chips." },
  { name: "Shepherds Pie", cuisine: "British", base: "Potato", protein: "Lamb", star: "Gravy", fat: "Butter", heat: "Rosemary", difficulty: "medium", description: "Lamb mince topped with mashed potato crust." },
  { name: "Full English Breakfast", cuisine: "British", base: "Toast", protein: "Egg", star: "Beans", fat: "Bacon", heat: "Black Pepper", difficulty: "easy", description: "The iconic morning fry-up." },
  { name: "Bangers and Mash", cuisine: "British", base: "Potato", protein: "Pork", star: "Gravy", fat: "Butter", heat: "Mustard", difficulty: "easy", description: "Sausages with mashed potatoes and onion gravy." },
  { name: "Cornish Pasty", cuisine: "British", base: "Pastry", protein: "Beef", star: "Potato", fat: "Butter", heat: "Black Pepper", difficulty: "medium", description: "Baked pastry filled with beef and vegetables." },

  # Ethiopian (3)
  { name: "Doro Wat", cuisine: "Ethiopian", base: "Injera", protein: "Chicken", star: "Berbere", fat: "Butter", heat: "Chili", difficulty: "hard", description: "Spicy Ethiopian chicken stew on spongy bread." },
  { name: "Kitfo", cuisine: "Ethiopian", base: "Injera", protein: "Beef", star: "Mitmita", fat: "Butter", heat: "Chili", difficulty: "hard", description: "Ethiopian beef tartare with spiced butter." },
  { name: "Misir Wat", cuisine: "Ethiopian", base: "Injera", protein: "Lentils", star: "Berbere", fat: "Olive Oil", heat: "Garlic", difficulty: "medium", description: "Spiced Ethiopian red lentil stew." },

  # Caribbean (4)
  { name: "Jerk Chicken", cuisine: "Jamaican", base: "Rice", protein: "Chicken", star: "Allspice", fat: "None", heat: "Scotch Bonnet", difficulty: "medium", description: "Smoky, fiery chicken marinated in jerk spices." },
  { name: "Ackee and Saltfish", cuisine: "Jamaican", base: "None", protein: "Cod", star: "Ackee", fat: "Vegetable Oil", heat: "Scotch Bonnet", difficulty: "hard", description: "Jamaica's national dish with tropical fruit and salted cod." },
  { name: "Doubles", cuisine: "Trinidadian", base: "Flatbread", protein: "Chickpeas", star: "Turmeric", fat: "Vegetable Oil", heat: "Scotch Bonnet", difficulty: "hard", description: "Trinidadian street food — curried chickpeas in fried bread." },
  { name: "Rice and Peas", cuisine: "Jamaican", base: "Rice", protein: "None", star: "Coconut Milk", fat: "None", heat: "Scotch Bonnet", difficulty: "easy", description: "Jamaican rice cooked in coconut milk with kidney beans." },

  # Brazilian (3)
  { name: "Feijoada", cuisine: "Brazilian", base: "Rice", protein: "Pork", star: "Black Beans", fat: "Lard", heat: "Bay Leaf", difficulty: "hard", description: "Brazil's national dish — hearty black bean and pork stew." },
  { name: "Pao de Queijo", cuisine: "Brazilian", base: "Tapioca", protein: "Egg", star: "Cheese", fat: "Vegetable Oil", heat: "None", difficulty: "easy", description: "Brazilian cheese bread made with tapioca flour." },
  { name: "Moqueca", cuisine: "Brazilian", base: "Rice", protein: "Fish", star: "Coconut Milk", fat: "Palm Oil", heat: "Chili", difficulty: "hard", description: "Bahian fish stew with coconut milk and dende oil." },

  # Turkish (4)
  { name: "Lahmacun", cuisine: "Turkish", base: "Flatbread", protein: "Lamb", star: "Tomato", fat: "Olive Oil", heat: "Paprika", difficulty: "hard", description: "Turkish thin-crust pizza with spiced lamb." },
  { name: "Iskender Kebab", cuisine: "Turkish", base: "Pita", protein: "Lamb", star: "Tomato", fat: "Butter", heat: "Chili Flakes", difficulty: "medium", description: "Sliced doner on bread with tomato sauce and butter." },
  { name: "Pide", cuisine: "Turkish", base: "Dough", protein: "Beef", star: "Cheese", fat: "Butter", heat: "Black Pepper", difficulty: "medium", description: "Turkish boat-shaped pizza with various fillings." },
  { name: "Manti", cuisine: "Turkish", base: "Dough", protein: "Lamb", star: "Yogurt", fat: "Butter", heat: "Paprika", difficulty: "hard", description: "Turkish dumplings with yogurt and chili butter." },

  # Peruvian (3)
  { name: "Ceviche", cuisine: "Peruvian", base: "None", protein: "Fish", star: "Lime", fat: "None", heat: "Chili", difficulty: "medium", description: "Fresh raw fish cured in citrus juice." },
  { name: "Lomo Saltado", cuisine: "Peruvian", base: "Potato", protein: "Beef", star: "Soy Sauce", fat: "Vegetable Oil", heat: "Chili", difficulty: "hard", description: "Peruvian-Chinese beef stir-fry with fries." },
  { name: "Causa", cuisine: "Peruvian", base: "Potato", protein: "Chicken", star: "Lime", fat: "Olive Oil", heat: "Aji Amarillo", difficulty: "hard", description: "Layered cold potato dish with spicy yellow chili." },

  # Georgian (3)
  { name: "Khachapuri", cuisine: "Georgian", base: "Dough", protein: "Egg", star: "Cheese", fat: "Butter", heat: "None", difficulty: "medium", description: "Georgian cheese-filled bread with runny egg." },
  { name: "Khinkali", cuisine: "Georgian", base: "Dough", protein: "Beef", star: "Broth", fat: "Butter", heat: "Black Pepper", difficulty: "hard", description: "Georgian soup dumplings twisted shut on top." },
  { name: "Lobio", cuisine: "Georgian", base: "Bread", protein: "None", star: "Kidney Beans", fat: "Walnut", heat: "Coriander", difficulty: "medium", description: "Georgian spiced red bean stew." },

  # Polish (3)
  { name: "Pierogi", cuisine: "Polish", base: "Dough", protein: "None", star: "Potato", fat: "Butter", heat: "Onion", difficulty: "easy", description: "Polish filled dumplings — comfort food royalty." },
  { name: "Bigos", cuisine: "Polish", base: "Sauerkraut", protein: "Pork", star: "Cabbage", fat: "Lard", heat: "Bay Leaf", difficulty: "hard", description: "Polish hunter's stew simmered for days." },
  { name: "Zurek", cuisine: "Polish", base: "Bread", protein: "Egg", star: "Sour Rye", fat: "Cream", heat: "Marjoram", difficulty: "hard", description: "Sour rye soup with sausage and egg." },

  # Eastern European (4)
  { name: "Borscht", cuisine: "Ukrainian", base: "Broth", protein: "Beef", star: "Beet", fat: "Sour Cream", heat: "Dill", difficulty: "easy", description: "Vibrant beetroot soup served with sour cream." },
  { name: "Pelmeni", cuisine: "Russian", base: "Dough", protein: "Beef", star: "Sour Cream", fat: "Butter", heat: "Black Pepper", difficulty: "medium", description: "Siberian meat dumplings in sour cream." },
  { name: "Blini", cuisine: "Russian", base: "Flour", protein: "Egg", star: "Sour Cream", fat: "Butter", heat: "Dill", difficulty: "easy", description: "Thin Russian pancakes served with sour cream." },
  { name: "Goulash", cuisine: "Hungarian", base: "Potato", protein: "Beef", star: "Tomato", fat: "Lard", heat: "Paprika", difficulty: "medium", description: "Hungarian beef stew rich with paprika." },

  # Scandinavian (4)
  { name: "Swedish Meatballs", cuisine: "Swedish", base: "Potato", protein: "Beef", star: "Cream", fat: "Butter", heat: "Allspice", difficulty: "easy", description: "Small meatballs in creamy gravy with lingonberry." },
  { name: "Gravlax", cuisine: "Scandinavian", base: "Bread", protein: "Salmon", star: "Dill", fat: "Cream", heat: "Mustard", difficulty: "medium", description: "Cured salmon with dill and mustard sauce." },
  { name: "Smorgasbord", cuisine: "Swedish", base: "Bread", protein: "Herring", star: "Dill", fat: "Butter", heat: "Mustard", difficulty: "medium", description: "Swedish open-faced sandwich with pickled herring." },
  { name: "Kanelbullar", cuisine: "Swedish", base: "Flour", protein: "Egg", star: "Cinnamon", fat: "Butter", heat: "Cardamom", difficulty: "medium", description: "Swedish cinnamon rolls with cardamom." },

  # Southeast Asian (8)
  { name: "Nasi Goreng", cuisine: "Indonesian", base: "Rice", protein: "Egg", star: "Kecap Manis", fat: "Vegetable Oil", heat: "Chili", difficulty: "easy", description: "Indonesian fried rice with sweet soy sauce." },
  { name: "Rendang", cuisine: "Indonesian", base: "Rice", protein: "Beef", star: "Coconut Milk", fat: "Palm Oil", heat: "Chili", difficulty: "hard", description: "Slow-cooked dry beef curry from West Sumatra." },
  { name: "Satay", cuisine: "Indonesian", base: "Rice", protein: "Chicken", star: "Peanuts", fat: "Vegetable Oil", heat: "Chili", difficulty: "easy", description: "Grilled meat skewers with peanut sauce." },
  { name: "Curry Laksa", cuisine: "Malaysian", base: "Noodles", protein: "Shrimp", star: "Coconut Milk", fat: "Palm Oil", heat: "Chili", difficulty: "hard", description: "Malaysian spicy coconut curry noodle soup." },
  { name: "Hainanese Chicken Rice", cuisine: "Singaporean", base: "Rice", protein: "Chicken", star: "Ginger", fat: "Sesame Oil", heat: "Chili", difficulty: "medium", description: "Poached chicken with fragrant rice and chili sauce." },
  { name: "Adobo", cuisine: "Filipino", base: "Rice", protein: "Chicken", star: "Vinegar", fat: "Vegetable Oil", heat: "Garlic", difficulty: "easy", description: "Filipino braised meat in vinegar, soy, and garlic." },
  { name: "Sinigang", cuisine: "Filipino", base: "Rice", protein: "Pork", star: "Tamarind", fat: "None", heat: "Chili", difficulty: "medium", description: "Filipino sour soup with pork and vegetables." },
  { name: "Bun Bo Hue", cuisine: "Vietnamese", base: "Noodles", protein: "Beef", star: "Lemongrass", fat: "Chili Oil", heat: "Chili", difficulty: "hard", description: "Spicy Vietnamese beef noodle soup from Hue." },

  # Pacific / Hawaiian (2)
  { name: "Poke Bowl", cuisine: "Hawaiian", base: "Rice", protein: "Tuna", star: "Soy Sauce", fat: "Sesame Oil", heat: "Scallion", difficulty: "easy", description: "Hawaiian raw fish bowl with rice and toppings." },
  { name: "Loco Moco", cuisine: "Hawaiian", base: "Rice", protein: "Beef", star: "Gravy", fat: "Butter", heat: "Onion", difficulty: "easy", description: "Hawaiian comfort food — rice, burger patty, egg, gravy." },

  # Austrian / German (4)
  { name: "Schnitzel", cuisine: "Austrian", base: "Bread Crumbs", protein: "Veal", star: "Lemon", fat: "Butter", heat: "None", difficulty: "medium", description: "Breaded and fried thin meat cutlet." },
  { name: "Currywurst", cuisine: "German", base: "Bread", protein: "Pork", star: "Ketchup", fat: "Vegetable Oil", heat: "Curry Powder", difficulty: "easy", description: "German fried sausage with curried ketchup." },
  { name: "Pretzel", cuisine: "German", base: "Dough", protein: "None", star: "Sea Salt", fat: "Butter", heat: "Mustard", difficulty: "easy", description: "Twisted Bavarian bread with crunchy salt crust." },
  { name: "Spatzle", cuisine: "German", base: "Flour", protein: "Egg", star: "Cheese", fat: "Butter", heat: "Nutmeg", difficulty: "medium", description: "Swabian egg noodle dumplings with cheese." },

  # Canadian (2)
  { name: "Poutine", cuisine: "Canadian", base: "Potato", protein: "Cheese Curds", star: "Gravy", fat: "Vegetable Oil", heat: "Black Pepper", difficulty: "medium", description: "Fries smothered in gravy and cheese curds." },
  { name: "Tourtiere", cuisine: "Canadian", base: "Pastry", protein: "Pork", star: "Potato", fat: "Lard", heat: "Cinnamon", difficulty: "hard", description: "French-Canadian meat pie with warm spices." },

  # African (5)
  { name: "Jollof Rice", cuisine: "West African", base: "Rice", protein: "Chicken", star: "Tomato", fat: "Palm Oil", heat: "Chili", difficulty: "medium", description: "One-pot tomato rice beloved across West Africa." },
  { name: "Tagine", cuisine: "Moroccan", base: "Couscous", protein: "Lamb", star: "Apricot", fat: "Olive Oil", heat: "Cumin", difficulty: "medium", description: "Slow-cooked Moroccan stew with dried fruit." },
  { name: "Bobotie", cuisine: "South African", base: "Rice", protein: "Beef", star: "Egg", fat: "Butter", heat: "Curry Powder", difficulty: "hard", description: "South African spiced meat pie with egg custard top." },
  { name: "Suya", cuisine: "Nigerian", base: "None", protein: "Beef", star: "Peanuts", fat: "Vegetable Oil", heat: "Cayenne", difficulty: "medium", description: "Nigerian spicy grilled meat skewers." },
  { name: "Koshari", cuisine: "Egyptian", base: "Rice", protein: "Lentils", star: "Tomato", fat: "Vegetable Oil", heat: "Cumin", difficulty: "medium", description: "Egyptian comfort food of rice, lentils, and pasta." },

  # Central Asian (3)
  { name: "Plov", cuisine: "Uzbek", base: "Rice", protein: "Lamb", star: "Carrot", fat: "Vegetable Oil", heat: "Cumin", difficulty: "medium", description: "Uzbek pilaf with lamb, carrots, and cumin." },
  { name: "Lagman", cuisine: "Uzbek", base: "Noodles", protein: "Lamb", star: "Tomato", fat: "Vegetable Oil", heat: "Cumin", difficulty: "hard", description: "Central Asian hand-pulled noodle soup." },
  { name: "Mantu", cuisine: "Afghan", base: "Dough", protein: "Lamb", star: "Yogurt", fat: "Vegetable Oil", heat: "Garlic", difficulty: "hard", description: "Afghan steamed dumplings with meat and yogurt." },

  # Misc International (10)
  { name: "Empanada", cuisine: "Argentine", base: "Dough", protein: "Beef", star: "Olive", fat: "Lard", heat: "Cumin", difficulty: "medium", description: "Argentine baked pastry filled with spiced beef." },
  { name: "Arepa", cuisine: "Venezuelan", base: "Cornmeal", protein: "Cheese", star: "Avocado", fat: "Butter", heat: "None", difficulty: "easy", description: "Cornmeal pocket stuffed with cheese and fillings." },
  { name: "Pupusa", cuisine: "Salvadoran", base: "Cornmeal", protein: "Pork", star: "Cheese", fat: "Lard", heat: "Curtido", difficulty: "medium", description: "Stuffed corn tortilla with cheese and meat." },
  { name: "Coxinha", cuisine: "Brazilian", base: "Flour", protein: "Chicken", star: "Cream Cheese", fat: "Vegetable Oil", heat: "None", difficulty: "medium", description: "Brazilian deep-fried chicken croquette." },
  { name: "Baklava", cuisine: "Turkish", base: "Phyllo", protein: "None", star: "Pistachio", fat: "Butter", heat: "Cinnamon", difficulty: "medium", description: "Layered phyllo pastry with nuts and honey syrup." },
  { name: "Momos", cuisine: "Tibetan", base: "Dough", protein: "Chicken", star: "Soy Sauce", fat: "Sesame Oil", heat: "Chili", difficulty: "medium", description: "Himalayan steamed dumplings with spicy sauce." },
  { name: "Croquetas", cuisine: "Spanish", base: "Flour", protein: "Ham", star: "Bechamel", fat: "Olive Oil", heat: "Nutmeg", difficulty: "medium", description: "Spanish fried bechamel and ham croquettes." },
  { name: "Pierogi Ruskie", cuisine: "Polish", base: "Dough", protein: "None", star: "Cheese", fat: "Butter", heat: "Onion", difficulty: "easy", description: "Polish dumplings filled with potato and cheese." },
  { name: "Bibingka", cuisine: "Filipino", base: "Rice", protein: "Egg", star: "Coconut Milk", fat: "Butter", heat: "None", difficulty: "medium", description: "Filipino coconut rice cake baked in banana leaves." },
  { name: "Fesenjan", cuisine: "Persian", base: "Rice", protein: "Chicken", star: "Pomegranate", fat: "Walnut", heat: "Cinnamon", difficulty: "hard", description: "Persian pomegranate and walnut stew." },
]

names = dishes.map { |d| d[:name] }
dupes = names.select { |n| names.count(n) > 1 }.uniq
raise "Duplicate dish names: #{dupes.join(', ')}" if dupes.any?

puts "Seeding #{dishes.length} dishes..."

dishes.each do |attrs|
  Dish.find_or_create_by!(name: attrs[:name]) do |dish|
    dish.assign_attributes(
      slug: attrs[:name].parameterize,
      cuisine: attrs[:cuisine],
      base: attrs[:base],
      protein: attrs[:protein],
      star: attrs[:star],
      fat: attrs[:fat],
      heat: attrs[:heat],
      description: attrs[:description],
      difficulty: attrs[:difficulty] || "medium"
    )
  end
end

puts "Seeded #{Dish.count} dishes."

start_date = Date.new(2026, 3, 4)
available = Dish.where(used_as_daily: false).order("RANDOM()")
available.each_with_index do |dish, i|
  break if i >= 365
  DailyPuzzle.find_or_create_by!(puzzle_date: start_date + i.days) do |dp|
    dp.dish = dish
    dp.puzzle_number = i + 1
  end
  dish.update!(used_as_daily: true)
end

puts "Assigned #{DailyPuzzle.count} daily puzzles."
