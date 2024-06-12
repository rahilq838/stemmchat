import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:stemmchat/controller/auth_controller.dart';
import '../model/message.dart';
import 'current_chat_room_controller.dart';
import 'firestore_controller.dart';

class ChatController extends GetxController {
  int docLimit = 50;
  RxBool isLoading = false.obs;
  final fsInstance = FirebaseFirestore.instance;
  final authController = Get.find<AuthController>();
  final currentChatRoomController = Get.find<CurrentChatRoomController>();
  Rx<List<Message>> messages = Rx<List<Message>>([]);

  @override
  void onInit() async {
    GetUtils.printFunction("ChatController", "onInit", "onInit");
    isLoading.value = true;
    await getMessages(currentChatRoomController.currentReceiver!.uid);
    isLoading.value = false;
    // await markAsReadWhenChatPageOpens();
    super.onInit();
  }

  // markAsReadWhenChatPageOpens() async {
  //   try {
  //     if (authController.user != null) {
  //       await fsInstance
  //           .collection("chat_rooms")
  //           .doc(getCurrentChatRoom(
  //               currentChatRoomController.currentReceiver!.uid))
  //           .collection("Messages")
  //           .where("senderID",
  //               isEqualTo: currentChatRoomController.currentReceiver!.uid)
  //           .get()
  //           .then((value) {
  //         value.docs.map((e) => e.reference.update({"read": true}));
  //       });
  //     }
  //   } catch (e) {
  //     GetUtils.printFunction(e.toString(), "ChatController", "markAsRead",
  //         isError: true);
  //   }
  // }

  String getCurrentChatRoom(String receiverID) {
    List<String> ids = [authController.user!.uid, receiverID];
    ids.sort();
    String currentChatRoom = ids.join("_");
    return currentChatRoom;
  }

  Future<void> sendMessage(String receiverID, Message message) async {
    try {
      if (authController.user != null) {
        await fsInstance
            .collection("chat_rooms")
            .doc(getCurrentChatRoom(receiverID))
            .collection("Messages")
            .add(message.toMap());
      }
    } catch (e) {
      GetUtils.printFunction(e.toString(), "ChatController", "sendMessage",
          isError: true);
    }
  }

  getMessages(String receiverID) async {
    try {
      GetUtils.printFunction("getMessages", "ChatController", "getMessages");

      fsInstance
          .collection("chat_rooms")
          .doc(getCurrentChatRoom(receiverID))
          .collection("Messages")
          .orderBy("timestamp", descending: true)
          .limit(docLimit)
          .snapshots()
          .listen((event) {
        GetUtils.printFunction(
            "event.docs.length", event.docs.length, "getMessages");
        messages.value =
            event.docs.map((e) => Message.fromMap(e.data())).toList();
        GetUtils.printFunction(
            "messages.valueGET", messages.value.length, "getMessages");
      });
    } catch (e) {
      GetUtils.printFunction(
          e.toString(), "Message.fromMap(e.data())).toList()", "getMessages",
          isError: true);
    }
  }
}
