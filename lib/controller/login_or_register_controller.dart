import 'package:get/get.dart';

class LoginOrRegisterController extends GetxController {
  RxBool showLogin = true.obs;

  void toggleShowLogin() {
    showLogin.value = !showLogin.value;
  }
}