import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';

getOutlinedButton(
    {required bool isAdd,
    required void Function() onPressed,
    required double height}) {
  return OutlinedButton(
    child: Container(
        // color: Colors.red,
        height: height * 0.03,
        child: Center(
            child: Icon(
          isAdd ? Icons.add : Icons.remove,
          color: Get.theme.primaryColor,
        ))),
    onPressed: onPressed,
    style: ButtonStyle(
      shape: MaterialStateProperty.all(CircleBorder(
          // borderRadius:
          //     BorderRadius.circular(
          //         50.0),
          )),
    ),
  );
}

getMinusOutlinedButton(
    {required bool isAdd,
    required void Function() onPressed,
    required double height,
    required int qty}) {
  var itemController = Get.find<ItemPageController>();
  return OutlinedButton(
    child: Container(
        // color: Colors.red,
        height: height * 0.03,
        child: Center(
            child: Icon(
          isAdd ? Icons.add : Icons.remove,
          color: qty == 0 ? Colors.grey : Get.theme.primaryColor,
        ))),
    onPressed: qty == 0 ? null : onPressed,
    style: ButtonStyle(
      shape: MaterialStateProperty.all(CircleBorder(
          // borderRadius:
          //     BorderRadius.circular(
          //         50.0),
          )),
    ),
  );
}
