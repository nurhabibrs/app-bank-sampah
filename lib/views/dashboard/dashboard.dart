import 'dart:io';
import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/services.dart';
import '../../services/user_api_auth.dart';
import '../welcome/welcome.dart';
import 'background.dart';
import 'user.dart';
import 'admin.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiServices _apiServices = ApiServices();

  final snackBar = const SnackBar(
    content: Text('Tekan sekali lagi untuk keluar.'),
    duration: Duration(seconds: 3),
  );

  Future<Map<String, dynamic>> getUserData() async {
    dynamic response = await _apiServices.getUserProfileData(widget.token);
    return response;
  }

  Future<void> logout() async {
    await _apiServices.logout(widget.token);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, WelcomeScreen.nameRoute);
  }

  Future<bool> _onWillPopCallback() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: DoubleBackToCloseApp(
        snackBar: snackBar,
        child: WillPopScope(
          onWillPop: () => _onWillPopCallback(),
          child: FutureBuilder<Map<String, dynamic>>(
            future: getUserData(),
            builder: (context, snapshot) {
              // Login as Administrator
              if (snapshot.hasData &&
                  snapshot.data!["response"]["user_info"]["is_admin"] == 1) {
                return AdminDashboard(
                  token: widget.token,
                  snapshot: snapshot,
                );

                // Login as User
              } else if (snapshot.hasData &&
                  snapshot.data!["response"]["user_info"]["is_admin"] == 0 &&
                  snapshot.data!["response"]["user_info"]["is_active"] == 1) {
                return UserDashboard(
                  token: widget.token,
                  snapshot: snapshot,
                );
              } else if (snapshot.hasData &&
                  snapshot.data!["response"]["user_info"]["is_admin"] == 0 &&
                  snapshot.data!["response"]["user_info"]["is_active"] == 0) {
                return Background(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Text("User belum aktif."),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ElevatedButton(
                            onPressed: () {
                              logout();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 50, 205, 50),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                debugPrint(snapshot.error.toString());
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
