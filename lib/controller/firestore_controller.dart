import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stemmchat/model/stemm_user.dart';
class FireStoreController extends GetxController {
  final fsInstance = FirebaseFirestore.instance;


  Future<void> createUserOnFireStore(STEMMUser user) async {
    await fsInstance.collection("Users").doc(user.uid).set(user.toMap());
  }




  // TODO: get all unread messages count for each user
  // Future<int> getUnreadMessagesCountForReceiver(currentUserID) async {
  //   try {
  //     GetUtils.printFunction("getUnreadMessagesCountForReceiver", "HomeController", "getUnreadMessagesCountForReceiver");
  //     int count = 0;
  //     GetUtils.printFunction("authController.user!.uid", user!.uid, "getUnreadMessagesCountForReceiver");
  //
  //     List<String> ids = [
  //       user!.uid,
  //       ];
  //     ids.sort();
  //     String currentChatRoom = ids.join("_");
  //     final cnt  = fsInstance
  //         .collection("chat_rooms")
  //         .doc(currentChatRoom)
  //         .collection("Messages")
  //         .where("senderID", isEqualTo: receiverID)
  //         .where("read", isEqualTo: false).count();
  //
  //     //     .then((value) {
  //     //   count = value.docs.length;
  //     //   GetUtils.printFunction("countINSIDETHen", count, "getUnreadMessagesCountForReceiver");
  //     //
  //     //   users.value = users.value.map((e) {
  //     //     return ChatUser(uid: e.uid, email: e.email)
  //     //     ;
  //     //   } ).toList();
  //     // });
  //     return count;
  //   } catch (e) {
  //     GetUtils.printFunction(
  //         e.toString(), "FireStoreController", "getUnreadMessagesCountERROR",
  //         isError: true);
  //     return 0;
  //   }
  // }

}
