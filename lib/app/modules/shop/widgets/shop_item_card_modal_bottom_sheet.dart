import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';
import 'package:collection/collection.dart';

customModalBottomSheet(BuildContext context, int index) {
  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        var shopController = Get.find<ShopController>();
        var homeController = Get.find<HomeController>();
        Rx<MenuItem> y = MenuItem(
                name: "name",
                variants: [],
                id: homeController.mappedItems.value[index].id)
            .obs;
        RxList<int> quantities = <int>[].obs;

        y.value.variants = homeController.mappedItems.value[index].variants
            .map((e) => Variant(name: e.name, rate: e.rate, id: e.id))
            .toList();
        y.value.variants.forEachIndexed((i, element) {
          quantities.add(getQuantityFromUid(
              homeController.mappedItems.value[index].id,
              y.value.variants[i].id));
        });

        y.value.name = homeController.mappedItems.value[index].name;

        Rx<int> cost = 0.obs;
        y.value.variants.forEachIndexed((i, element) {
          cost.value += quantities[i] * int.parse(element.rate);
        });
        bool isItemNew = cost == 0;
        // for (int i = 0; i < 5; i++) {
        //   print('incrementing');
        //   y.value.variants[0].qty++;
        //   print(shopController.mappedItems
        //           .elementAt(index)
        //           .variants[0]
        //           .qty
        //           .toString() +
        //       " " +
        //       y.value.variants[0].qty.toString());
        // }

        return Container(
          // height: Get.height * 0.7,
          width: Get.width * 0.9,
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              ),
              Text(y.value.name,
                  style: TextStyle(
                    fontSize: 36,
                  )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Variant"),
                    Text("Rate"),
                    Text("Quantity"),
                    Text("Price"),
                  ],
                ),
              ),
              // Text("Choose one"),
              Container(
                height: Get.height * 0.25,
                margin: EdgeInsets.symmetric(
                    // vertical: 10,
                    // horizontal: 5,
                    ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: ListView.builder(
                    itemCount: y.value.variants.length,
                    itemBuilder: (BuildContext context, int index2) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        // width: Get.width * 0.5,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(y.value.variants[index2].name.toString()),
                            Text(y.value.variants[index2].rate.toString()),
                            OutlinedButton(
                              child: Container(
                                  // color: Colors.red,
                                  height: Get.height * 0.03,
                                  child: Center(child: Icon(Icons.remove))),
                              onPressed: () {
                                if (quantities[index2] > 0) {
                                  // y.value.refresh();

                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(CircleBorder(
                                    // borderRadius:
                                    //     BorderRadius.circular(
                                    //         50.0),
                                    )),
                              ),
                            ),
                            Obx(
                              () => Text(quantities[index2].toString()),
                            ),
                            OutlinedButton(
                              // +
                              child: Container(
                                  // color: Colors.red,
                                  height: Get.height * 0.03,
                                  child: Center(child: Icon(Icons.add))),
                              onPressed: () {
                                print("onpressed");
                                print("old = " + quantities[index2].toString());

                                quantities[index2]++;
                                cost.value +=
                                    int.parse(y.value.variants[index2].rate);

                                y.refresh();

                                print("new = " + quantities[index2].toString());
                                print("original = " +
                                    getQuantityFromUid(y.value.id,
                                            y.value.variants[index2].id)
                                        .toString());
                                print("cost = " + cost.value.toString());
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(CircleBorder(
                                    // borderRadius:
                                    //     BorderRadius.circular(
                                    //         50.0),
                                    )),
                              ),
                            ),
                            Obx(() => Text((quantities[index2] *
                                    int.parse(y.value.variants[index2].rate))
                                .toString())),
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Total Cost"),
                      Obx(() => Text(cost.value.toString())),
                    ]),
              ),
              TextButton(
                onPressed: () {
                  if (cost.value > 0) {
                    // homeController.cart.value.items
                    //     .add(CartItem(uid: y.value, qty: qty));

                    y.value.variants.forEachIndexed((i, value) {
                      if (quantities[i] > 0) {
                        itemExistsInCart(
                                homeController.mappedItems[index].id, value.id)
                            ? homeController.cart.value.items
                                .forEach((element) {
                                if (element.uid == y.value.id + "-" + value.id)
                                  element.qty = quantities[i];
                              })
                            : homeController.cart.value.items.add(CartItem(
                                uid: homeController.mappedItems[index].id +
                                    "-" +
                                    value.id,
                                qty: quantities[i]));
                      }
                    });

                    // y.value.variants.forEachIndexed((index, value) {
                    //   shopController.mappedItems[index].variants[index].qty =
                    //       value.qty;
                    // });
                  }
                  Navigator.pop(context);
                  print(homeController.cart.value.items);
                  homeController.cart.refresh();
                },
                child: Text(isItemNew ? "Add to Cart" : "Update Cart"),
              )
            ],
          ),
        );
      });
}
