import 'package:get/get.dart';
import 'package:stemmchat/controller/firestore_controller.dart';
import 'package:stemmchat/controller/home_controller.dart';
import 'package:stemmchat/controller/internet_controller.dart';
import 'package:stemmchat/controller/login_or_register_controller.dart';

import '../controller/auth_controller.dart';
import '../controller/current_chat_room_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InternetController());
    Get.lazyPut(() => FireStoreController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(()=>HomeController());
    Get.lazyPut(() => LoginOrRegisterController());
    Get.lazyPut(() => CurrentChatRoomController(), fenix: true) ;
  }
}