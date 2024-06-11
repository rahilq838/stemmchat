import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/view/auth/register.dart';
import '../../controller/login_or_register_controller.dart';
import 'login_page.dart';

class LoginOrRegister extends StatelessWidget {
  LoginOrRegister({super.key});
  final _loginOrRegisterController = Get.find<LoginOrRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_loginOrRegisterController.showLogin.value) {
        return const LoginPage();
      } else {
        return const RegisterPage();
      }
    });
  }
}
