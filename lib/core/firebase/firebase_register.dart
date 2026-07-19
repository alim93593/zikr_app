import 'package:firebase_core/firebase_core.dart';

import 'firebase_service.dart';

/// Centralized Firebase registration helper. Modify `firebaseOptions` for each platform
/// or use generated `firebase_options.dart` if you run `flutterfire configure`.
class FirebaseRegister {
  FirebaseRegister._();

  /// Initialize Firebase and return an initialized `FirebaseService`.
  static Future<FirebaseService> register(FirebaseOptions? options) async {
    if (options != null) {
      await Firebase.initializeApp(options: options);
    } else {
      // fallback - initialize with default generated options in env
      await Firebase.initializeApp();
    }
    final service = FirebaseService();
    await service.init();
    return service;
  }
}
