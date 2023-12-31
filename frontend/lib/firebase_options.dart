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
    apiKey: 'AIzaSyA5ORZLWJ5D8QvrbGOfP04Df05pGpQj0XE',
    appId: '1:926526125124:web:22e2b14278b550cbb4b811',
    messagingSenderId: '926526125124',
    projectId: 'lifesavers-cbe0d',
    authDomain: 'lifesavers-cbe0d.firebaseapp.com',
    storageBucket: 'lifesavers-cbe0d.appspot.com',
    measurementId: 'G-R84DQ5NG7Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSQOS8H0DKC_L1X9kyrx2gidTLk8gGwCQ',
    appId: '1:926526125124:android:4a55693bd461eee0b4b811',
    messagingSenderId: '926526125124',
    projectId: 'lifesavers-cbe0d',
    storageBucket: 'lifesavers-cbe0d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD18iyjBa5tNmz7d32Nfeho3E6c4Ah-_u0',
    appId: '1:926526125124:ios:d951f37950c03373b4b811',
    messagingSenderId: '926526125124',
    projectId: 'lifesavers-cbe0d',
    storageBucket: 'lifesavers-cbe0d.appspot.com',
    iosClientId:
        '926526125124-jfdsv5kdgj715v7ehq79ffhe5alp19st.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD18iyjBa5tNmz7d32Nfeho3E6c4Ah-_u0',
    appId: '1:926526125124:ios:d951f37950c03373b4b811',
    messagingSenderId: '926526125124',
    projectId: 'lifesavers-cbe0d',
    storageBucket: 'lifesavers-cbe0d.appspot.com',
    iosClientId:
        '926526125124-jfdsv5kdgj715v7ehq79ffhe5alp19st.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );
}
