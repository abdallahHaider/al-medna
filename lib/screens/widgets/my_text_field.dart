import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.enabled,
    this.onChanged,
    this.keyboardType,
    this.maxLines,
    this.decoration,
    this.validator,
  });

  final TextEditingController? controller;
  final String? labelText;
  final bool? enabled; // default is true
  var onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;
  final InputDecoration? decoration;
  var validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: decoration ??
          InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
      enabled: enabled,
      minLines: 1,
      maxLines: maxLines ?? 2,
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
