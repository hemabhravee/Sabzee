import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SabzeeUser {
  late User? firebaseUser;
  var addresses = [].obs;
  var defaultAddressIndex = 0.obs;
  var orders = [].obs;
  late var number;
}

class Address {
  late String? line1;
  late String? line2;
  late String? street;
  late String? pincode;
  late String? tag;

  Address({this.line1, this.line2, this.street, this.pincode, this.tag});

  Address.fromJson(Map<String, String> json) {
    line1 = json['line1'];
    line2 = json['line2'];
    street = json['street'];
    pincode = json['pincode'];
    tag = json['tag'];
  }

  Map<String, String?> toJson() {
    final Map<String, String?> data = new Map<String, String>();
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['street'] = this.street;
    data['pincode'] = this.pincode;
    data['tag'] = this.tag;
    return data;
  }
}

class Order {
  late int cost;
  late String date;
  late String paymentStatus;
  late List<OrderItem> items;

  Order({
    required this.cost,
    required this.date,
    required this.paymentStatus,
    required this.items,
  });

  Order.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    date = json['date'];
    paymentStatus = json['paymentStatus'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    data['date'] = this.date;
    data['paymentStatus'] = this.paymentStatus;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  late String itemId;
  late String variantId;
  late int qty;
  late int rate;

  OrderItem({
    required this.itemId,
    required this.variantId,
    required this.qty,
    required this.rate,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    variantId = json['variantId'];
    qty = json['qty'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['variantId'] = this.variantId;
    data['qty'] = this.qty;
    data['rate'] = this.rate;
    return data;
  }
}
