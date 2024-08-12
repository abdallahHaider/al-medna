import 'package:flutter/material.dart';

snackBar(BuildContext context,String msg){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      ),
      );
}