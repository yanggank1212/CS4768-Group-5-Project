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
    apiKey: 'AIzaSyDkIdGDNZ5oZTDCGnRP7kzTpy9U8TdQGAc',
    appId: '1:1005533365455:web:17aba6669dc59cba0f63ba',
    messagingSenderId: '1005533365455',
    projectId: 'poutine-time-login',
    authDomain: 'poutine-time-login.firebaseapp.com',
    storageBucket: 'poutine-time-login.appspot.com',
    measurementId: 'G-EEBX26G0SJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzEl777dj5b3iVS2DWaUTsv_oTx7pbfFM',
    appId: '1:1005533365455:android:fc39c5d2241a53bf0f63ba',
    messagingSenderId: '1005533365455',
    projectId: 'poutine-time-login',
    storageBucket: 'poutine-time-login.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEuP1VLXG_JRLyJI3fD5I_7rAGyVvTTVI',
    appId: '1:1005533365455:ios:227f33d19df214c30f63ba',
    messagingSenderId: '1005533365455',
    projectId: 'poutine-time-login',
    storageBucket: 'poutine-time-login.appspot.com',
    iosBundleId: 'com.example.poutineTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEuP1VLXG_JRLyJI3fD5I_7rAGyVvTTVI',
    appId: '1:1005533365455:ios:f35a68bcdace16c50f63ba',
    messagingSenderId: '1005533365455',
    projectId: 'poutine-time-login',
    storageBucket: 'poutine-time-login.appspot.com',
    iosBundleId: 'com.example.poutineTime.RunnerTests',
  );
}
