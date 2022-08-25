import 'package:flutter/material.dart';

class DigitButton extends StatelessWidget {
  const DigitButton({
    Key? key,
    this.color,
    required this.digit,
    this.onDigitTapped,
  }) : super(key: key);
  final Color? color;
  final int digit;
  final VoidCallback? onDigitTapped;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onDigitTapped,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: color ?? Color(0xFFA8A6A3),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            digit.toString(),
            style: textTheme.headline4!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
