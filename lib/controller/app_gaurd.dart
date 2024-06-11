import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stemmchat/controller/auth_controller.dart';

// class AppGuard extends GetMiddleware {
//
//   final authService = Get.find<AuthController>(); // Get AuthService instance
//
//   @override
//   RouteSettings? redirect(String route) {
//     final loggedIn = authService.isLoggedIn.value; // Check login state
//
//     if (!loggedIn && (route == loginRoute || route == registerRoute)) {
//       return null; // Allow access to Login and Register routes if not logged in
//     } else if (loggedIn && (route == loginRoute || route == registerRoute)) {
//       return const Redirect(to: '/home'); // Redirect to Home if logged in
//     }
//     return null; // Pass through for other routes
//   }
// }