import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stemmchat/controller/current_chat_room_controller.dart';
import 'package:stemmchat/controller/firebase_storage_controller.dart';
import 'package:stemmchat/model/message.dart';
import 'package:stemmchat/model/stemm_user.dart';
import 'package:stemmchat/utils/constants.dart';
import 'package:stemmchat/utils/functions.dart';
import '../../controller/auth_controller.dart';
import '../../controller/chat_controller.dart';
import '../../controller/selected_file_controller.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatRoomController = Get.find<CurrentChatRoomController>();
  final messageController = TextEditingController();
  final _chatController = Get.find<ChatController>();
  final FireBaseStorageController fireBaseStorageController =
      Get.find<FireBaseStorageController>();
  final STEMMUser sender = Get.find<AuthController>().user!;
  final currentFileController = Get.find<SelectedFileController>();

  onSendPressed() {
    try {
      GetUtils.printFunction("onSendPressed",
          "_chatRoomController.currentReceiver!.uid", "onSendPressed");
      _chatController.sendMessage(
          _chatRoomController.currentReceiver!.uid,
          Message(
              type: Message.textType,
              senderID: sender.uid,
              senderEmail: sender.email,
              receiverID: _chatRoomController.currentReceiver!.uid,
              body: messageController.text,
              timestamp: Timestamp.now()));
      messageController.clear();
    } catch (e) {
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  onSendFilePressed() {
    try {
      GetUtils.printFunction("onSendPressed", "onSendPressed", "onSendPressed");
    }
     catch (e) {
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  onUploadFilePressed() {
    try {
      fireBaseStorageController.openImagePicker();
      GetUtils.printFunction("onUploadPressed",
          "_chatRoomController.currentReceiver!.uid", "onUploadPressed");

    } catch (e) {
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  onUploadCancelPressed() {
    try {
      currentFileController.setSelectedFile(null);
    } catch (e) {
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_chatRoomController.currentReceiver!.email,
              style: getTextStyle(fs: 20)),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 5,
                child: Obx(
                  () => _chatController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          reverse: true,
                          itemCount: _chatController.messages.value.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        _chatController.messages.value[index]
                                                    .senderEmail ==
                                                sender.email
                                            ? "You"
                                            : _chatController.messages
                                                .value[index].senderEmail
                                                .split("@")[0],
                                        style: getTextStyle(fc: focusColor)),
                                    Text(
                                        _chatController
                                            .messages.value[index].body,
                                        style: getTextStyle(
                                            fs: 16, fw: FontWeight.bold)),
                                    Text(
                                      formatDate(_chatController
                                          .messages
                                          .value[index]
                                          .timestamp
                                          .millisecondsSinceEpoch),
                                      style: getTextStyle(fs: 10),
                                    ),
                                    Text(
                                      extractTime(_chatController
                                          .messages
                                          .value[index]
                                          .timestamp
                                          .millisecondsSinceEpoch),
                                      style: getTextStyle(fs: 10),
                                    )
                                  ],
                                ),
                              )),
                )),
            Padding(
              padding:
                  getLRTBPadding(left: 5.0, right: 5.0, bottom: 5.0, top: 1.0),
              child: Obx(
                () => currentFileController.file.value == null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.attach_file,
                            color: focusColor,
                          ),
                          onPressed: onUploadFilePressed,
                        ),
                        TextFormField(
                            controller: messageController,
                            validator: fieldValidator,
                            decoration: getInputDecoration(
                                labelText: "Enter Message",
                                suffixIcon: IconButton(
                                    onPressed: onSendPressed,
                                    icon: const Icon(
                                      Icons.send,
                                      color: focusColor,
                                    ))),
                          ),
                      ],
                    )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(currentFileController.file.value!.name)),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: focusColor,
                            ),
                            onPressed: onUploadCancelPressed,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: focusColor,
                            ),
                            onPressed: onSendFilePressed,
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
