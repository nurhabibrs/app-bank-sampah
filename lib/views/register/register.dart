import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'background.dart';
import '../../extensions/hidden_keyboard.dart';
// import '../../extensions/rounded_button.dart';
import '../login/login.dart';

class RegisterScreen extends StatefulWidget {
  static const nameRoute = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
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
          hintText: "Nomor Telepon",
          labelText: "Nomor Telepon",
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
          hintText: "Kata Sandi",
          labelText: "Kata Sandi",
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

  String? checkUsername(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  String? checkFullname(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  String? checkAddress(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
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

  String? checkEmail(String? value) {
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

  String? checkPhoneNumber(String? value) {
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

  Future<bool> _onWillPopCallback(BuildContext context) async {
    Navigator.of(context).pop();
    return true;
  }

  Future registerUser() async {
    var dio = Dio();

    dynamic formData = FormData.fromMap(
      {
        'username': _controllerUsername.text,
        'fullname': _controllerFullname.text,
        'address': _controllerAddress.text,
        'phone': _controllerPhone.text,
        'email': _controllerEmail.text,
        'password': _controllerPassword.text
      },
    );

    try {
      // Check response
      await dio
          .post('https://345d-103-23-224-196.ap.ngrok.io/register',
              data: formData)
          .then(
        (response) {
          SnackBar snackBar = const SnackBar(
            content: Text("Pendaftaran Pengguna Berhasil."),
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 50, 205, 50),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushReplacementNamed(LoginScreen.nameRoute);

          // print(response.data["response"]["message"]);
        },
      );
    } on DioError catch (err) {
      // Error message Pop Up
      String? fieldUsername =
          err.response?.data["response"]["username"].toString();
      String? fieldEmail = err.response?.data["response"]["email"].toString();
      String? fieldPhone = err.response?.data["response"]["phone"].toString();
      // print("Username = $_fieldUsername\n Email = $_fieldEmail \nNomor HP =$_fieldPhone");

      if (Platform.isAndroid) {
        SnackBar snackBar = SnackBar(
          content: Text("$fieldUsername\n$fieldEmail\n$fieldPhone"),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text("Registrasi Gagal!"),
              content: Text("$fieldUsername\n$fieldEmail\n$fieldPhone"),
              actions: [
                TextButton(
                  child: const Text("KEMBALI"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
          barrierDismissible: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return HiddenKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () => _onWillPopCallback(context),
          child: Background(
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
                        "DAFTAR AKUN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: buildUsernameField(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: buildFullnameField(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: buildAddressField(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: buildPhoneField(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: buildEmailField(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: buildPasswordField(),
                    ),
                    isLoading
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ),
                              strokeWidth: 6,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                    registerUser();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 50, 205, 50),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 40),
                                ),
                                child: const Text(
                                  'DAFTAR',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
