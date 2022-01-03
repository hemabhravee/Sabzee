import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class SabzeeUser {
  late User? firebaseUser;
  RxList<Address> addresses = <Address>[].obs;
  RxInt defaultAddressIndex = 0.obs;
  RxList<Order> orders = <Order>[].obs;
  RxList<String> orderIds = <String>[].obs;
  late String number;
  RxList<String> paymentMethods = ['online'].obs;

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
    print("working??");
    line1 = json['line1']!;
    line2 = json['line2']!;
    street = json['street']!;
    pincode = json['pincode']!;
    tag = json['tag']!;
    city = json['city']!;
    print("yeah bitch");
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
}

enum PaymentStatus { paid, unpaid, cancelled }
enum PaymentMethod { cod, online }

class Order {
  late Cart cart;
  late String deliveryDate;
  late String orderDate;
  late PaymentStatus paymentStatus;
  late PaymentMethod paymentMethod;
  late Address deliveryAddress;

  Order({
    required this.cart,
    required this.deliveryDate,
    required this.orderDate,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.deliveryAddress,
  });

  Order.fromJson(var json) {
    deliveryDate = json['deliveryDate'];
    orderDate = json['orderDate'];
    if (json['paymentStatus'] == 'paid')
      paymentStatus = PaymentStatus.paid;
    else if (json['paymentStatus'] == 'unpaid')
      paymentStatus = PaymentStatus.unpaid;
    else if (json['paymentStatus'] == 'cancelled')
      paymentStatus = PaymentStatus.cancelled;

    paymentMethod = json['paymentMethod'] == "cod"
        ? PaymentMethod.cod
        : PaymentMethod.online;
    Map<String, String> adrs = {};
    adrs['line1'] = json['deliveryAddress']['line1'];
    print("working so far");
    deliveryAddress = Address.fromJson(json['deliveryAddress']);
    print("working again?");
    cart = Cart.fromJson(json['cart']);
    print("Yasssssssssss");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryDate'] = this.deliveryDate;
    data['orderDate'] = this.orderDate;
    data['paymentStatus'] = this.paymentStatus.toString().split('.')[1];
    data['paymentMethod'] = this.paymentMethod.toString().split('.')[1];
    data['deliveryAddress'] = this.deliveryAddress.toJson();
    data['cart'] = this.cart.toJson();
    return data;
  }
}
