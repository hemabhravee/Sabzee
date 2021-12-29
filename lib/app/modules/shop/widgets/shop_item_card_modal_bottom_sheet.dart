import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/common/widgets.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';
import 'package:collection/collection.dart';

customModalBottomSheet(BuildContext context, String item_ID) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 20,
      builder: (BuildContext context) => ModalBottomSheet(
            item_ID: item_ID,
          ));
}

class ModalBottomSheet extends StatefulWidget {
  late String item_ID;
  ModalBottomSheet({Key? key, required this.item_ID}) : super(key: key);

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  void dispose() {
    Get.delete<ItemPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.create(() => ItemPageController(), permanent: false);
    var itemController = Get.find<ItemPageController>();
    itemController.setIndex(findItemIndexFromId(widget.item_ID));
    itemController.initFunc();
    var homeController = Get.find<HomeController>();

    return Container(
      height: Get.height,
      width: Get.width * 0.9,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Get.height * 0.4,
            child: const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
          ),
          Text(itemController.y.value.name,
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
                itemCount: itemController.y.value.variants.length,
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
                        Text(itemController.y.value.variants[index2].name
                            .toString()),
                        Text(itemController.y.value.variants[index2].rate
                            .toString()),
                        getOutlinedButton(
                            isAdd: false,
                            onPressed: () => itemController.onSubtract(index2),
                            height: Get.height),
                        Obx(
                          () => Text(
                              itemController.quantities[index2].toString()),
                        ),
                        getOutlinedButton(
                            isAdd: true,
                            onPressed: () => itemController.onAdd(index2),
                            height: Get.height),
                        Obx(() => Text((itemController.quantities[index2] *
                                int.parse(itemController
                                    .y.value.variants[index2].rate))
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
                  Obx(() => Text(itemController.cost.value.toString())),
                ]),
          ),
          TextButton(
            onPressed: () {
              itemController.onSubmit();
              // Get.back();
            },
            child:
                Text(itemController.isItemNew ? "Add to Cart" : "Update Cart"),
          )
        ],
      ),
    );
    ;
  }
}
