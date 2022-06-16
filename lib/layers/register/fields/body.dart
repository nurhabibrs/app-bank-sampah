import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../../../fields/rounded_button.dart';
import 'package:app_banksampah/layers/register/fields/background.dart';
import 'package:app_banksampah/layers/welcome/welcome.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _username;
  var _fullname;
  var _address;
  var _phone;
  var _email;
  var _password;
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerFullname = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Widget buildUsernameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerUsername,
      validator: (value) => checkUsername(value),
      maxLength: 255,
      onSaved: (value) {
        _username = value;
      },
      decoration: const InputDecoration(
          hintText: "Username",
          labelText: "Username",
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)))),
    );
  }

  Widget buildFullnameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerFullname,
      validator: (value) => checkFullname(value),
      maxLength: 255,
      onSaved: (value) {
        _fullname = value;
      },
      decoration: const InputDecoration(
          hintText: "Nama Lengkap",
          labelText: "Nama Lengkap",
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)))),
    );
  }

  Widget buildAddressField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerAddress,
      validator: (value) => checkAddress(value),
      maxLength: 255,
      onSaved: (value) {
        _address = value;
      },
      decoration: const InputDecoration(
          hintText: "Alamat",
          labelText: "Alamat",
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)))),
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerPhone,
      keyboardType: TextInputType.phone,
      validator: (value) => checkPhoneNumber(value),
      maxLength: 12,
      onSaved: (value) {
        _phone = value;
      },
      decoration: const InputDecoration(
          hintText: "Nomor Handphone",
          labelText: "Nomor Handphone",
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)))),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => checkEmail(value),
      onSaved: (value) {
        _email = value;
      },
      decoration: const InputDecoration(
          hintText: "Email",
          labelText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)))),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerPassword,
      obscureText: _obscureText,
      validator: (value) => checkPassword(value),
      onSaved: (value) {
        _password = value;
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
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(15.0),
                children: <Widget>[
                  buildUsernameField(),
                  SizedBox(height: size.height * 0.02),
                  buildFullnameField(),
                  SizedBox(height: size.height * 0.02),
                  buildAddressField(),
                  SizedBox(height: size.height * 0.02),
                  buildPhoneField(),
                  SizedBox(height: size.height * 0.02),
                  buildEmailField(),
                  SizedBox(height: size.height * 0.02),
                  buildPasswordField(),
                  SizedBox(height: size.height * 0.02),
                  RoundedButton(
                    text: "REGISTER",
                    color: const Color.fromARGB(255, 76, 202, 120),
                    textColor: Colors.white,
                    press: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();

                      // print(_username);
                      // print(_fullname);
                      // print(_address);
                      // print(_phone);
                      // print(_email);
                      // print(_password);
                    },
                  ),
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
      ),
    );
  }

  checkUsername(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  checkFullname(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  checkAddress(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 8) {
      return 'Minimal 8 karakter';
    }
    return null;
  }

  checkEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (!regex.hasMatch(value)) {
      return 'Masukkan email yang valid.';
    } else {
      return null;
    }
  }

  checkPhoneNumber(String? value) {
    // I just copied the pattern from here: https://regexr.com/3c53v
    String pattern = r'^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (!regex.hasMatch(value)) {
      return 'Masukkan nomor telepon yang valid.';
    }
    if (value.length < 3) {
      return 'Terlalu pendek.';
    }
    return null;
  }
}
