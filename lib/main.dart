import 'dart:io';
import 'package:app_banksampah/views/login/login.dart';
import 'package:app_banksampah/views/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/welcome/welcome.dart';

Future<void> main() async {
  // Import certificate to verify the certificate
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle()
      .load('assets/ca-certificate/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(
    data.buffer.asUint8List(),
  );

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
      home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.nameRoute,
      routes: {
        RegisterScreen.nameRoute: (context) => const RegisterScreen(),
        LoginScreen.nameRoute: (context) => const LoginScreen(),
      },
    );
  }
}
