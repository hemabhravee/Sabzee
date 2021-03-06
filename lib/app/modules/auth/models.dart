import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class SabzeeUser {
  // recieved on auth
  late User? firebaseUser;

  // recieved after auth
  late String number;
  RxList<Address> addresses = <Address>[].obs;
  RxInt defaultAddressIndex = 0.obs;
  RxList<String> orderIds = <String>[].obs;
  RxList<String> paymentMethods = ['online'].obs;

  // recieved when user goes to OrderView()
  RxList<Order> orders = <Order>[].obs;

  getUserData(var jsonMap) {
    number = jsonMap['number'];

    addresses.value = List<Address>.from(
        jsonMap['addresses'].map((address) => Address.fromJson(address)));

    defaultAddressIndex.value = jsonMap['defaultAddressIndex'];

    orderIds.value =
        List<String>.from(jsonMap['orders'].map((order) => order['orderId']));

    paymentMethods.value = List<String>.from(
        jsonMap['paymentMethods'].map((paymentMethod) => paymentMethod));
  }

  int getAddressIndexFromTag(String tag) {
    int index = -1;
    for (int i = 0; i < addresses.length; i++)
      if (addresses[i].tag == tag) index = i;

    return index;
  }
}

class Address {
  late String line1;
  late String line2;
  late String street;
  late String city;
  late String pincode;
  late String tag;

  Address(
      {required this.line1,
      required this.line2,
      required this.street,
      this.city = "Ranchi",
      required this.pincode,
      required this.tag});

  Address.fromJson(var json) {
    line1 = json['line1']!;
    line2 = json['line2'] ?? "";
    street = json['street']!;
    pincode = json['pincode'] ?? "";
    tag = json['tag']!;
    city = json['city'] ?? "Ranchi";
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['street'] = this.street;
    data['pincode'] = this.pincode;
    data['tag'] = this.tag;
    data['city'] = this.city;
    return data;
  }

  toString() =>
      line1 + '\n' + line2 + '\n' + street + '\n' + city + '-' + pincode;
}

enum PaymentStatus { paid, unpaid }
enum PaymentMethod { cod, online }

class Order {
  late Cart cart;
  late String deliveryDate;
  late String orderDate;
  late PaymentStatus paymentStatus;
  late PaymentMethod paymentMethod;
  late Address deliveryAddress;
  late bool delivered;
  late bool cancelled;

  Order({
    required this.cart,
    required this.deliveryDate,
    required this.orderDate,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.delivered,
    required this.cancelled,
  });

  Order.fromJson(var json) {
    print("Order.fromJson begin");
    print(json);
    deliveryDate = json['deliveryDate'];
    orderDate = json['orderDate'];
    if (json['paymentStatus'] == 'paid')
      paymentStatus = PaymentStatus.paid;
    else if (json['paymentStatus'] == 'unpaid')
      paymentStatus = PaymentStatus.unpaid;

    paymentMethod = json['paymentMethod'] == "cod"
        ? PaymentMethod.cod
        : PaymentMethod.online;

    deliveryAddress = Address.fromJson(json['deliveryAddress']);
    cart = Cart.fromJson(json['cart']);
    print("Doubt");
    print(json['delivered'].runtimeType);
    print(json['delivered']);
    delivered = json['delivered'];
    cancelled = json['cancelled'];
    print("Order.fromJson end");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryDate'] = this.deliveryDate;
    data['orderDate'] = this.orderDate;
    data['paymentStatus'] = this.paymentStatus.toString().split('.')[1];
    data['paymentMethod'] = this.paymentMethod.toString().split('.')[1];
    data['deliveryAddress'] = this.deliveryAddress.toJson();
    data['cart'] = this.cart.toJson();
    data['delivered'] = this.delivered;
    data['cancelled'] = this.cancelled;
    return data;
  }
}
