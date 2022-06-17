import 'package:flutter/material.dart';
import 'package:app_banksampah/views/welcome/welcome.dart';

void main() {
  runApp(const BankSampahApp());
}

final ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
);

class BankSampahApp extends StatelessWidget {
  const BankSampahApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
