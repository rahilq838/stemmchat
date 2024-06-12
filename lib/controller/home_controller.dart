import 'package:get/get.dart';
import 'auth_controller.dart';
import 'firestore_controller.dart';

class HomeController extends GetxController {
  final fireStoreController = Get.find<FireStoreController>();
  final fsInstance = Get.find<FireStoreController>().fsInstance;
  final authController = Get.find<AuthController>();
  @override
  void onInit() async {
    GetUtils.printFunction("HomeController", "onInit", "onInit");

    super.onInit();
  }



}
