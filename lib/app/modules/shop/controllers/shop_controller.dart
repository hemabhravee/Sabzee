import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class ShopController extends GetxController {
  Rx<bool> isSearching = false.obs;
  Rx<Widget> appBarTitle =
      new Text("Shop", style: new TextStyle(color: Colors.white)).obs;
  Rx<Icon> actionIcon = new Icon(Icons.search, color: Colors.white).obs;
  final TextEditingController searchQuery = new TextEditingController();
  final FocusNode searchFocusNode = new FocusNode();
  late Rx<Widget> searchField;

  var mappedItems = items.map((e) => MenuItem.fromJson(e));

  final count = 0.obs;
  @override
  void onInit() {
    print("init search field");
    searchField = TextField(
      controller: searchQuery,
      focusNode: searchFocusNode,
      style: new TextStyle(
        color: Colors.white,
      ),
      decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search, color: Colors.white),
          hintText: "Search...",
          hintStyle: new TextStyle(color: Colors.white)),
    ).obs;
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
