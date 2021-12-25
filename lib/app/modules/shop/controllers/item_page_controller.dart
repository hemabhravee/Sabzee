import 'package:get/get.dart';
import 'package:sabzee/app/modules/home/controllers/home_controller.dart';
import 'package:sabzee/app/modules/shop/controllers/shop_controller.dart';
import 'package:sabzee/app/modules/shop/models.dart';

class ItemPageController extends GetxController {
  var arguments = Get.arguments;
  late int index = arguments[0];
  var shopController = Get.find<ShopController>();
  var homeController = Get.find<HomeController>();
  late Rx<MenuItem> y;
  RxList<int> quantities = <int>[].obs;
  Rx<int> cost = 0.obs;
  late bool isItemNew = cost == 0;

  final count = 0.obs;

  onSubtract(int index) {
    if (quantities[index] > 0) {
      quantities[index]--;
      cost.value -= int.parse(y.value.variants[index].rate);
      // y.value.refresh();
      update();
    }
  }

  onAdd(int index) {
    print("onpressed");
    print("old = " + quantities[index].toString());

    quantities[index]++;
    cost.value += int.parse(y.value.variants[index].rate);

    y.refresh();

    print("new = " + quantities[index].toString());
    print("original = " +
        getQuantityFromUid(y.value.id, y.value.variants[index].id).toString());
    print("cost = " + cost.value.toString());
    update();
  }

  onSubmit() {
    for (int i = 0; i < y.value.variants.length; i++) {
      var value = y.value.variants[i];

      if (itemExistsInCart(homeController.mappedItems[index].id, value.id))
        homeController.updateItemQuantity(
          qty: quantities[i],
          uid: y.value.id + "-" + value.id,
        );
      else if (quantities[i] > 0)
        homeController.addItemToCart(
          uid: homeController.mappedItems[index].id + "-" + value.id,
          qty: quantities[i],
        );

      update();

      // y.value.variants.forEachIndexed((index, value) {
      //   shopController.mappedItems[index].variants[index].qty =
      //       value.qty;
      // });
    }
    // Navigator.pop(context);
    Get.back();
  }

  @override
  void onInit() {
    y = MenuItem(
            name: "name",
            variants: [],
            id: homeController.mappedItems.value[index].id)
        .obs;
    y.value.variants = homeController.mappedItems.value[index].variants
        .map((e) => Variant(name: e.name, rate: e.rate, id: e.id))
        .toList();
    for (int i = 0; i < y.value.variants.length; i++) {
      print("finding variant quantity");
      Variant element = y.value.variants[i];
      quantities.add(getQuantityFromUid(
          homeController.mappedItems.value[index].id, y.value.variants[i].id));
      cost.value += quantities[i] * int.parse(element.rate);
    }
    print("Cost = " + cost.value.toString());
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
