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
    apiKey: 'AIzaSyDX8ErTG7tWB-VkcwkIOGlIxjMniTa2O9E',
    appId: '1:160967134309:web:22ab1406d17e1a68050a8c',
    messagingSenderId: '160967134309',
    projectId: 'learnistan-fe1b6',
    authDomain: 'learnistan-fe1b6.firebaseapp.com',
    storageBucket: 'learnistan-fe1b6.appspot.com',
    measurementId: 'G-N6D0SG28S3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUhGIrCYU-nPGtf1_CkwzJ5AkAWnAhw2k',
    appId: '1:160967134309:android:91e29ba62b64dc2f050a8c',
    messagingSenderId: '160967134309',
    projectId: 'learnistan-fe1b6',
    storageBucket: 'learnistan-fe1b6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRUefNA3RF1V1E6jMuTqCQ12Ulj1hGazo',
    appId: '1:160967134309:ios:dea196d88dc061eb050a8c',
    messagingSenderId: '160967134309',
    projectId: 'learnistan-fe1b6',
    storageBucket: 'learnistan-fe1b6.appspot.com',
    iosClientId: '160967134309-60vp2nbpd93sbu1nooa68bnd9mm84cmr.apps.googleusercontent.com',
    iosBundleId: 'com.example.learnistan',
  );
}
