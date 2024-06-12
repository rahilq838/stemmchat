import 'package:get/get.dart';
import 'package:stemmchat/model/stemm_user.dart';

import '../model/chat_user.dart';

class CurrentChatRoomController extends GetxController{
  ChatUser? currentReceiver;
  void setCurrentReceiver(ChatUser user){
    currentReceiver = user;
  }
}