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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          "REGISTER",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 205, 50),
        automaticallyImplyLeading: false,
      ),
      body: const Body(),
    );
  }
}
