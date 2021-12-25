import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class ItemPageView extends GetView<ItemPageController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ItemPageController());
    var shopController = Get.find<ShopController>();
    var homeController = Get.find<HomeController>();

    return Container(
      // height: Get.height,
      width: Get.width * 0.9,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          ),
          Text(controller.y.value.name,
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
                itemCount: controller.y.value.variants.length,
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
                        Text(controller.y.value.variants[index2].name
                            .toString()),
                        Text(controller.y.value.variants[index2].rate
                            .toString()),
                        OutlinedButton(
                          child: Container(
                              // color: Colors.red,
                              height: Get.height * 0.03,
                              child: Center(child: Icon(Icons.remove))),
                          onPressed: () => controller.onSubtract(index2),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder(
                                // borderRadius:
                                //     BorderRadius.circular(
                                //         50.0),
                                )),
                          ),
                        ),
                        Obx(
                          () => Text(controller.quantities[index2].toString()),
                        ),
                        OutlinedButton(
                          // +
                          child: Container(
                              // color: Colors.red,
                              height: Get.height * 0.03,
                              child: Center(child: Icon(Icons.add))),
                          onPressed: () => controller.onAdd(index2),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder(
                                // borderRadius:
                                //     BorderRadius.circular(
                                //         50.0),
                                )),
                          ),
                        ),
                        Obx(() => Text((controller.quantities[index2] *
                                int.parse(
                                    controller.y.value.variants[index2].rate))
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
                  Obx(() => Text(controller.cost.value.toString())),
                ]),
          ),
          TextButton(
            onPressed: controller.onSubmit,
            child: Text(controller.isItemNew ? "Add to Cart" : "Update Cart"),
          )
        ],
      ),
    );
  }
}
