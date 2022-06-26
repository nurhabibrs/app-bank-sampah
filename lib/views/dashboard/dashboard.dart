import 'dart:io';
import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/services.dart';
import '../../extensions/hidden_keyboard.dart';
import 'background.dart';
import '../../services/user_api_auth.dart';
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
          child: Background(
            child: SingleChildScrollView(
              child: HiddenKeyboard(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: size.height,
                        width: size.width,
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                            strokeWidth: 6,
                          ),
                        ),
                      );
                    }
                    // Login as Administrator
                    if (snapshot.hasData &&
                        snapshot.data!["response"]["user_info"]["is_admin"] ==
                            1) {
                      return AdminDashboard(
                        token: widget.token,
                        snapshot: snapshot,
                      );

                      // Login as User
                    } else if (snapshot.hasData &&
                        snapshot.data!["response"]["user_info"]["is_admin"] ==
                            0) {
                      return UserDashboard(
                        token: widget.token,
                        snapshot: snapshot,
                      );
                      // });
                    } else {
                      debugPrint(snapshot.error.toString());
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
