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
            controller: addressController.line1TextController,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter house no.'
                  : null;
            },
            //    onChanged: (val) => addressController.line1.value = val,
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
            controller: addressController.line2TextController,
            //   onChanged: (val) => addressController.line2.value = val,
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
            controller: addressController.streetTextController,
            //   onChanged: (val) => addressController.street.value = val,
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
            onChanged: (val) => addressController.cityTextController.text = "Ranchi",
            controller: addressController.cityTextController,
            decoration: new InputDecoration(
              fillColor: Get.theme.backgroundColor,
              //prefixIcon: new Icon(Icons.search, color: Colors.white),
              // hintText: "Street/Locality Name*",
              // hintStyle: new TextStyle(
              //   color: Colors.black,
              // ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.08,
          child: TextFormField(
            controller: addressController.pincodeTextController,
            //  onChanged: (val) => addressController.pincode.value = val,
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
            controller: addressController.tagTextController,
            // onChanged: (val) => addressController.tag.value = val,
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
          onPressed: addressController.onSubmit,
          child: Obx(
            () => addressController.oldTag.value == ""
                ? Text("Add address")
                : Text("Update"),
          ),
        ),
      ],
    ),
  ));
}
