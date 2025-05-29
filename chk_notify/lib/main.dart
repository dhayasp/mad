// fH8eKEvIRTeC_tsbAsIjxI:APA91bGswRY0msvLDJpM6nz0eBYQl4ENZKCkRt6FURdZGG7RnrpHQQ6zZa5WgQCy9XPxwAP68DcQzSuPmqg1345wCXLdND06qaPA6aHrIINa12tseLtXDFk
import 'package:chk_notify/api/firebase_api.dart';
import 'package:chk_notify/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    await FirebaseApi().initNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
