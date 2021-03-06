import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/cart/views/add_delivery_address_view.dart';
import 'package:sabzee/app/modules/cart/views/delivery_addresses_view.dart';
import 'package:sabzee/app/modules/common/widgets.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';

import '../controllers/cart_controller.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';

// ignore: must_be_immutable
class CartView extends GetView<CartController> {
  var authController = Get.find<AuthController>();
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
        leading: IconButton(
          onPressed: () {
            homeController.innerDrawerKey.currentState?.open();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: ExpandableBottomSheet(
        //use the key to get access to expand(), contract() and expansionStatus
        key: controller.bottomSheetKey,

        //optional
        //callbacks (use it for example for an animation in your header)
        onIsContractedCallback: () {
          print('contracted');

          var x = (843.0 - 813.1) / Get.height;
          var y = Get.height;
          print(x.toString() + " " + y.toString());
        },
        onIsExtendedCallback: () {
          print('extended');

          var height = 843.0 - 813.1;
          var x = height / Get.height;
          var y = Get.height;
          print(x.toString() + " " + y.toString());
        },

        //optional; default: Duration(milliseconds: 250)
        //The durations of the animations.
        animationDurationExtend: Duration(milliseconds: 500),
        animationDurationContract: Duration(milliseconds: 250),

        //optional; default: Curves.ease
        //The curves of the animations.
        animationCurveExpand: Curves.bounceOut,
        animationCurveContract: Curves.ease,

        //optional
        //The content extend will be at least this height. If the content
        //height is smaller than the persistentContentHeight it will be
        //animated on a height change.
        //You can use it for example if you have no header.
        // persistentContentHeight: Get.height * 0.06,

        //required
        //This is the widget which will be overlapped by the bottom sheet.
        background: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            //color: Colors.grey[700],
            height: Get.height,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Get.theme.primaryColorLight,
                        offset: Offset(0.0, 0.75), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Item"),
                      Text("Rate"),
                      Text("Quantity"),
                      Text("Price"),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Get.theme.backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
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
                              item_ids[index] =
                                  homeController.cart.value.items[index].itemId;
                              variant_ids[index] = homeController
                                  .cart.value.items[index].variantId;
                              homeController.mappedItems.value
                                  .forEach((curItem) {
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
                                qty:
                                    homeController.cart.value.items[index].qty -
                                        1,
                                itemId: homeController
                                    .cart.value.items[index].itemId,
                                variantId: homeController
                                    .cart.value.items[index].variantId,
                              );
                              homeController.cart.refresh();
                            }

                            addOnPressed() {
                              homeController.updateItemQuantity(
                                qty:
                                    homeController.cart.value.items[index].qty +
                                        1,
                                itemId: homeController
                                    .cart.value.items[index].itemId,
                                variantId: homeController
                                    .cart.value.items[index].variantId,
                              );
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
                                            // color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // color: Colors.amber[100],
                                                width: Get.width * 0.20,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      item_names[index],
                                                      style: Get
                                                          .textTheme.bodyText1,
                                                    ),
                                                    Text(variant_names[index]),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  // color: Colors.amber[100],
                                                  width: Get.width * 0.10,
                                                  child: Center(
                                                    child: Text(
                                                        variant_rates[index]),
                                                  )),
                                              Container(
                                                height: Get.height * 0.04,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                //color: Colors.amber[100],
                                                //width: Get.width * 0.20,
                                                child: Row(
                                                  children: [
                                                    getOutlinedButton(
                                                        isAdd: false,
                                                        onPressed:
                                                            subtractOnPressed,
                                                        height: Get.height),
                                                    Container(
                                                      width: Get.width * 0.05,
                                                      child: Center(
                                                        child: Text(
                                                            homeController
                                                                .cart
                                                                .value
                                                                .items[index]
                                                                .qty
                                                                .toString()),
                                                      ),
                                                    ),
                                                    getOutlinedButton(
                                                        isAdd: true,
                                                        onPressed: addOnPressed,
                                                        height: Get.height),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // color: Colors.amber,
                                                width: Get.width * 0.10,
                                                child: Center(
                                                  child: Text((homeController
                                                              .cart
                                                              .value
                                                              .items[index]
                                                              .qty *
                                                          int.parse(
                                                              variant_rates[
                                                                  index]))
                                                      .toString()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container();
                                });
                          })),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: Get.height * 0.4,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Total Cost"),
                          Obx(
                            () => Text(
                                homeController.cart.value.amount.toString()),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Delivery Date"),
                          Obx(
                            () => OutlinedButton(
                              onPressed: () => controller.selectDate(context),
                              child: Text(DateFormat('dd-MM-yy')
                                  .format(controller.deliveryDate.value)),
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Container(
                            height: 50,
                            width: Get.width,
                            color: Colors.red[100],
                            child: authController.sabzeeUser.addresses.length !=
                                    0
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              "Deliver to " +
                                                  authController
                                                      .sabzeeUser
                                                      .addresses[authController
                                                          .sabzeeUser
                                                          .defaultAddressIndex
                                                          .value]
                                                      .tag,
                                              style: Get.textTheme.headline6),
                                          Text(authController
                                              .sabzeeUser
                                              .addresses[authController
                                                  .sabzeeUser
                                                  .defaultAddressIndex
                                                  .value]
                                              .street),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(() => DeliveryAddressesView());
                                        },
                                        child: Text('change'),
                                      ),
                                    ],
                                  )
                                : ElevatedButton(
                                    child: Text("Add an address"),
                                    onPressed: () {
                                      Get.to(() => AddDeliveryAddressView());
                                    },
                                  ),
                          )),
                      Container(
                        width: Get.width,
                        // height: 100,
                        //  color: Colors.lightBlue,
                        child: Container(
                          alignment: Alignment.topCenter,
                          // height: Get.height * 0.05,
                          child: Column(
                            children: [
                              if (authController.sabzeeUser.paymentMethods
                                  .contains('online'))
                                Obx(
                                  () => ListTile(
                                    title: const Text('Online'),
                                    leading: Radio<PaymentMethod>(
                                      value: PaymentMethod.online,
                                      groupValue:
                                          controller.paymentMethod.value,
                                      onChanged: (PaymentMethod? value) {
                                        controller.paymentMethod.value = value!;
                                      },
                                    ),
                                  ),
                                ),
                              if (authController.sabzeeUser.paymentMethods
                                  .contains('cod'))
                                Obx(
                                  () => ListTile(
                                    title: const Text('Cash on delivery'),
                                    leading: Radio<PaymentMethod>(
                                      value: PaymentMethod.cod,
                                      groupValue:
                                          controller.paymentMethod.value,
                                      onChanged: (PaymentMethod? value) {
                                        controller.paymentMethod.value = value!;
                                      },
                                    ),
                                  ),
                                ),
                              ElevatedButton(
                                  onPressed: controller.onSubmit,
                                  child: Obx(() => Text(
                                      controller.paymentMethod.value ==
                                              PaymentMethod.online
                                          ? "Proceed to Payment"
                                          : "Place Order"))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        //optional
        //This widget is sticking above the content and will never be contracted.
        persistentHeader: Container(
          key: controller.containerKey,
          color: Colors.orange,
          height: Get.height * 0.03,
          child: Center(
            child: Container(
              height: Get.height * 0.007,
              width: Get.width * 0.1,
              color: Color.fromARGB((0.25 * 255).round(), 0, 0, 0),
            ),
          ),
        ),

        //required
        //This is the content of the bottom sheet which will be extendable by dragging.
        expandableContent: Container(),
        //   constraints: BoxConstraints(
        //     maxHeight: Get.height * 0.25,
        //   ),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: <Widget>[
        //         Container(
        //           height: 50,
        //           width: Get.width,
        //           color: Colors.red[100],
        //           child: Text("Delivery Address"),
        //         ),
        //         Container(
        //           width: Get.width,
        //           height: 50,
        //           color: Colors.blue,
        //           child: Text("Payment Method"),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        // optional
        // This will enable tap to toggle option on header.
        enableToggle: true,

        //optional
        //This is a widget aligned to the bottom of the screen and stays there.
        //You can use this for example for navigation.
        persistentFooter: Container(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.25,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}

//var x = ;
