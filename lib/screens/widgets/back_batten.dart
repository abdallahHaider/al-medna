import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class BackBatten extends StatelessWidget {
  const BackBatten({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: IconButton.outlined(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(Color.fromRGBO(172, 232, 191, 1))),
          onPressed: onPressed,
          icon: Icon(Icons.arrow_forward)),
    );
  }
}
