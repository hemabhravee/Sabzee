import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/common/widgets.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  late RxList<String> item_ids = <String>[].obs,
      variant_ids = <String>[].obs,
      item_names = <String>[].obs,
      variant_names = <String>[].obs,
      variant_rates = <String>[].obs;
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    var homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('CartView'),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          color: Colors.grey[700],
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Obx(() => ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: homeController.cart.value.items.length,
                      itemBuilder: (context, index) {
                        // item_id     variant_id
                        // item_name  variant_name  variant_rate
                        item_ids.add("");
                        variant_ids.add("");
                        item_names.add("");
                        variant_names.add("");
                        variant_rates.add("");

                        Future<String> getCartItems =
                            Future.delayed(Duration(seconds: 0), () {
                          var x = homeController.cart.value.items[index].uid
                              .split("-");
                          item_ids[index] = x[0];
                          variant_ids[index] = x[1];
                          homeController.mappedItems.value.forEach((curItem) {
                            if (curItem.id == item_ids[index]) {
                              item_names[index] = curItem.name;
                              curItem.variants.forEach((variant) {
                                if (variant.id == variant_ids[index]) {
                                  variant_names[index] = variant.name;
                                  variant_rates[index] = variant.rate;
                                }
                              });
                            }
                          });
                          return "Cart Items Loaded!";
                        });

                        subtractOnPressed() {
                          homeController.updateItemQuantity(
                              qty: homeController.cart.value.items[index].qty -
                                  1,
                              uid: homeController.cart.value.items[index].uid);
                          homeController.cart.refresh();
                        }

                        addOnPressed() {
                          homeController.updateItemQuantity(
                              qty: homeController.cart.value.items[index].qty +
                                  1,
                              uid: homeController.cart.value.items[index].uid);
                          homeController.cart.refresh();
                        }

                        return FutureBuilder<String>(
                            future: getCartItems,
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? Container(
                                      height: Get.height * 0.05,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(item_names[index]),
                                          Text(variant_names[index]),
                                          Text(variant_rates[index]),
                                          getOutlinedButton(
                                              isAdd: false,
                                              onPressed: subtractOnPressed,
                                              height: Get.height),
                                          Text(homeController
                                              .cart.value.items[index].qty
                                              .toString()),
                                          getOutlinedButton(
                                              isAdd: true,
                                              onPressed: addOnPressed,
                                              height: Get.height),
                                          Text((homeController.cart.value
                                                      .items[index].qty *
                                                  int.parse(
                                                      variant_rates[index]))
                                              .toString()),
                                        ],
                                      ),
                                    )
                                  : CircularProgressIndicator();
                            });
                      })),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: Get.height * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Total Cost"),
                    Obx(() =>
                        Text(homeController.cart.value.amount.toString())),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
