import 'package:app_banksampah/extensions/hidden_keyboard.dart';
import 'package:app_banksampah/views/login/fields/body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HiddenKeyboard(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
