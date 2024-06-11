import 'package:get/get.dart';
import 'package:stemmchat/view/auth/auth_wrapper.dart';
import 'package:stemmchat/view/auth/login_page.dart';
import 'package:stemmchat/view/auth/login_or_register.dart';
import 'package:stemmchat/view/auth/register.dart';
import 'binding/auth_binding.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';
const String authWrapperRoute = '/auth';
const String homeRoute = '/home';
const String loginOrRegisterRoute = '/login_or_register';

 class Route {

  static const String initialRoute = authWrapperRoute;
  static final List<GetPage> routes = [
    GetPage(name: loginRoute, page: () => const LoginPage(),),
    GetPage(name: registerRoute, page: () =>  const RegisterPage()),
    GetPage(name: loginOrRegisterRoute, page: () =>  LoginOrRegister()),
    GetPage(name: authWrapperRoute, page: () => AuthWrapper(),),
  ];

  static List<GetPage> get getRoutes => routes;
}