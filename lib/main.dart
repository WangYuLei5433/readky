import 'package:digital_omamori/view/screens/page_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digital_omamori/view/screens/auth/login_page.dart';
import 'package:digital_omamori/view/screens/home_page.dart';
import 'package:digital_omamori/view/screens/welcome_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: const Color.fromARGB(255, 62, 146, 236),
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'open sans',
      ),
      home: PageSwitch(),
    );
  }
}
