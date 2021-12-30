import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/item_page_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class ShopController extends GetxController {
  Rx<Widget> appBarTitle =
      new Text("Shop", style: new TextStyle(color: Colors.white)).obs;
  Rx<Icon> actionIcon = new Icon(Icons.search, color: Colors.white).obs;
  final TextEditingController searchController = new TextEditingController();
  final FocusNode searchFocusNode = new FocusNode();
  late Rx<Widget> searchField;
  var homeController = Get.find<HomeController>();
  late var mappedItems;
  RxList<MenuItem> displayItems = <MenuItem>[].obs;

  late RxSet<String> categories = <String>{}.obs;
  late RxString currentCategory = "Vegetables".obs;

  Rx<Widget> searchFieldSuffixIcon = Container(
    width: 0,
    height: 0,
  ).obs;

  applyCategory(String category) {}

  Future<String> getMenuItems() {
    return Future.delayed(Duration(seconds: 0), () {
      homeController.mappedItems.forEach((element) {
        categories.add(element.category);
      });
      print(categories);
      print(categories.elementAt(0));

      mappedItems = items.map((e) => MenuItem.fromJson(e)).toList();

      displayItems.value = mappedItems
          .where((item) => item.category == currentCategory.value)
          .toList();

      return "categories & items loaded";
    });
  }

  switchCategory(String newCategory) {
    currentCategory.value = newCategory;
    displayItems.value = mappedItems
        .where((item) => item.category == currentCategory.value)
        .toList();
    print("new category : " + newCategory);
  }

  //mappedItems.obs;
  //var categories = homeController;

  searchButtonHandler() {
    print("Search Button Pressed");
    if (actionIcon.value.icon == Icons.search) {
      print("Search Button Pressed");
      actionIcon.value = new Icon(Icons.close, color: Colors.white);
    } else {
      actionIcon.value = new Icon(Icons.search, color: Colors.white);
      displayItems.value = mappedItems;
      searchController.text = "";
    }
    print("Exiting Search");
  }

  // late RxList<MenuItem> mappedItems;
  // late Future<String> getMappedItems;

  final count = 0.obs;

  updateDisplayMenu(String query) {
    print("updating display items against query : " + query);

    List<MenuItem> x = [];

    mappedItems.forEach((MenuItem element) {
      // var y = [];
      // element.variants.forEach((element) {
      //   y.add(element.toJson());
      // });
      // if (element.name.startsWith(query) || query == "")
      //   x.add(MenuItem.fromJson(
      //       {"name": element.name, "variants": y, "id": element.id}));
      if (element.name.toLowerCase().startsWith(query.toLowerCase()) ||
          query == "") x.add(element);
    });

    displayItems.value = x;
    if (query == "") print("empty");
    displayItems.refresh();
    print(displayItems);
    print(homeController.mappedItems());
    update();
  }

  @override
  void onInit() {
    searchFocusNode.addListener(() {
      print("focus? : " + searchFocusNode.hasFocus.toString());
      searchFieldSuffixIcon.value = searchFocusNode.hasFocus
          ? Container(
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onPressed: () {
                  searchController.text = "";
                  updateDisplayMenu("");
                  // searchFocusNode.unfocus();
                },
              ),
            )
          : Container(
              color: Colors.transparent,
              height: 0,
              width: 0,
            );
    });

    // getMenuItems();
    //TODO: Add Cache
    // print("Fetching mapped items");
    // getMappedItems = Future<String>.delayed(const Duration(seconds: 0), () {
    //   mappedItems = items.map((e) => MenuItem.fromJson(e)).toList().obs;
    //   print("Shop controller oninit");
    //   return 'Data Loaded';
    // });

    searchField = Obx(() => TextField(
          controller: searchController,
          focusNode: searchFocusNode,
          style: new TextStyle(
            color: Colors.black,
          ),
          onChanged: (query) {
            updateDisplayMenu(query);
          },
          decoration: new InputDecoration(
            fillColor: Get.theme.backgroundColor,
            //prefixIcon: new Icon(Icons.search, color: Colors.white),
            hintText: "Search...",
            hintStyle: new TextStyle(
              color: Colors.black,
            ),

            suffixIcon: searchFieldSuffixIcon.value,
          ),
        )).obs;
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
