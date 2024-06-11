import 'package:get/get.dart';
import 'package:stemmchat/controller/selected_file_controller.dart';

import '../controller/chat_controller.dart';
import '../controller/firebase_storage_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => FireBaseStorageController());
    Get.lazyPut(() => SelectedFileController());

  }
}