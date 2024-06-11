import 'package:get/get.dart';
import 'package:stemmchat/model/stemm_user.dart';

import '../model/message.dart';

class CurrentChatRoomController extends GetxController{
  STEMMUser? currentReceiver;


  void setCurrentReceiver(STEMMUser user){
    currentReceiver = user;
  }
}