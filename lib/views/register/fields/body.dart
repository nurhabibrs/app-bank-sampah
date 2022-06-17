import 'package:app_banksampah/assets/hidden_keyboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:app_banksampah/assets/rounded_button.dart';
import 'package:app_banksampah/views/register/fields/background.dart';
import 'package:app_banksampah/views/welcome/welcome.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
      child: DismissKeyboard(
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
                        postUser();
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
    // Copied from: https://regexr.com/3c53v
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

  postUser() async {
    var formData = FormData.fromMap(
      {
        'username': _controllerUsername.text,
        'fullname': _controllerFullname.text,
        'address': _controllerAddress.text,
        'phone': _controllerPhone.text,
        'email': _controllerEmail.text,
        'password': _controllerPassword.text
      },
    );

    Response response = await Dio().post(
        'https://345d-103-23-224-196.ap.ngrok.io/register',
        data: formData);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const HomePage(),
        ),
      );
    }

    // check respons
    print(response.data.toString());
  }
}
