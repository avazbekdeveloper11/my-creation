// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqZot8aM9xy-SNmHbY1_KKDtTP2tk7KOA',
    appId: '1:10434323781:android:f78eaf0623ee5f34784a2c',
    messagingSenderId: '10434323781',
    projectId: 'sovchilik-uz-184b7',
    databaseURL: 'https://sovchilik-uz-184b7-default-rtdb.firebaseio.com',
    storageBucket: 'sovchilik-uz-184b7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDME1Khy4Zl0ESnqxQIgXyiNOZLX0BJcr8',
    appId: '1:10434323781:ios:0c407719f032d60a784a2c',
    messagingSenderId: '10434323781',
    projectId: 'sovchilik-uz-184b7',
    databaseURL: 'https://sovchilik-uz-184b7-default-rtdb.firebaseio.com',
    storageBucket: 'sovchilik-uz-184b7.firebasestorage.app',
    iosBundleId: 'uz.devops.sovchi',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB32lmJ1KqxMhfR0B9rzli7PF_jc5uizSY',
    appId: '1:10434323781:web:80a98ff1ed2c5ac7784a2c',
    messagingSenderId: '10434323781',
    projectId: 'sovchilik-uz-184b7',
    authDomain: 'sovchilik-uz-184b7.firebaseapp.com',
    databaseURL: 'https://sovchilik-uz-184b7-default-rtdb.firebaseio.com',
    storageBucket: 'sovchilik-uz-184b7.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDME1Khy4Zl0ESnqxQIgXyiNOZLX0BJcr8',
    appId: '1:10434323781:ios:0c407719f032d60a784a2c',
    messagingSenderId: '10434323781',
    projectId: 'sovchilik-uz-184b7',
    databaseURL: 'https://sovchilik-uz-184b7-default-rtdb.firebaseio.com',
    storageBucket: 'sovchilik-uz-184b7.firebasestorage.app',
    iosBundleId: 'uz.devops.sovchi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB32lmJ1KqxMhfR0B9rzli7PF_jc5uizSY',
    appId: '1:10434323781:web:565d70a3eebe754f784a2c',
    messagingSenderId: '10434323781',
    projectId: 'sovchilik-uz-184b7',
    authDomain: 'sovchilik-uz-184b7.firebaseapp.com',
    databaseURL: 'https://sovchilik-uz-184b7-default-rtdb.firebaseio.com',
    storageBucket: 'sovchilik-uz-184b7.firebasestorage.app',
  );

}