import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.child,
  });
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(Color.fromRGBO(132, 157, 181, 1)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          side: null),
      onPressed: onPressed,
      child: child,
    );
  }
}
