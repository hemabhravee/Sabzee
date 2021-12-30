import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  final count = 0.obs;
  GlobalKey<ExpandableBottomSheetState> bottomSheetKey =
      new GlobalKey<ExpandableBottomSheetState>();
  final containerKey = GlobalKey();
  var sizedBoxHeight = (Get.height * 0.03).obs;
  var initDate = DateTime.now().add(Duration(
    days: 1,
  ));
  var deliveryDate = DateTime.now()
      .add(Duration(
        days: 1,
      ))
      .obs;

  Future<void> selectDate(BuildContext context) async {
    deliveryDate.value = await showDatePicker(
          context: context,
          firstDate: initDate,
          lastDate: initDate.add(
            Duration(
              days: 61,
            ),
          ),
          initialDate: initDate,
          selectableDayPredicate: (DateTime date) {
            return date.weekday != DateTime.monday;
          },
        ) ??
        deliveryDate.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
