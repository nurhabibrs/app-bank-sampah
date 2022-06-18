import 'package:app_banksampah/extensions/hidden_keyboard.dart';
import 'package:app_banksampah/views/login/fields/background.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../extensions/rounded_button.dart';
import '../../welcome/welcome.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _obscureText = true;
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildUsernameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerUsername,
      validator: (value) => checkUsername(value),
      maxLength: 255,
      decoration: const InputDecoration(
        hintText: "Username",
        labelText: "Username",
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
      ),
    );
  }

  String? checkUsername(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  Widget buildPasswordField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerPassword,
      obscureText: _obscureText,
      validator: (value) => checkPassword(value),
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
      ),
    );
  }

  String? checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 8) {
      return 'Minimal 8 karakter';
    }
    return null;
  }

  Future loginUser() async {
    var dio = Dio();

    var formData = FormData.fromMap(
      {
        'username': _controllerUsername.text,
        'password': _controllerPassword.text
      },
    );

    try {
      // Check response
      await dio
          .post('https://345d-103-23-224-196.ap.ngrok.io/login', data: formData)
          .then(
            (response) {},
          );
    } on DioError catch (e) {
      // Error message Pop Up

    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 45,
                child: Text(
                  "LOGIN PENGGUNA",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildUsernameField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildPasswordField(),
              ),
              RoundedButton(
                text: "LOGIN",
                textColor: const Color.fromARGB(255, 255, 255, 255),
                press: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    PageTransition(
                        child: const HomePage(), type: PageTransitionType.fade),
                  );
                  loginUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
