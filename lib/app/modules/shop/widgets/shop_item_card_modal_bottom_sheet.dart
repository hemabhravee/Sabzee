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
      backgroundColor: Colors.transparent,
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
      //color: Colors.black54,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black54,
          Colors.black,
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_downward_rounded,
            color: Colors.grey,
          ),
          // image container
          Container(
            margin: EdgeInsets.only(
              top: Get.height * 0.05,
            ),
            height: Get.height * 0.4,
            child: const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
          ),
          // Item Name
          Text(
            itemController.y.value.name,
            style: Get.textTheme.headline4?.copyWith(
              color: Colors.white,
            ),
          ),
          // Container(
          //   height: Get.height * 0.05,
          //   decoration: BoxDecoration(
          //     color: Get.theme.cardColor,
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Get.theme.primaryColorLight,
          //         offset: Offset(0.0, 0.75), //(x,y)
          //         blurRadius: 1.0,
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text("Variant"),
          //       Text("Rate"),
          //       Text("Quantity"),
          //       Text("Price"),
          //     ],
          //   ),
          // ),
          // Text("Choose one"),
          Container(
            height: Get.height * 0.25,
            margin: EdgeInsets.symmetric(
                // vertical: 10,
                // horizontal: 5,
                ),
            // decoration: BoxDecoration(
            //   // color: Get.theme.cardColor,
            //   borderRadius: BorderRadius.circular(15),
            //   // boxShadow: [
            //   //   BoxShadow(
            //   //     // color: Get.theme.primaryColorLight,
            //   //     offset: Offset(0.0, 1.0), //(x,y)
            //   //     blurRadius: 2.0,
            //   //   ),
            //   //],
            // ),
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

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // color: Colors.amber,
                          width: Get.width * 0.20,
                          child: Center(
                            child: Text(
                              itemController.y.value.variants[index2].name
                                  .toString(),
                              style: Get.textTheme.bodyText1?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //  color: Colors.amber[100],
                          width: Get.width * 0.10,
                          child: Center(
                            child: Text(
                              itemController.y.value.variants[index2].rate
                                  .toString(),
                              style: Get.textTheme.bodyText1?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          //  color: Colors.amber,
                          //width: Get.width * 0.25,
                          child: Row(
                            children: [
                              Obx(() => getMinusOutlinedButton(
                                    isAdd: false,
                                    onPressed: () =>
                                        itemController.onSubtract(index2),
                                    height: Get.height,
                                    qty:
                                        itemController.quantities.value[index2],
                                  )),
                              Obx(
                                () => Container(
                                  width: Get.width * 0.05,
                                  child: Center(
                                    child: Text(
                                      itemController.quantities[index2]
                                          .toString(),
                                      style: Get.textTheme.bodyText1?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              getOutlinedButton(
                                  isAdd: true,
                                  onPressed: () => itemController.onAdd(index2),
                                  height: Get.height),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width * 0.10,
                          //  color: Colors.amber[100],
                          child: Center(
                            child: Obx(() => Text(
                                  (itemController.quantities[index2] *
                                          int.parse(itemController
                                              .y.value.variants[index2].rate))
                                      .toString(),
                                  style: Get.textTheme.bodyText1?.copyWith(
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: Get.height * 0.05,
            // decoration: BoxDecoration(
            //   // color: Get.theme.cardColor,
            //   borderRadius: BorderRadius.circular(15),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Get.theme.primaryColorLight,
            //       offset: Offset(0.0, 1.2), //(x,y)
            //       blurRadius: 3.0,
            //     ),
            //   ],
            // ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Cost",
                    style: Get.textTheme.bodyText1?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Obx(() => Text(
                        itemController.cost.value.toString(),
                        style: Get.textTheme.bodyText1?.copyWith(
                          color: Colors.white,
                        ),
                      )),
                ]),
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              // borderRadius: BorderRadius.circular(15),
              // boxShadow: [
              //   BoxShadow(
              //     color: Get.theme.primaryColorLight,
              //     offset: Offset(0.0, 1.0), //(x,y)
              //     blurRadius: 2.0,
              //   ),
              // ],
            ),
            child: TextButton(
              onPressed: () {
                itemController.onSubmit();
                // Get.back();
              },
              child: Text(
                itemController.isItemNew ? "Add to Cart" : "Update Cart",
                style: Get.textTheme.button?.copyWith(
                  color: Get.theme.backgroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
