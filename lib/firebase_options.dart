// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDw7vbeLqqhJyTZcWMYn4eMvc6a447adoY',
    appId: '1:783341867869:web:c1b9a122958b4c0ce9ceb4',
    messagingSenderId: '783341867869',
    projectId: 'stemmchat-4996c',
    authDomain: 'stemmchat-4996c.firebaseapp.com',
    storageBucket: 'stemmchat-4996c.appspot.com',
    measurementId: 'G-1D9F14KPSD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC02oOmUHb2aW5m7lE0oDfy_UosoPbFtrY',
    appId: '1:783341867869:android:0b75560e337e160be9ceb4',
    messagingSenderId: '783341867869',
    projectId: 'stemmchat-4996c',
    storageBucket: 'stemmchat-4996c.appspot.com',
  );
}
