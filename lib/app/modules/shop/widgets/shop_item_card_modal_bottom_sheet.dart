import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';

customModalBottomSheet(BuildContext context, int index) {
  var shopController = Get.find<ShopController>();
  // var homeController = Get.find<HomeController>();

  SelectedItem x =
      getSelectedItemFromMenuItem(shopController.mappedItems.elementAt(index));

  Rx<SelectedItem> currentItem = x.obs;

  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: Get.height * 0.7,
          width: Get.width * 0.9,
          color: Colors.amber,
          child: Column(
            children: [
              const Image(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              ),
              Text(shopController.mappedItems.elementAt(index).name),
              // Text("Choose one"),
              Expanded(
                child: Container(
                  // height: Get.height * 0.2,
                  margin: EdgeInsets.symmetric(
                      // vertical: 10,
                      // horizontal: 5,
                      ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: ListView.builder(
                      itemCount: shopController.mappedItems
                          .elementAt(index)
                          .variants
                          .length,
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
                              Text(shopController.mappedItems
                                  .elementAt(index)
                                  .variants[index2]
                                  .name
                                  .toString()),
                              Text(shopController.mappedItems
                                  .elementAt(index)
                                  .variants[index2]
                                  .rate
                                  .toString()),
                              OutlinedButton(
                                child: Container(
                                    // color: Colors.red,
                                    height: Get.height * 0.03,
                                    child: Center(child: Icon(Icons.remove))),
                                onPressed: () {
                                  if (currentItem.value.selections[index2].qty >
                                      0) {
                                    currentItem.value.selections[index2].qty--;
                                    currentItem.refresh();
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
                              Obx(() => Text(currentItem
                                  .value.selections[index2].qty
                                  .toString())),
                              OutlinedButton(
                                child: Container(
                                    // color: Colors.red,
                                    height: Get.height * 0.03,
                                    child: Center(child: Icon(Icons.add))),
                                onPressed: () {
                                  print("old = " +
                                      currentItem.value.selections[index2].qty
                                          .toString());
                                  currentItem.value.selections[index2].qty++;
                                  print("new = " +
                                      currentItem.value.selections[index2].qty
                                          .toString());
                                  currentItem.refresh();
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(CircleBorder(
                                      // borderRadius:
                                      //     BorderRadius.circular(
                                      //         50.0),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              TextButton(
                onPressed: () {
                  // homeController.cart.value.items.add(value)
                  Navigator.pop(context);
                },
                child: Text("Add to Cart"),
              )
            ],
          ),
        );
      });
}
