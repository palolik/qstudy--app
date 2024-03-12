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
        return macos;
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
    apiKey: 'AIzaSyDBS3NgpD4v_bgmswyHHCu54_CkiTzDC18',
    appId: '1:904778387381:web:d2c6e3fc7b5be85bc793fc',
    messagingSenderId: '904778387381',
    projectId: 'qstudy-4cb0b',
    authDomain: 'qstudy-4cb0b.firebaseapp.com',
    storageBucket: 'qstudy-4cb0b.appspot.com',
    measurementId: 'G-G48SCT9NNK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8sAE_MudWN_6WLvltqayEyABFjsSachE',
    appId: '1:904778387381:android:4384d6c7b06da47dc793fc',
    messagingSenderId: '904778387381',
    projectId: 'qstudy-4cb0b',
    storageBucket: 'qstudy-4cb0b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRzNI-bIkWpZlhqTgU4-i8Gx1D5n2Rirs',
    appId: '1:904778387381:ios:f56f4d0669a2683dc793fc',
    messagingSenderId: '904778387381',
    projectId: 'qstudy-4cb0b',
    storageBucket: 'qstudy-4cb0b.appspot.com',
    iosBundleId: 'com.example.mobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRzNI-bIkWpZlhqTgU4-i8Gx1D5n2Rirs',
    appId: '1:904778387381:ios:5e2e96be5e829045c793fc',
    messagingSenderId: '904778387381',
    projectId: 'qstudy-4cb0b',
    storageBucket: 'qstudy-4cb0b.appspot.com',
    iosBundleId: 'com.example.mobileApp.RunnerTests',
  );
}
