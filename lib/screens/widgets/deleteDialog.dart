import 'package:flutter/material.dart';

Future<dynamic> deleteDialog(BuildContext context, VoidCallback onPressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("حذف"),
          content: Text("هل انت متاكد من حذف ؟"),
          actions: [
            TextButton(onPressed: onPressed, child: Text("حذف")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("الغاء")),
          ],
        );
      });
}
