import 'package:app_banksampah/extensions/hidden_keyboard.dart';
import 'package:app_banksampah/views/login/fields/body.dart';
import 'package:app_banksampah/views/welcome/welcome.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<bool> _onWillPopCallback(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CoverScreen(),
      ),
    );

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return HiddenKeyboard(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => _onWillPopCallback(context),
          child: const Body(),
        ),
      ),
    );
  }
}
