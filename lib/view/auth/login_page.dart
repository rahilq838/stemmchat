import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/utils/constants.dart';

import '../../controller/auth_controller.dart';
import '../../controller/login_or_register_controller.dart';
import '../../route.dart';
import '../../utils/functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final RxBool showPassword = false.obs;
  final AuthController authController = Get.find<AuthController>();
  final _loginOrRegisterController = Get.find<LoginOrRegisterController>();
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    _loginFormKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  onLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      GetUtils.printFunction("login pressed","LoginPage","onLogin");
      try {
         await authController.signInWithEmailAndPassword(
            emailController.text, passwordController.text);
         GetUtils.printFunction("login pressed","LoginPage","onLoginComplete");
      } catch (e) {
        Get.defaultDialog(title: "ERROR", middleText: e.toString());
      }

    }
  }

  void onRegisterPressed() {
    _loginOrRegisterController.toggleShowLogin();
  }

  showPasswordPressed() {
    showPassword.value = !showPassword.value;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _loginFormKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: getLRTBPadding(),
                    child: Text(
                      "STEMMChat",
                      style: getTextStyle(fs: 30, fw: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child: Text(
                      "Welcome Back,\nLogin to your account",
                      style: getTextStyle(fs: 22, fw: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: getInputDecoration(
                        labelText: 'Email',
                      ),
                      validator: emailValidator,
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child: Obx(
                      () => TextFormField(
                        controller: passwordController,
                        obscureText: showPassword.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: getInputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: showPasswordPressed,
                                icon: Icon(showPassword.value
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined))),
                        validator: fieldValidator,
                      ),
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed:()async{
                            await onLogin();
                          } ,
                          style: getElevatedButtonStyle(),
                          child: Padding(
                            padding: getLRTBPadding(),
                            child: Text(
                              "Login",
                              style: getTextStyle(
                                  fw: FontWeight.w600,
                                  fs: 24,
                                  fc: Colors.white),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Don't have an account?", style: getTextStyle()),
                        InkWell(
                            onTap: onRegisterPressed,
                            child: Text(
                              "Register here",
                              style: getTextStyle(fc: focusColor),
                            )),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
