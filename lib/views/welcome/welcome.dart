import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:app_banksampah/views/welcome/fields/body.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key}) : super(key: key);

  Future<bool> _onWillPopCallback() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Tekan sekali lagi untuk keluar."),
        ),
        child: WillPopScope(
          onWillPop: () => _onWillPopCallback(),
          child: const Body(),
        ),
      ),
    );
  }
}
