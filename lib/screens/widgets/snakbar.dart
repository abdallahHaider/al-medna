import 'package:flutter/material.dart';

snackBar(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.vertical,
      behavior: SnackBarBehavior.floating,
      content: Text(msg),
      elevation: 10,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          left: MediaQuery.of(context).size.width - 400,
          right: 10),
    ),
  );
}
