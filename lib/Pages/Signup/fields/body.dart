import 'package:flutter/material.dart';
import '../../../fields/rounded_button.dart';
import 'package:app_banksampah/Pages/Signup/fields/background.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerFullname = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controllerUsername,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text.';
            } else {
              return null;
            }
          },
          decoration: const InputDecoration(
              hintText: "Username",
              labelText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controllerFullname,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text.';
            } else {
              return null;
            }
          },
          decoration: const InputDecoration(
              hintText: "Nama Lengkap",
              labelText: "Nama Lengkap",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controllerAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text.';
            } else {
              return null;
            }
          },
          decoration: const InputDecoration(
              hintText: "Alamat",
              labelText: "Alamat",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controllerPhone,
          validator: (value) => isValidPhoneNumber(value),
          maxLength: 12,
          decoration: const InputDecoration(
              hintText: "Nomor HP",
              labelText: "Nomor HP",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controllerEmail,
          validator: (value) => validateEmail(value),
          decoration: const InputDecoration(
              hintText: "Email",
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10)))),
        ),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controllerPassword,
          obscureText: _obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text.';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off)),
              border: const OutlineInputBorder(
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

validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address.';
  } else {
    return null;
  }
}

isValidPhoneNumber(String? value) {
  // I just copied the pattern from here: https://regexr.com/3c53v
  String pattern = r'^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regex = RegExp(pattern);

  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid phone number.';
  }
  return null;
}
