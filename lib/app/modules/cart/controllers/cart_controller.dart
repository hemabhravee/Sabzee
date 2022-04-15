import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/api/api_provider.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';
import 'package:sabzee/app/modules/auth/models.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
  Rx<PaymentMethod> paymentMethod = PaymentMethod.online.obs;
  final count = 0.obs;
  GlobalKey<ExpandableBottomSheetState> bottomSheetKey =
      new GlobalKey<ExpandableBottomSheetState>();
  final containerKey = GlobalKey();
  var sizedBoxHeight = (Get.height * 0.03).obs;
  var curTime;
  var myFormat = DateFormat('dd-MM-yy');

  var initDate = DateTime.now()
      .add(Duration(
        days: 1,
      ))
      .obs;
  var deliveryDate = DateTime.now()
      .add(Duration(
        days: 1,
      ))
      .obs;

  var homeController = Get.find<HomeController>();
  var authController = Get.find<AuthController>();
  var apiProvider = ApiProvider();

  Future<void> selectDate(BuildContext context) async {
    print(DateFormat('dd-MM-yy').format(initDate.value));
    deliveryDate.value = await showDatePicker(
          context: context,
          firstDate: initDate.value,
          lastDate: initDate.value.add(
            Duration(
              days: 61,
            ),
          ),
          initialDate: initDate.value,
          selectableDayPredicate: (DateTime date) {
            return date.weekday != DateTime.monday;
          },
        ) ??
        deliveryDate.value;
  }

  onSubmit() async {
    if (homeController.cart.value.amount == 0) {
      Get.snackbar(
        "Your cart is empty",
        "Head to the shop section to add items to cart",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    } else {
      curTime = toDouble(TimeOfDay.now());
      print(TimeOfDay.now());
      if (curTime - 16.0 > 0) {
        initDate.value = DateTime.now().add(Duration(
          days: 2,
        ));
        if (myFormat.format(deliveryDate.value) ==
            myFormat.format(DateTime.now().add(Duration(
              days: 1,
            ))))
          deliveryDate.value = DateTime.now().add(Duration(
            days: 2,
          ));
      } else {
        var token = await authController.sabzeeUser.firebaseUser!.getIdToken();
        var response = await apiProvider.createNewOrder(
            token: token,
            deliveryDate:
                DateFormat('dd-MM-yy').format(deliveryDate.value).toString(),
            orderDate: DateFormat('dd-MM-yy').format(DateTime.now()).toString(),
            paymentStatus: "unpaid",
            paymentMethod: paymentMethod.value.toString().split('.')[1],
            address: authController.sabzeeUser.addresses
                .value[authController.sabzeeUser.defaultAddressIndex.value]
                .toJson(),
            cart: homeController.cart.value.toJson());

        print("response body");
        print(response.body['orderId'].runtimeType);
        print(response.body['orderId']);
        authController.sabzeeUser.orderIds.value.add(response.body['orderId']);
        print("payment method : " + paymentMethod.value.toString());
        print(paymentMethod.value == PaymentMethod.cod);

        if (paymentMethod.value == PaymentMethod.cod) {
          homeController.cart.value.clear();
          homeController.jumpToPage(0);
        } else if (paymentMethod.value == PaymentMethod.online) {}
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    curTime = toDouble(TimeOfDay.now());
    print(TimeOfDay.now());
    if (curTime - 16.0 > 0) {
      initDate.value = initDate.value.add(Duration(days: 1));
      deliveryDate.value = initDate.value.add(Duration(days: 1));
    }
    print(initDate.value);
    initDate.value.add(Duration(days: 1));
    print(initDate.value);
    initDate.value.add(Duration(days: 1));

    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
