import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  runApp(SendMoneyApp());
}

class SendMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),  // Start with the login page
    );
  }
}
