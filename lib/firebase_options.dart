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
    apiKey: 'AIzaSyAH_XdCycsBRdrOJu_CUeDVe_CX38tCsqo',
    appId: '1:160626613561:web:2e47d6c03a3775862d1ce8',
    messagingSenderId: '160626613561',
    projectId: 'play-workout',
    authDomain: 'play-workout.firebaseapp.com',
    storageBucket: 'play-workout.appspot.com',
    measurementId: 'G-QT1Q32T3HV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzWfywIs4afGH6TFnZRVRLJJMpsYyzW8c',
    appId: '1:160626613561:android:dc7e5433c4208b5a2d1ce8',
    messagingSenderId: '160626613561',
    projectId: 'play-workout',
    storageBucket: 'play-workout.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDd5vgYQJDmGTUQ9w-R_HrRIWARfFELLE0',
    appId: '1:160626613561:ios:63e162f0f31b74fb2d1ce8',
    messagingSenderId: '160626613561',
    projectId: 'play-workout',
    storageBucket: 'play-workout.appspot.com',
    iosClientId: '160626613561-tede0hbceb89go2ejr3k5k6td09tom51.apps.googleusercontent.com',
    iosBundleId: 'com.example.playWorkout',
  );
}
