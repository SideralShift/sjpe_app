// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return ios;
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
    apiKey: 'AIzaSyBaJ5YErnzEK_4920ufPIW0HccO4zF3K9o',
    appId: '1:718962691295:web:827b2876c67908f59a2d6a',
    messagingSenderId: '718962691295',
    projectId: 'sjpe-48ba5',
    authDomain: 'sjpe-48ba5.firebaseapp.com',
    storageBucket: 'sjpe-48ba5.appspot.com',
    measurementId: 'G-37X6MYZLY3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1oykC8lBJKuY-o2YKzeGMjSsX65lIZZU',
    appId: '1:718962691295:android:329f7e24fcb0ce689a2d6a',
    messagingSenderId: '718962691295',
    projectId: 'sjpe-48ba5',
    storageBucket: 'sjpe-48ba5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6WACVE3FvWcZP_qDtdPo4rBjI0ngIwac',
    appId: '1:718962691295:ios:81ce8920daad838c9a2d6a',
    messagingSenderId: '718962691295',
    projectId: 'sjpe-48ba5',
    storageBucket: 'sjpe-48ba5.appspot.com',
    iosClientId: '718962691295-kg78sd2pai883qne0s0en197srlr3s4u.apps.googleusercontent.com',
    iosBundleId: 'com.sjpe.app',
  );
}
