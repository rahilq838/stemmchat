import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/view/auth/login_or_register.dart';
import 'package:stemmchat/view/auth/register.dart';
import 'package:stemmchat/view/home/home_page.dart';

import '../../controller/auth_controller.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: _authController.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginOrRegister();
        } else {
          return const HomePage();
        }
      },
    ));
  }
}
