import 'dart:convert';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';

class OrdersController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  var apiProvider = ApiProvider();
  var authController = Get.find<AuthController>();

  Future<List<Order>> getOrders() async {
    List<Order> orderList = <Order>[];
    String token = await authController.sabzeeUser.firebaseUser!.getIdToken();
    print("get orders requesting");
    Response resp = await apiProvider.getOrders(token);
    print("completed");
    print("body");
    print(resp.body.runtimeType);
    print(resp.body);

    print("body['orders']");
    print(resp.body['orders'].runtimeType);
    print(resp.body['orders']);

    // for (var order in resp.body) {
    //   print("order");
    //   print(order);
    //   print((order as Map<String, dynamic>).runtimeType);
    // }

    for (var element in resp.body['orders']) {
      // Map<String, dynamic> orderMap = {};

      // var x =
      //     (json.decode(json.encode(element)) as Map).cast<String, dynamic>();
      // x.forEach((key, value) {
      //   orderMap[key] = value;
      // });
      print("adding order to local state var");
      orderList.add(Order.fromJson(element));
    }

    print(resp.statusCode);
    orders.value = orderList;
    print(orders.value);
    return orderList;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
