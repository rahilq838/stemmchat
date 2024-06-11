import 'package:get/get.dart';
import 'package:stemmchat/binding/chat_binding.dart';
import 'package:stemmchat/binding/chat_room_controller_binding.dart';
import 'package:stemmchat/view/auth/auth_wrapper.dart';
import 'package:stemmchat/view/auth/login_page.dart';
import 'package:stemmchat/view/auth/login_or_register.dart';
import 'package:stemmchat/view/auth/register.dart';
import 'package:stemmchat/view/home/chat_page.dart';
import 'package:stemmchat/view/home/home_page.dart';
import 'binding/auth_binding.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';
const String authWrapperRoute = '/auth';
const String homeRoute = '/home';
const String loginOrRegisterRoute = '/login_or_register';
const String chatPageRoute = '/chat_page';

class Route {
  static const String initialRoute = authWrapperRoute;
  static final List<GetPage> routes = [
    GetPage(name: loginRoute, page: () => const LoginPage()),
    GetPage(name: registerRoute, page: () => const RegisterPage()),
    GetPage(name: loginOrRegisterRoute, page: () => LoginOrRegister()),
    GetPage(name: authWrapperRoute, page: () => AuthWrapper()),
    GetPage(
        name: homeRoute,
        page: () => HomePage()),
    GetPage(
        name: chatPageRoute,
        page: () => ChatPage(),
        binding: ChatBinding()),
  ];

  static List<GetPage> get getRoutes => routes;
}
