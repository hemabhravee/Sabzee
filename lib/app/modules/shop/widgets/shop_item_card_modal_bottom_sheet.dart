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
        Rx<MenuItem> y = MenuItem(name: "name", variants: []).obs;

        print("qty =" +
            shopController.mappedItems.value[index].variants[0].qty.toString());

        y.value.variants = shopController.mappedItems.value[index].variants
            .map((e) => Variant(name: e.name, rate: e.rate, qty: e.qty))
            .toList();

        y.value.name = shopController.mappedItems.value[index].name;

        Rx<int> cost = 0.obs;
        y.value.variants.forEach((element) {
          cost.value += element.qty * int.parse(element.rate);
        });
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
                                if (y.value.variants[index2].qty > 0) {
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
                              () =>
                                  Text(y.value.variants[index2].qty.toString()),
                            ),
                            OutlinedButton(
                              // +
                              child: Container(
                                  // color: Colors.red,
                                  height: Get.height * 0.03,
                                  child: Center(child: Icon(Icons.add))),
                              onPressed: () {
                                print("onpressed");
                                print("old = " +
                                    y.value.variants[index2].qty.toString());

                                y.value.variants[index2].qty++;
                                cost.value +=
                                    int.parse(y.value.variants[index2].rate);

                                y.refresh();

                                print("new = " +
                                    y.value.variants[index2].qty.toString());
                                print("original = " +
                                    shopController
                                        .mappedItems[index].variants[index2].qty
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
                            Obx(() => Text((y.value.variants[index2].qty *
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
                    homeController.cart.value.items
                        .add({'item': y.value, 'cost': cost});

                    y.value.variants.forEachIndexed((index, value) {
                      shopController.mappedItems[index].variants[index].qty =
                          value.qty;
                    });
                  }
                  Navigator.pop(context);
                  print(homeController.cart.value.items);
                  homeController.cart.refresh();
                },
                child: Text("Add to Cart"),
              )
            ],
          ),
        );
      });
}
