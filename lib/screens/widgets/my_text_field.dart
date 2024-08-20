import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.enabled,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? labelText;
  final bool? enabled; // default is true
  var onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      enabled: enabled,
      minLines: 1,
      maxLines: 5,
      onChanged: onChanged,
    );
  }
}
