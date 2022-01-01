import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzee/app/modules/cart/controllers/add_delivery_address_controller.dart';

//jngvbhvm
getAddressDetailsContainer() {
  var addressController = Get.find<AddDeliveryAddressController>();
  return Container(
      child: Form(
    key: addressController.formKey,
    child: Column(
      children: [
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter name'
                  : null;
            },
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Recipient Name*",
              hintStyle: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter house no.'
                  : null;
            },
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Flat/House No.*",
              hintStyle: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Colony Name",
              hintStyle: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter street/locality name'
                  : null;
            },
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Street/Locality Name*",
              hintStyle: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Pincode(optional)",
              hintStyle: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Address Tag*",
              hintStyle: new TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (addressController.formKey.currentState!.validate()) {
              // add address
            }
          },
          child: Text("Add address"),
        ),
      ],
    ),
  ));
}
