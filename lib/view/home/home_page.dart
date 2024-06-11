import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/controller/current_chat_room_controller.dart';
import 'package:stemmchat/controller/firestore_controller.dart';
import 'package:stemmchat/model/stemm_user.dart';
import 'package:stemmchat/route.dart';
import '../../controller/auth_controller.dart';
import '../../utils/functions.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final FireStoreController fireStoreController =
      Get.find<FireStoreController>();
  final _currentChatRoomController = Get.find<CurrentChatRoomController>();

  onSignOutPressed() {
    try {
      GetUtils.printFunction("sign out pressed", "HomePage", "onSignOutPressed");
      _authController.signOut();

    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
      Get.defaultDialog(title: "ERROR", middleText: error.toString());
    }
  }

  onReceiverTap(STEMMUser receiver) {
    GetUtils.printFunction("onReceiverTap", "HomePage", "onReceiverTap");
    _currentChatRoomController.currentReceiver = receiver;
    Get.toNamed(chatPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text("Home Page",
                            style: getTextStyle(fs: 40, fw: FontWeight.bold))),
                    Flexible(
                      child: IconButton(
                          onPressed: onSignOutPressed,
                          icon: const Icon(Icons.logout)),
                    ),
                  ],
                ),
                Text("Hi,\n${_authController.user?.email}",
                    style: getTextStyle(
                      fs: 16,
                    )),
                Padding(
                  padding: getLRTBPadding(left: 2.0, right: 2.0),
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        ()=> ListView.builder(
                          shrinkWrap: true,
                          itemCount: fireStoreController.users.value.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap:(){
                                onReceiverTap(fireStoreController
                                    .users.value[index]);},

                                title: Text(fireStoreController
                                    .users.value[index].email));
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
