// class SelectedItem {
//   late String name;
//   late List<Selection> selections;

//   SelectedItem({required this.name, required this.selections});
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';

class MenuItem {
  late String name;
  late List<Variant> variants;
  late String id;
  late String category;

  MenuItem({required this.name, required this.variants, required this.id});

  MenuItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    category = json['category'];
    //print("MenuItem.fromJson called");
    if (json['variants'] != null) {
      //print("variants are not null, adding");
      variants = <Variant>[];
      json['variants'].forEach((v) {
        //print("calling variant.fromJson");
        variants.add(new Variant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['variants'] = this.variants;
    data['id'] = this.id;
    data['category'] = this.category;
    return data;
  }
}

class Variant {
  late String name;
  late String rate;
  // late int qty;
  late String id;

  Variant({required this.name, required this.rate, required this.id});

  Variant.fromJson(Map<String, dynamic> json) {
    //print("variants.fromJson called");

    name = json['name'];
    rate = json['rate'];
    id = json['id'];

    //print("variants.fromJson called");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['id'] = this.id;
    return data;
  }
}

const items = [
  {
    "name": "BitterGourd",
    "id": "BTG",
    "category": "Vegetables",
    "variants": [
      {"name": "250 gm", "rate": "50", "id": "weight1"},
      {"name": "500 gm", "rate": "85", "id": "weight2"},
      {"name": "1kg", "rate": "150", "id": "weight3"}
    ],
  },
  {
    "name": "Potatoes",
    "id": "PTT",
    "category": "Vegetables",
    "variants": [
      {"name": "250 gm", "rate": "10", "id": "weight1"},
      {"name": "500 gm", "rate": "18", "id": "weight2"},
      {"name": "1kg", "rate": "35", "id": "weight3"}
    ],
  },
  {
    "name": "Tomatoes",
    "id": "TMT",
    "category": "Vegetables",
    "variants": [
      {"name": "250 gm", "rate": "25", "id": "weight1"},
      {"name": "500 gm", "rate": "45", "id": "weight2"},
      {"name": "1kg", "rate": "85", "id": "weight3"}
    ],
  },
  {
    "name": "Green Chilly",
    "id": "GC",
    "category": "Vegetables",
    "variants": [
      {"name": "250 gm", "rate": "20", "id": "weight1"},
      {"name": "500 gm", "rate": "35", "id": "weight2"},
      {"name": "1kg", "rate": "65", "id": "weight3"}
    ],
  },
  {
    "name": "Red Chilly",
    "id": "RC",
    "category": "Vegetables",
    "variants": [
      {"name": "250 gm", "rate": "30", "id": "weight1"},
      {"name": "500 gm", "rate": "55", "id": "weight2"},
      {"name": "1kg", "rate": "100", "id": "weight3"}
    ],
  },
  {
    "name": "Onions",
    "id": "ONI",
    "category": "Vegetables",
    "variants": [
      {"name": "250 gm", "rate": "10", "id": "weight1"},
      {"name": "500 gm", "rate": "18", "id": "weight2"},
      {"name": "1kg", "rate": "35", "id": "weight3"}
    ],
  },
  {
    "name": "Paneer",
    "id": "PAN",
    "category": "Dairy",
    "variants": [
      {"name": "200 gm", "rate": "80", "id": "weight1"},
      {"name": "500 gm", "rate": "225", "id": "weight2"},
      {"name": "1kg", "rate": "400", "id": "weight3"}
    ],
  },
  {
    "name": "Kesar Gehu Ata",
    "id": "KGA",
    "category": "Flour",
    "variants": [
      {"name": "250 gm", "rate": "140", "id": "weight1"},
      {"name": "500 gm", "rate": "260", "id": "weight2"},
      {"name": "1kg", "rate": "500", "id": "weight3"}
    ],
  },
  {
    "name": "Apple",
    "id": "APP",
    "category": "Fruits",
    "variants": [
      {"name": "250 gm", "rate": "35", "id": "weight1"},
      {"name": "500 gm", "rate": "65", "id": "weight2"},
      {"name": "1kg", "rate": "120", "id": "weight3"}
    ],
  },
  {
    "name": "Kiwi",
    "id": "KW",
    "category": "Fruits",
    "variants": [
      {"name": "250 gm", "rate": "35", "id": "weight1"},
      {"name": "500 gm", "rate": "65", "id": "weight2"},
      {"name": "1kg", "rate": "120", "id": "weight3"}
    ],
  },
  {
    "name": "Musk Melon",
    "id": "MM",
    "category": "Fruits",
    "variants": [
      {"name": "250 gm", "rate": "35", "id": "weight1"},
      {"name": "500 gm", "rate": "65", "id": "weight2"},
      {"name": "1kg", "rate": "120", "id": "weight3"}
    ],
  },
];

class Cart {
  late int amount;
  late List<CartItem> items;

  Cart({required this.items, required this.amount});
  // deleteItemByUid(String uid) {
  //   late int index;
  //   for (int i = 0; i < items.length; i++) {
  //     if (uid == items[i].uid) index = i;
  //   }
  //   items.removeAt(index);
  // }

   Cart.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }

  deleteItemById(String itemId, String variantId) {
    late int index;
    for (int i = 0; i < items.length; i++) {
      if (itemId == items[i].itemId && variantId == items[i].variantId)
        index = i;
    }
    items.removeAt(index);
  }
}

class CartItem {
  late int qty;
  late String itemId;
  late String variantId;
  late String rate;

  CartItem({required this.itemId, required this.qty, required this.variantId, required this.rate});

  CartItem.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    itemId = json['itemId'];
    variantId = json['variantId'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['itemId'] = this.itemId;
    data['variantId'] = this.variantId;
    data['rate'] = this.rate;
    return data;
  }


}

int getQuantityFromUid(String itemId, String variantId) {
  var homeController = Get.find<HomeController>();
  int qty = 0;

  // ("finding " + itemId + "-" + variantId + "  in cart");
  homeController.cart.value.items.forEach((element) {
    // print("matching against " + element.uid);
    if (element.itemId == itemId && element.variantId == variantId)
      qty = element.qty;
  });
  // print("qty = " + qty.toString());
  return qty;
}

bool itemExistsInCart(String itemId, String variantId) {
  return getQuantityFromUid(itemId, variantId) != 0;
}

int findItemIndexFromId(String id) {
  var homeController = Get.find<HomeController>();
  for (int i = 0; i < homeController.mappedItems.length; i++) {
    if (homeController.mappedItems[i].id == id) return i;
  }
  return -1;
}
