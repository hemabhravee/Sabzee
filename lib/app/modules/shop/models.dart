class SelectedItem {
  late String name;
  late List<Selection> selections;

  SelectedItem({required this.name, required this.selections});
}

class MenuItem {
  late String name;
  late List<Variant> variants;

  MenuItem({required this.name, required this.variants});

  MenuItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    print(json['variants']);
    if (json['variants'] != null) {
      variants = <Variant>[];
      json['variants'].forEach((v) {
        variants.add(new Variant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['variants'] = this.variants;
    return data;
  }
}

class Selection {
  late String name;
  late String rate;
  late int qty;

  Selection({required this.name, required this.rate, required this.qty});
  Selection.fromVariant({required Variant variant}) {
    this.name = variant.name;
    this.rate = variant.rate;
    this.qty = 0;
  }
}

class Variant {
  late String name;
  late String rate;

  Variant({required this.name, required this.rate});

  Variant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    return data;
  }
}

const items = [
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
  {
    "name": "BitterGourd",
    "variants": [
      {"name": "250 gm", "rate": "50"},
      {"name": "500 gm", "rate": "85"},
      {"name": "1kg", "rate": "150"}
    ],
  },
];

getSelectedItemFromMenuItem(MenuItem menuItem) {
  List<Selection> selections = [];
  menuItem.variants.forEach((element) {
    selections.add(Selection.fromVariant(variant: element));
  });
  return new SelectedItem(
    name: menuItem.name,
    selections: selections,
  );
}

class Cart {
  late List<SelectedItem> items;
  late int amount;

  Cart({required this.items, required this.amount});
}
