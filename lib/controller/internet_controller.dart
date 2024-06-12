import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
class InternetController extends GetxController {
  RxBool isConnected = true.obs;

  @override
  void onInit()async {
    GetUtils.printFunction("InternetController", "onInit", "onInit");
    await checkInternet();
    super.onInit();
  }

  checkInternet() async {
    try {
      final listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
        switch (status) {
          case InternetStatus.connected:
          // The internet is now connected
            isConnected.value = true;
            break;
          case InternetStatus.disconnected:
            isConnected.value = false;
          // The internet is now disconnected
            break;
        }
      });
      }
     catch(e) {
      isConnected.value = false;
    }
  }
}