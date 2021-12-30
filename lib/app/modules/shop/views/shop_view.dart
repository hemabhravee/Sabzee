import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/orders/views/orders_view.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/widgets/shop_item_card_modal_bottom_sheet.dart';

import '../controllers/shop_controller.dart';
import 'dart:ui' as ui;

import 'package:sabzee/app/modules/shop/models.dart';

class ShopView extends GetView<ShopController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ShopController());
    var homeController = Get.find<HomeController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Obx(() => controller.isSearching.value
      //       ? controller.searchField.value
      //       : controller.appBarTitle.value),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     new IconButton(
      //         onPressed: () {
      //           print("Search Button Pressed");
      //           if (controller.actionIcon.value.icon == Icons.search) {
      //             print("Search Button Pressed");
      //             controller.actionIcon.value =
      //                 new Icon(Icons.close, color: Colors.white);
      //             controller.isSearching.value = true;
      //           } else {
      //             controller.isSearching.value = false;
      //             controller.actionIcon.value =
      //                 new Icon(Icons.search, color: Colors.white);
      //             print("Exiting Search");
      //           }
      //         },
      //         icon: Obx(() => controller.actionIcon.value))
      //   ],
      // ),

      body: FutureBuilder<String>(
          future: controller.getMenuItems(),
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                print("on Tap");
                controller.searchFocusNode.unfocus();
              },
              // onVerticalDragStart: (event) {
              //   print("vertical drag");
              //   controller.searchFocusNode.unfocus();
              // },
              onHorizontalDragStart: (event) {
                print("horizontal drag");
                controller.searchFocusNode.unfocus();
              },
              child: CustomScrollView(
                anchor: 0.01,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    pinned: true,
                    centerTitle: true,
                    elevation: 10,
                    snap: true,
                    floating: true,
                    expandedHeight: Get.height * 0.12,
                    collapsedHeight: Get.height * 0.12,
                    flexibleSpace: ClipRect(
                      child: BackdropFilter(
                        filter:
                            new ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Container(
                            padding: EdgeInsets.only(
                              top: 1,
                            ),
                            width: Get.width,
                            height: Get.height * 0.1,
                            // color: Get.theme.primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        homeController
                                            .innerDrawerKey.currentState
                                            ?.open();
                                      },
                                      icon: Icon(Icons.menu),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          height: Get.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: Get.theme.backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: controller.searchField.value,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.searchButtonHandler,
                                      icon: Icon(Icons.search),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  // color: Get.theme.primaryColor,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ...controller.categories
                                            .map((category) => GestureDetector(
                                                  onTap: () => controller
                                                      .switchCategory(category),
                                                  child: Obx(() => Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: category ==
                                                                  controller
                                                                      .currentCategory
                                                                      .value
                                                              ? Get.theme
                                                                  .primaryColorLight
                                                              : Colors
                                                                  .grey[600],
                                                        ),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              Get.width * 0.005,
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal:
                                                              Get.width * 0.001,
                                                          vertical: Get.height *
                                                              0.005,
                                                        ),
                                                        height:
                                                            Get.height * 0.03,
                                                        width: Get.width * 0.15,
                                                        child: Center(
                                                          child: Text(
                                                            category,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: category ==
                                                                      controller
                                                                          .currentCategory
                                                                          .value
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ))
                                            .toList(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // background: FlutterLogo(),
                        ),
                      ),
                    ),
                    actions: <Widget>[],
                  ),
                  Container(
                    // color: Colors.red,
                    child: Obx(
                      () => SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                controller.searchFocusNode.unfocus();

                                controller.actionIcon.value =
                                    new Icon(Icons.search, color: Colors.white);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 15,
                                ),
                                margin: EdgeInsets.only(
                                  top: 5,
                                  left: 5,
                                  right: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Get.theme.cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Get.theme.primaryColorLight,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                // height: Get.height * 0.3,
                                child: Center(
                                    child: Column(
                                  children: [
                                    Container(
                                        height: Get.height * 0.20,
                                        width: Get.width,
                                        // color: Colors.amber,
                                        child: const Image(
                                          image: NetworkImage(
                                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                                        )),
                                    Text(
                                      controller.displayItems.value
                                          .elementAt(index)
                                          .name,
                                      style: Get.textTheme.headline5,
                                    ),
                                    Text((controller.displayItems.value
                                                .elementAt(index)
                                                .variants
                                                .length)
                                            .toString() +
                                        " variants available"),
                                    TextButton(
                                      onPressed: () async {
                                        // Get.to(() => ItemPageView(),
                                        //    arguments: [index]);
                                        String item_id = controller
                                            .displayItems.value
                                            .elementAt(index)
                                            .id;
                                        customModalBottomSheet(
                                            context, item_id);
                                      },
                                      child: Text("Add"),
                                    )
                                  ],
                                )),
                              ),
                            );
                          },
                          childCount: controller.displayItems.length,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

var categories = [
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
  "vegetables",
  "dairy",
  "Flour",
];
