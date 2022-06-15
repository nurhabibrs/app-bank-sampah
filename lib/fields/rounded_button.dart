import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final color, textColor;
  const RoundedButton(
      {Key? key,
      required this.text,
      this.color = const Color.fromARGB(255, 76, 202, 120),
      required this.press,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: color,
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}
