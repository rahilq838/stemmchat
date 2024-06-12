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
              read: false,
              type: Message.textType,
              senderID: sender.uid,
              senderEmail: sender.email,
              receiverID: _chatRoomController.currentReceiver!.uid,
              body: messageController.text,
              timestamp: Timestamp.now()));
      messageController.clear();
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
      );
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  onSendFilePressed() async {
    try {
      await fireBaseStorageController.uploadFile();
      // Get.defaultDialog(
      //   title: "File Sent",
      //   middleText: "File Sent Successfully",
      //   textConfirm: "Ok",
      //   onConfirm: () {
      //     Get.back();
      //   },
      // );
      GetUtils.printFunction(
          "onSendFilePressed", "onSendFilePressed", "onSendFilePressed");
    } catch (e) {
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

  onUploadTaskCancelPressed() {
    try {
      fireBaseStorageController.uploadTask.value?.cancel();
    } catch (e) {
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  onDownloadCancelPressed() {
    Get.back();
  }

  onDownloadPressed(Message msg) async {
    try {
      await fireBaseStorageController.downloadFile(msg);
    } catch (e) {
      GetUtils.printFunction(e.toString(), "ChatPage", "onSendPressed",
          isError: true);
    }
  }

  onWillingToDownloadFile(Message message) {
    try {
      GetUtils.printFunction("onWillingToDownloadFile",
          "onWillingToDownloadFile", "onWillingToDownloadFile");
      Get.defaultDialog(title: "Download This ${message.body}?", actions: [
        TextButton(
            onPressed: () async {
              await onDownloadPressed(message);
              Get.back();
            },
            child: const Text("Yes")),
        TextButton(onPressed: onDownloadCancelPressed, child: const Text("No"))
      ]);
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
                child: GetX(
                  init: fireBaseStorageController,
                  builder: (_) => _chatController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          reverse: true,
                          itemCount: _chatController.messages.value.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    // _chatController
                                    //             .messages.value[index].type !=
                                    //         Message.textType
                                    //     ? Text(_chatController
                                    //         .messages.value[index].body)
                                    //     :
                                    Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: _chatController.messages
                                              .value[index].senderEmail ==
                                          sender.email
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Card(
                                        color: Colors.grey.shade200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // TODO: Implement new msg indicator
                                              // if(_chatController
                                              //     .messages
                                              //     .value[index]
                                              //     .senderEmail !=
                                              //     sender.email && !_chatController
                                              //     .messages
                                              //     .value[index].read)
                                              //   Text("New", style: getTextStyle(fs: 12)),
                                              Text(
                                                  _chatController
                                                              .messages
                                                              .value[index]
                                                              .senderEmail ==
                                                          sender.email
                                                      ? "You"
                                                      : _chatController
                                                          .messages
                                                          .value[index]
                                                          .senderEmail
                                                          .split("@")[0],
                                                  style: getTextStyle(
                                                      fc: focusColor)),
                                              InkWell(
                                                onTap: _chatController
                                                            .messages
                                                            .value[index]
                                                            .type ==
                                                        Message.textType
                                                    ? null
                                                    : () {
                                                        onWillingToDownloadFile(
                                                            _chatController
                                                                .messages
                                                                .value[index]);
                                                      },
                                                child: Text(
                                                  _chatController.messages
                                                      .value[index].body,
                                                  style: _chatController
                                                              .messages
                                                              .value[index]
                                                              .type ==
                                                          Message.textType
                                                      ? getTextStyle(
                                                          fs: 16,
                                                          fw: FontWeight.bold)
                                                      : getTextStyle(
                                                          fs: 16,
                                                          fc: Colors.blueAccent,
                                                          decor: TextDecoration
                                                              .underline),
                                                ),
                                              ),
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
                                              ),
                                              if(_chatController.messages
                                                  .value[index].senderEmail ==
                                                  sender.email)
                                                Icon(
                                                _chatController.messages.value[index].read?Icons.mark_chat_read_rounded:
                                                Icons.mark_chat_unread_rounded,size: 13,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
                          !fireBaseStorageController.isUploading.value
                              ? Flexible(
                                  child: Text(
                                      currentFileController.file.value!.name))
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                          IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              color: focusColor,
                            ),
                            onPressed:
                                fireBaseStorageController.isUploading.value
                                    ? onUploadCancelPressed
                                    : onUploadTaskCancelPressed,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: focusColor,
                            ),
                            onPressed: () async {
                              await onSendFilePressed();
                            },
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
