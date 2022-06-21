import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import '../../extensions/rounded_button.dart';
import '../login/login.dart';
import '../register/register.dart';
import 'background.dart';

class WelcomeScreen extends StatelessWidget {
  static const nameRoute = '/';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tekan sekali lagi untuk keluar.'),
        ),
        child: Background(
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
                    Navigator.of(context).pushNamed(LoginScreen.nameRoute);
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
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.nameRoute);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
