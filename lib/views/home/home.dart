import 'package:app_banksampah/extensions/hidden_keyboard.dart';
import 'package:app_banksampah/views/home/fields/body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HiddenKeyboard(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
