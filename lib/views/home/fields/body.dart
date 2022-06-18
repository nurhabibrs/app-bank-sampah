import 'package:app_banksampah/extensions/rounded_button.dart';
import 'package:app_banksampah/views/home/fields/background.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 45,
              child: Text(
                "LOGIN PENGGUNA",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            RoundedButton(
              text: "KELUAR",
              textColor: const Color.fromARGB(255, 255, 255, 255),
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
