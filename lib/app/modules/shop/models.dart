class MenuItem {
  late String name;
  late List<dynamic> variants;

  MenuItem({required this.name, required this.variants});

  MenuItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    variants = json['variants'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['variants'] = this.variants;
    return data;
  }
}

const items = [
  {
    "name": "BitterGourd",
    "variants": ["250 gm", "50", "500 gm", "85", "1kg", "150"],
  },
  {
    "name": "Lauki",
    "variants": ["250 gm", "60", "500 gm", "110", "1kg", "200"],
  },
  {
    "name": "Onion",
    "variants": ["500 gm", "25", "1kg", "45", "2kg", "85"],
  },
  {
    "name": "Dhaniya",
    "variants": ["100 gm", 15, "200 gm", 25, "500gm", 50],
  },
  {
    "name": "Tomato",
    "variants": ["500 gm", 35, "1kg", 60],
  },
];
