import 'package:flutter/material.dart';
import 'package:task/screens/firstScreen.dart';
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
    );
  }
}
