import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // Create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications
  Future<void> initNotifications() async {
    // Request user permission (prompts on iOS)
    await _firebaseMessaging.requestPermission();

    // Optionally, fetch and print the FCM token
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
  }

  // Expose a function to get the FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  // (Placeholder) Handle received messages
  void handleReceivedMessages() {
    // TODO: Add onMessage, onMessageOpenedApp, etc.
  }

  // (Placeholder) Setup foreground and background handlers
  void setupInteractedMessage() {
    // TODO: Add background/foreground message configuration if needed
  }
}
