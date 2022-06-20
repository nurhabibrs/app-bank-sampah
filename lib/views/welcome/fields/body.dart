import 'package:flutter/material.dart';
import 'package:app_banksampah/extensions/rounded_button.dart';
import 'package:app_banksampah/views/register/register.dart';
import 'package:app_banksampah/views/login/login.dart';
import 'package:app_banksampah/views/welcome/fields/background.dart';

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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const Text(
              "DI APLIKASI BANK SAMPAH",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Belum memiliki akun?',
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                  child: const Text(
                    'Buat Akun',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 50, 205, 50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
