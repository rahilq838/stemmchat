import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/controller/current_chat_room_controller.dart';
import 'package:stemmchat/controller/firebase_storage_controller.dart';
import 'package:stemmchat/controller/firestore_controller.dart';
import 'package:stemmchat/route.dart';
import '../../controller/auth_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/selected_file_controller.dart';
import '../../model/chat_user.dart';
import '../../utils/functions.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final FireStoreController fireStoreController =
      Get.find<FireStoreController>();
  final _currentChatRoomController = Get.find<CurrentChatRoomController>();
  final homeController = Get.find<HomeController>();

  onSignOutPressed() {
    try {
      GetUtils.printFunction(
          "sign out pressed", "HomePage", "onSignOutPressed");
      _authController.signOut();
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
      Get.defaultDialog(title: "ERROR", middleText: error.toString());
    }
  }

  onReceiverTap(ChatUser receiver) {
    GetUtils.printFunction("onReceiverTap", "HomePage", "onReceiverTap");
    _currentChatRoomController.currentReceiver = receiver;
    Get.toNamed(chatPageRoute);
  }

  onUpdateProfilePicPressed() {
    try {
      Get.back();
      GetUtils.printFunction(
          "onUpdateProfilePicPressed", "HomePage", "onUpdateProfilePicPressed");
      homeController.prepareUploadOfProfilePic();
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
      Get.defaultDialog(title: "ERROR", middleText: error.toString());
    }
  }

  onMenuPressed() {
    GetUtils.printFunction("onMenuPressed", "HomePage", "onMenuPressed");
    Get.defaultDialog(
        title: "Profile",
        content: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                  maxRadius: 50,
                  child: _authController.user?.profileUrl == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : Image.network(_authController.user?.profileUrl ?? "")),
              Text("${_authController.user?.email}"),
              TextButton(
                  onPressed: onUpdateProfilePicPressed,
                  child: const Text("Update Profile Picture"))
            ],
          ),
        ));
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
                        child: Text("People",
                            style: getTextStyle(fs: 40, fw: FontWeight.bold))),
                    Flexible(
                        child: IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              onMenuPressed();
                            })),
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
                        () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: homeController.users.value.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  onReceiverTap(
                                      homeController.users.value[index]);
                                },
                                title: Text(
                                    homeController.users.value[index].email),
                                leading: _authController.user?.profileUrl==null?const Icon(Icons.person):Image.network(_authController.user!.profileUrl!), // Icon(Icons.person),
                                trailing: const Icon(Icons.chat)
                                // subtitle: Text(
                                //     "${fireStoreController.users.value[index].unReadMessages} Unread Messages"),
                                );
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
