import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../../../fields/rounded_button.dart';
import 'package:app_banksampah/pages/signup/fields/background.dart';
import 'package:app_banksampah/pages/welcome/welcome.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerFullname = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              children: <Widget>[
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _controllerUsername,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Username",
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15)))),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _controllerFullname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Nama Lengkap",
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15)))),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _controllerAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Alamat",
                      labelText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15)))),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _controllerPhone,
                  validator: (value) => checkPhoneNumber(value),
                  maxLength: 12,
                  decoration: const InputDecoration(
                      hintText: "Nomor Handphone",
                      labelText: "Nomor Handphone",
                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15)))),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _controllerEmail,
                  validator: (value) => checkEmail(value),
                  decoration: const InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15)))),
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
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
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15),
                              right: Radius.circular(15)))),
                ),
                SizedBox(height: size.height * 0.02),
                RoundedButton(
                    text: "REGISTER",
                    color: const Color.fromARGB(255, 76, 202, 120),
                    textColor: Colors.white,
                    press: () {}),
                RoundedButton(
                  text: "CANCEL",
                  color: const Color.fromARGB(255, 167, 211, 182),
                  textColor: Colors.black,
                  press: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const HomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 8) {
      return 'Terlalu pendek.';
    }
    return null;
  }

  checkEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Masukkan email yang valid.';
    } else {
      return null;
    }
  }

  checkPhoneNumber(String? value) {
    // I just copied the pattern from here: https://regexr.com/3c53v
    String pattern = r'^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regex = RegExp(pattern);

    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Masukkan nomor telepon yang valid.';
    }
    if (value.length < 3) {
      return 'Terlalu pendek.';
    }
    return null;
  }
}
