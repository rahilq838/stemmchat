import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stemmchat/controller/selected_file_controller.dart';

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
      GetUtils.printFunction("openImagePicker", "FireBaseStorageController", "openImagePicker");
      // GalleryMedia? allmedia = await GalleryPicker.collectGallery();
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result != null) {
        PlatformFile file = result.files.first;
        selectedFileController.setSelectedFile(file);

      } else {
        Get.defaultDialog(title: "No Image Was Selected", middleText: "Please Try Again");
      }

    } catch (e) {
      selectedFileController.file.value = null;
      isUploading.value = false;
      GetUtils.printFunction(e.toString(), "FireBaseStorageController", "openImagePicker", isError: true);
    }
  }

  uploadFile() async {
    try {
      isUploading.value = true;
      GetUtils.printFunction("uploadFile", "FireBaseStorageController", "uploadFile");

      if (selectedFileController.file.value != null) {

        Uint8List? fileBytes = selectedFileController.file.value!.bytes;
        String fileName = selectedFileController.file.value!.name;
        String chatRoomID = chatController.getCurrentChatRoom(chatRoomController.currentReceiver!.uid);

        uploadTask.value = FirebaseStorage.instance.ref('$chatRoomID/$fileName').putData(fileBytes!);

        await uploadTask.value;

        GetUtils.printFunction("downloadUrl", "FireBaseStorageController", "uploadFile");
      }
      selectedFileController.file.value = null;
      isUploading.value = false;


    } catch (e) {
      selectedFileController.file.value = null;
      isUploading.value = false;
      GetUtils.printFunction(e.toString(), "FireBaseStorageController", "uploadFile", isError: true);
    }
  }

}