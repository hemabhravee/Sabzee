import 'package:flutter/material.dart';

getOutlinedButton(
    {required bool isAdd,
    required void Function() onPressed,
    required double height}) {
  return OutlinedButton(
    child: Container(
        // color: Colors.red,
        height: height * 0.03,
        child: Center(child: Icon(isAdd ? Icons.add : Icons.remove))),
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
