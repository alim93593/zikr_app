class Constants {
  Constants._();

  // Example API base; replace with real endpoints when available
  static const String apiBase = 'https://api.example.com';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String collectionsSub = 'collections'; // per-user subcollection
  static const String globalCollections = 'zikr_items';

  // Feature flags, env keys
  static const bool enableDebugLogging = true;
}
