import 'package:flutter/material.dart';

Future<dynamic> noteDialog(BuildContext context, note) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('ملاحظات'),
      content: Text(note ?? ''),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('حسناً'),
        ),
      ],
    ),
  );
}
