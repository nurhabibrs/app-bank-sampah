import 'package:app_banksampah/extensions/hidden_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:app_banksampah/views/register/fields/body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const HiddenKeyboard(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
