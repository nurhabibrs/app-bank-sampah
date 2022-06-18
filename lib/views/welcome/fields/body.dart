import 'package:flutter/material.dart';
import 'package:app_banksampah/extensions/rounded_button.dart';
import 'package:app_banksampah/views/register/register.dart';
import 'package:app_banksampah/views/login/login.dart';
import 'package:app_banksampah/views/welcome/fields/background.dart';
import 'package:page_transition/page_transition.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SELAMAT DATANG",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              "DI APLIKASI BANK SAMPAH",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Image.asset(
              'assets/images/trash.png',
              height: size.height * 0.4,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const LoginScreen(),
                  ),
                );
              },
            ),
            RoundedButton(
              text: "REGISTER",
              color: const Color.fromARGB(255, 130, 241, 130),
              textColor: const Color.fromARGB(255, 0, 0, 0),
              press: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const RegisterScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
