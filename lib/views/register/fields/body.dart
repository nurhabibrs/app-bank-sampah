import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_banksampah/extensions/rounded_button.dart';
import '../../register/fields/background.dart';
import '../../login/login.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

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
          AlertDialog alert = AlertDialog(
            content: const Text("Pendaftaran Pengguna Berhasil"),
            actions: [
              TextButton(
                child: const Text("LANJUT"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
          // print(response.data["response"]["message"]);
        },
      );
    } on DioError catch (e) {
      // Error message Pop Up
      var _fieldUsername = e.response?.data["response"]["username"].toString();
      var _fieldEmail = e.response?.data["response"]["email"].toString();
      var _fieldPhone = e.response?.data["response"]["phone"].toString();
      // print("Username = $_fieldUsername\n Email = $_fieldEmail \nNomor HP =$_fieldPhone");

      AlertDialog alert = AlertDialog(
        title: const Text("Registrasi Gagal!"),
        content: Text("$_fieldUsername\n$_fieldEmail\n$_fieldPhone"),
        actions: [
          TextButton(
            child: const Text("KEMBALI"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
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
                  "REGISTRASI PENGGUNA",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildUsernameField(),
              ),
              //SizedBox(height: size.height * 0.02),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildFullnameField(),
              ),
              //SizedBox(height: size.height * 0.02),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildAddressField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildPhoneField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildEmailField(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: buildPasswordField(),
              ),
              RoundedButton(
                text: "REGISTER",
                textColor: const Color.fromARGB(255, 255, 255, 255),
                press: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  registerUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
