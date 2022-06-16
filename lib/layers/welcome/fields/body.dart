import 'package:flutter/material.dart';
import 'package:app_banksampah/fields/rounded_button.dart';
import 'package:app_banksampah/layers/register/register.dart';
import 'package:app_banksampah/layers/login/login.dart';
import 'package:app_banksampah/layers/welcome/fields/background.dart';
import 'package:page_transition/page_transition.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SELAMAT DATANG",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              "DI APLIKASI BANK SAMPAH",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: size.height * 0.01),
            Image.asset(
              'assets/images/trash.png',
              height: size.height * 0.4,
            ),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const LoginScreen(),
                  ),
                );
              },
            ),
            RoundedButton(
              text: "REGISTER",
              color: const Color.fromARGB(255, 167, 211, 182),
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
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
