import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/orders/views/orders_view.dart';

getDrawer(BuildContext context) {
  return Drawer(
    //elevation: 20,
    child: ListView(
      children: [
        Container(
          height: Get.height * 0.12,
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
          ),
          child: Text('Menu'),
        ),
        ListTile(
          title: const Text('Your Profile'),
          onTap: () {
            Navigator.pop(context);
            Get.to(() => OrdersView());
          },
        ),
        ListTile(
          title: const Text('Your Orders'),
          onTap: () {
            Navigator.pop(context);
            Get.to(() => OrdersView());
          },
        ),
        ListTile(
          title: const Text('About Us'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Contact Us'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
