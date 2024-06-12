import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/internet_controller.dart';
import 'auth/auth_wrapper.dart';

class InternetWrapper extends StatelessWidget {
  InternetWrapper({super.key});

  final internetController = Get.find<InternetController>();
  @override
  @override
  Widget build(BuildContext context) {
    return Obx(() => internetController.isConnected.value
        ? AuthWrapper()
        : const Scaffold(
            body: Center(
              child: Text("No Internet Connection"),
            ),
          ));
  }
}
