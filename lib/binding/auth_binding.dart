import 'package:get/get.dart';
import 'package:stemmchat/controller/firestore_controller.dart';
import 'package:stemmchat/controller/internet_controller.dart';
import 'package:stemmchat/controller/login_or_register_controller.dart';
import 'package:stemmchat/view/auth/login_or_register.dart';

import '../controller/auth_controller.dart';
import '../controller/current_chat_room_controller.dart';
import 'chat_room_controller_binding.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FireStoreController(), fenix: true);
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => LoginOrRegisterController());
    Get.lazyPut(() => CurrentChatRoomController(), fenix: true) ;
    Get.lazyPut(() => InternetController());
  }
}