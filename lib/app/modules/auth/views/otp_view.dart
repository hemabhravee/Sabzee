import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OtpView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OtpView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
