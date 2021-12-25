import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/orders/views/orders_view.dart';

getDrawer(BuildContext context) {
  return Drawer(
    elevation: 20,
    child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Menu'),
        ),
        ListTile(
          title: const Text('Your Orders'),
          onTap: () {
            Navigator.pop(context);
            Get.to(OrdersView());
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
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
