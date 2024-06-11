import 'package:get/get.dart';
import 'package:stemmchat/controller/login_or_register_controller.dart';
import 'package:stemmchat/view/auth/login_or_register.dart';

import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => LoginOrRegisterController());
  }
}