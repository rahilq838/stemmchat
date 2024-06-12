import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stemmchat/model/stemm_user.dart';
import '../model/chat_user.dart';

class FireStoreController extends GetxController {

  @override
  void onInit() async{
   await getUsers();
    super.onInit();
  }

  FirebaseFirestore fsInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Rx<List<ChatUser>> users = Rx<List<ChatUser>>([]);


  Future<void> createUserOnFireStore(STEMMUser user) async {
    await fsInstance.collection("Users").add(user.toMap());
  }


  getUsers() async {
    if (user != null) {
      try {
        GetUtils.printFunction("getUsers", "HomeController", "getUsers");
        fsInstance.collection("Users").snapshots().listen((event) {
          users.value = event.docs
              .map((e) => ChatUser.fromMap(e.data()))
              .toList()
              .where((element) => element.uid != user?.uid)
              .toList();
        });
      } catch (e) {
        GetUtils.printFunction(e.toString(), "FireStoreController", "getUsers");
      }
    }
  }

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
