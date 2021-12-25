import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class ShopController extends GetxController {
  Rx<bool> isSearching = false.obs;
  Rx<Widget> appBarTitle =
      new Text("Shop", style: new TextStyle(color: Colors.white)).obs;
  Rx<Icon> actionIcon = new Icon(Icons.search, color: Colors.white).obs;
  final TextEditingController searchQuery = new TextEditingController();
  final FocusNode searchFocusNode = new FocusNode();
  late Rx<Widget> searchField;

  searchButtonHandler() {
    print("Search Button Pressed");
    if (actionIcon.value.icon == Icons.search) {
      print("Search Button Pressed");
      actionIcon.value = new Icon(Icons.close, color: Colors.white);
      isSearching.value = true;
    } else {
      isSearching.value = false;
      actionIcon.value = new Icon(Icons.search, color: Colors.white);
      print("Exiting Search");
    }
  }

  // late RxList<MenuItem> mappedItems;
  // late Future<String> getMappedItems;

  final count = 0.obs;

  @override
  void onInit() {
    //TODO: Add Cache
    // print("Fetching mapped items");
    // getMappedItems = Future<String>.delayed(const Duration(seconds: 0), () {
    //   mappedItems = items.map((e) => MenuItem.fromJson(e)).toList().obs;
    //   print("Shop controller oninit");
    //   return 'Data Loaded';
    // });

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
