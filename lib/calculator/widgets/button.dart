import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.backgroundColor,
    this.foregroundColor,
    required this.text,
    this.onTap,
    this.isLarge = false,
  }) : super(key: key);
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final VoidCallback? onTap;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: isLarge ? 160 : 70,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade700,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            text,
            style: textTheme.headline4!.copyWith(
              color: foregroundColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
