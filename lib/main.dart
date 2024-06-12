import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stemmchat/binding/auth_binding.dart';
import 'firebase_options.dart';
import 'route.dart' as app_route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  if(!kIsWeb){
    await Permission.manageExternalStorage.request();
    await Permission.photos.request();
    await Permission.videos.request();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: app_route.Route.initialRoute,
      initialBinding: AuthBinding(),
      title: 'STEMMChat',
      getPages: app_route.Route.getRoutes,
      theme: ThemeData(
        useMaterial3: true,
      ),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!),
    );
  }
}

