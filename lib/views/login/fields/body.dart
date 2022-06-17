import 'package:app_banksampah/views/login/fields/background.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../assets/rounded_button.dart';
import '../../welcome/welcome.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              text: "BACK",
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
    );
  }
}
