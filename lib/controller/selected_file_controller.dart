import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';


class SelectedFileController extends GetxController{
  Rx<PlatformFile?> file = Rx<PlatformFile?>(null);
  void setSelectedFile(PlatformFile? selectedFile){
    file.value = selectedFile;
    if (selectedFile != null) {
      GetUtils.printFunction("Selected File", "SelectedFileController", file.value!.bytes.toString(), isError: true);
    }
  }
}