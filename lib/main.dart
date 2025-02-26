import 'package:amigo_academy/screens/lead.dart';
import 'package:amigo_academy/screens/splash.dart';

import 'package:amigo_academy/shared_preferences/user_status.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // ✅ Ensures proper plugin initialization
  await getApplicationDocumentsDirectory();  // ✅ Ensures `path_provider` is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // 🔥 Set the navigator key
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
