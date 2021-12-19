class MenuItem {
  late String name;
  late List<String> variants;
  late List<int> prices;

  MenuItem({required this.name, required this.variants, required this.prices});

  MenuItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    variants = json['variants'].cast<String>();
    prices = json['prices'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['variants'] = this.variants;
    data['prices'] = this.prices;
    return data;
  }
}

const items = [
  {
    "name": "BitterGourd",
    "variants": ["250 gm", "500 gm", "1kg"],
    "prices": [50, 85, 150]
  },
  {
    "name": "Lauki",
    "variants": ["250 gm", "500 gm", "1kg"],
    "prices": [60, 110, 200]
  },
  {
    "name": "Onion",
    "variants": ["500 gm", "1kg", "2kg"],
    "prices": [25, 45, 85]
  },
  {
    "name": "Dhaniya",
    "variants": ["100 gm", "200 gm", "500gm"],
    "prices": [15, 25, 50]
  },
  {
    "name": "Tomato",
    "variants": ["500 gm", "1kg"],
    "prices": [35, 60]
  },
];
