import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/utils/constants.dart';
import '../../controller/auth_controller.dart';
import '../../controller/login_or_register_controller.dart';
import '../../utils/functions.dart';

class RegisterPage extends StatefulWidget {
   const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RxBool showPassword = false.obs;
  final AuthController authController = Get.find<AuthController>();
  final _loginOrRegisterController = Get.find<LoginOrRegisterController>();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _registerFormKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();

  }

  void onRegister() {
    if (_registerFormKey.currentState!.validate()) {
      GetUtils.printFunction("Validated", 'RegisterPage', 'onRegister');
      try {
        authController.registerWithEmailAndPassword(emailController.text, passwordController.text);
      }
      // authController.login();
      catch (error) {
        // TODO: Implement error alert dialog if something goes wrong
        Get.defaultDialog(title: "Error", middleText: error.toString());
      }}
  }

  void onLoginPressed() {
    _loginOrRegisterController.toggleShowLogin();
  }

  showPasswordPressed() {
    showPassword.value = !showPassword.value;
  }

  String? fieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  String? confirmPasswordValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Field can't be empty";
    }
    if (text != passwordController.text) {
      return "Passwords don't match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _registerFormKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: getLRTBPadding(),
                    child: Text(
                      "STEMMChat",
                      style:getTextStyle(fs: 30, fw: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child: Text(
                      "Lets,\nCreate an Account",
                      style:getTextStyle(fs: 22, fw: FontWeight.bold),
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
                    child: Obx(
                          () => TextFormField(
                        controller: confirmPasswordController,
                        obscureText: showPassword.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: getInputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                                onPressed: showPasswordPressed,
                                icon: Icon(showPassword.value
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined))),
                        validator: confirmPasswordValidator,
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
                              onPressed: onRegister,
                              style: getElevatedButtonStyle(),
                              child: Padding(
                                padding: getLRTBPadding(),
                                child: Text(
                                  "Register",
                                  style: getTextStyle(
                                      fw: FontWeight.w600, fs: 24, fc: Colors.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getLRTBPadding(),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Already have an account?",style: getTextStyle()),
                        InkWell(
                            onTap: onLoginPressed,
                            child: Text("Login here" ,style: getTextStyle(fc: focusColor),)),
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