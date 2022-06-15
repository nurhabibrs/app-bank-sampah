import 'package:flutter/material.dart';
import '../../../fields/rounded_button.dart';
import 'package:app_banksampah/Pages/Signup/fields/background.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerFullname = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: controllerUsername,
          decoration: const InputDecoration(
              hintText: "Username",
              labelText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: controllerFullname,
          decoration: const InputDecoration(
              hintText: "Nama Lengkap",
              labelText: "Nama Lengkap",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: controllerAddress,
          decoration: const InputDecoration(
              hintText: "Alamat",
              labelText: "Alamat",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: controllerPhone,
          decoration: const InputDecoration(
              hintText: "Nomor HP",
              labelText: "Nomor HP",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: controllerEmail,
          decoration: const InputDecoration(
              hintText: "Email",
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: controllerPassword,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Password",
              labelText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        RoundedButton(
            text: "SIGNUP",
            color: const Color.fromARGB(255, 167, 211, 182),
            textColor: Colors.black,
            press: () {}),
      ]),
    );
  }
}
