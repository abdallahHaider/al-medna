import 'package:flutter/material.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({
    super.key,
    required this.title,
    required this.note,
  });

  final String title;
  final String note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("ملاحظات ${title}"),
        content: SizedBox(
          width: 500,
          child: TextField(
            controller: TextEditingController(text: note),
            maxLines: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ملاحظات',
                filled: true,
                enabled: false),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('الغاء'),
          ),
        ]);
  }
}
