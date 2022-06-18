import 'package:flutter/material.dart';

class HiddenKeyboard extends StatelessWidget {
  final Widget child;
  const HiddenKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus &&
        //     currentFocus.focusedChild != null) {
        //   FocusManager.instance.primaryFocus?.unfocus();
        // }
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
