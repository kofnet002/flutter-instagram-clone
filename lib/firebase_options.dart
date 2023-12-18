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
    apiKey: 'AIzaSyBfNn5Etr2zkFd7msNqSVVeC8t3YjSGZ40',
    appId: '1:544678739474:web:9925f21fa58d74f12ee2cb',
    messagingSenderId: '544678739474',
    projectId: 'instagram-clone-f22a6',
    authDomain: 'instagram-clone-f22a6.firebaseapp.com',
    storageBucket: 'instagram-clone-f22a6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9h0WOCnDTfj5DQnj4NMtNxDeufO71MFY',
    appId: '1:544678739474:android:31a0ed38e6bb800f2ee2cb',
    messagingSenderId: '544678739474',
    projectId: 'instagram-clone-f22a6',
    storageBucket: 'instagram-clone-f22a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLuE-odeeYgGUQfFvUn0S6VtHUzB0luSg',
    appId: '1:544678739474:ios:e163a5e81d2b1c132ee2cb',
    messagingSenderId: '544678739474',
    projectId: 'instagram-clone-f22a6',
    storageBucket: 'instagram-clone-f22a6.appspot.com',
    iosBundleId: 'com.example.instagramClone',
  );
}