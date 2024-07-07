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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDO6gGsTeriOJ0-coz69wVTsQQgTN9B2C0',
    appId: '1:856743581803:web:eed1e3f88984f0193c392e',
    messagingSenderId: '856743581803',
    projectId: 'saltandsugar-559b5',
    authDomain: 'saltandsugar-559b5.firebaseapp.com',
    storageBucket: 'saltandsugar-559b5.appspot.com',
    measurementId: 'G-R1TKTKRFN9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEKX30koNMXsHCLEfERY85EqDFJI6kV5c',
    appId: '1:856743581803:android:b8f1253f33df6eb93c392e',
    messagingSenderId: '856743581803',
    projectId: 'saltandsugar-559b5',
    storageBucket: 'saltandsugar-559b5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsQhl8Q0N93oZ-W2PI1MpJF_iicFv6wJg',
    appId: '1:856743581803:ios:7c4feb85ffdc2ce43c392e',
    messagingSenderId: '856743581803',
    projectId: 'saltandsugar-559b5',
    storageBucket: 'saltandsugar-559b5.appspot.com',
    iosBundleId: 'com.example.saltandsugar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsQhl8Q0N93oZ-W2PI1MpJF_iicFv6wJg',
    appId: '1:856743581803:ios:7c4feb85ffdc2ce43c392e',
    messagingSenderId: '856743581803',
    projectId: 'saltandsugar-559b5',
    storageBucket: 'saltandsugar-559b5.appspot.com',
    iosBundleId: 'com.example.saltandsugar',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDO6gGsTeriOJ0-coz69wVTsQQgTN9B2C0',
    appId: '1:856743581803:web:8e80edb73c9f20733c392e',
    messagingSenderId: '856743581803',
    projectId: 'saltandsugar-559b5',
    authDomain: 'saltandsugar-559b5.firebaseapp.com',
    storageBucket: 'saltandsugar-559b5.appspot.com',
    measurementId: 'G-0QFQRLRBXL',
  );

}