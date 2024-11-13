import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.text,
    this.width,
    this.height,
    this.color,
    this.onPressed,
  });

  final String? text;
  final double? width;
  final double? height;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? Colors.cyanAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text ?? "OK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}