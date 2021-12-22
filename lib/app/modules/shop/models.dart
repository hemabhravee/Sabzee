// class SelectedItem {
//   late String name;
//   late List<Selection> selections;

//   SelectedItem({required this.name, required this.selections});
// }

import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';

class MenuItem {
  late String name;
  late List<Variant> variants;
  late String id;

  MenuItem({required this.name, required this.variants, required this.id});

  MenuItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
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
    return data;
  }
}

const items = [
  {
    "name": "BitterGourd",
    "id": "BTG",
    "variants": [
      {"name": "250 gm", "rate": "50", "id": "weight1"},
      {"name": "500 gm", "rate": "85", "id": "weight2"},
      {"name": "1kg", "rate": "150", "id": "weight3"}
    ],
  },
  {
    "name": "Potatoes",
    "id": "PTT",
    "variants": [
      {"name": "250 gm", "rate": "10", "id": "weight1"},
      {"name": "500 gm", "rate": "18", "id": "weight2"},
      {"name": "1kg", "rate": "35", "id": "weight3"}
    ],
  },
  {
    "name": "Tamatoes",
    "id": "TMT",
    "variants": [
      {"name": "250 gm", "rate": "25", "id": "weight1"},
      {"name": "500 gm", "rate": "45", "id": "weight2"},
      {"name": "1kg", "rate": "85", "id": "weight3"}
    ],
  },
  {
    "name": "Green Chilly",
    "id": "GC",
    "variants": [
      {"name": "250 gm", "rate": "20", "id": "weight1"},
      {"name": "500 gm", "rate": "35", "id": "weight2"},
      {"name": "1kg", "rate": "65", "id": "weight3"}
    ],
  },
];

class Cart {
  late int amount;
  late List<CartItem> items;

  Cart({required this.items, required this.amount});
}

class CartItem {
  late int qty;
  late String uid;

  CartItem({required this.uid, required this.qty});
}

int getQuantityFromUid(String itemId, String variantId) {
  var homeController = Get.find<HomeController>();
  int qty = 0;

  print("finding " + itemId + "-" + variantId + "  in cart");
  homeController.cart.value.items.forEach((element) {
    print("matching against " + element.uid);
    if (element.uid == itemId + "-" + variantId) qty = element.qty;
  });
  print("qty = " + qty.toString());
  return qty;
}

bool itemExistsInCart(String itemId, String variantId) {
  return getQuantityFromUid(itemId, variantId) != 0;
}
