import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:stemmchat/controller/selected_file_controller.dart';
import 'package:path_provider/path_provider.dart';
import '../model/message.dart';
import 'chat_controller.dart';
import 'current_chat_room_controller.dart';

class FireBaseStorageController extends GetxController {
  RxBool isUploading = false.obs;
  final storageRef = FirebaseStorage.instance.ref();
  final selectedFileController = Get.find<SelectedFileController>();
  final chatController = Get.find<ChatController>();
  final chatRoomController = Get.find<CurrentChatRoomController>();
  Rx<UploadTask?> uploadTask = Rx<UploadTask?>(null);


  @override
  void onInit() {
    GetUtils.printFunction("FireBaseStorageController", "onInit", "onInit");
    super.onInit();
  }

  openImagePicker() async {
    try {
      GetUtils.printFunction(
          "openImagePicker1", "FireBaseStorageController", "openImagePicker");
      // GalleryMedia? allmedia = await GalleryPicker.collectGallery();
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.any, withData: true);

      if (result != null) {
        PlatformFile file = result.files.first;
        selectedFileController.setSelectedFile(file);
      } else {
        Get.defaultDialog(
            title: "No Image Was Selected", middleText: "Please Try Again");
      }
    } catch (e) {
      selectedFileController.file.value = null;
      isUploading.value = false;
      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "openImagePicker",
          isError: true);
    }
  }

  uploadFile() async {
    try {
      Timestamp timestamp = Timestamp.now();
      isUploading.value = true;
      GetUtils.printFunction(
          "uploadFile", "FireBaseStorageController", "uploadFile");
      Uint8List? fileBytes = selectedFileController.file.value?.bytes;

      GetUtils.printFunction(
          "fileName",selectedFileController.file.value!.bytes, "uploadFile");

      if (selectedFileController.file.value != null && fileBytes != null) {
        GetUtils.printFunction(
            "Inside IF","selectedFileController.file.value != null && fileBytes != null", "uploadFile");
        String fileName = selectedFileController.file.value!.name;
        String chatRoomID = chatController
            .getCurrentChatRoom(chatRoomController.currentReceiver!.uid);
        uploadTask.value = FirebaseStorage.instance
            .ref('$chatRoomID/$timestamp$fileName')
            .putData(fileBytes!);

        await uploadTask.value!.whenComplete(()  async {
        String downloadUrl = await uploadTask.value!.snapshot.ref.getDownloadURL();
            String fileType =
            selectedFileController.file.value!.name.split(".").last;

        chatController.sendMessage(
            chatRoomController.currentReceiver!.uid,
            Message(
              read: false,
                type: fileType,
                senderID: chatController.authController.user.value !.uid,
                senderEmail: chatController.authController.user.value !.email,
                receiverID: chatRoomController.currentReceiver!.uid,
                downloadUrl: downloadUrl,
                timestamp: timestamp, body: fileName));
        });


        GetUtils.printFunction(
            "downloadUrl", "$chatRoomID/$timestamp$fileName", "uploadFile");
      }
      selectedFileController.file.value = null;
      isUploading.value = false;
    } catch (e) {
      selectedFileController.file.value = null;
      isUploading.value = false;
      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "uploadFileERROR",
          isError: true);
    }
  }

  downloadFile(Message msg)async{

    try {

      GetUtils.printFunction(
          "downloadFile", "FireBaseStorageController", "downloadFile");
      String chatRoomID = chatController.getCurrentChatRoom(chatRoomController.currentReceiver!.uid);
      GetUtils.printFunction(
          "chatRoomID in downloadFile", chatRoomID, "${msg.body}_${msg.timestamp}");
      FirebaseStorage.instance.ref(chatRoomID).child('${msg.timestamp}${msg.body}').getDownloadURL().then((value) => openFile(value, msg.body));
    } catch (e) {
      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "downloadFile",
          isError: true);
    }

  }

  openFile(String url, String fileName) async {
    try {
      final file = await downloadFileUsingDio(url, fileName);

      if (file != null) {
        GetUtils.printFunction(
            "file", "file != null", "file.readAsStringSync()");
        OpenFile.open(file.path);
      }

      GetUtils.printFunction(
          "openFile", "FireBaseStorageController", "openFile");


    } catch (e) {
      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "openFile",
          isError: true);
    }
  }

  Future<File?> downloadFileUsingDio(String url,String fileName) async {
    try {
      GetUtils.printFunction(
          "downloadFileUsingDio", "FireBaseStorageController", "downloadFileUsingDio");
      final appStorage = await getApplicationDocumentsDirectory ();
      final file = File('${appStorage.path}/$fileName');
      final response = await Dio().get(url ,
      options: Options(
        responseType: ResponseType.bytes,
            followRedirects: false,
        receiveTimeout: const Duration(seconds: 0),
      ),);

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      GetUtils.printFunction(
          "downloadFileUsingDio", "FireBaseStorageController", "downloadFileUsingDioComplete");
      return file;
    } catch (e) {

      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "downloadFileUsingDio",
          isError: true);
      return null;

    }
  }

}
