import 'package:flutter/material.dart';

void showDataDialog(BuildContext context, Map<String, dynamic> data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('تفاصيل العنصر')),
        content: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.entries.map((entry) {
            // if (entry.key == "قبل التعديل") {
            //   MapEntry map = entry.value as MapEntry;
            //   return Column(
            //     children: map.value.map((value) {
            //       return Text(value.key);
            //     }).toList(),
            //   );
            // }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                border: TableBorder.all(
                  color: Colors.grey,
                ),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(
                            child: Text(
                          entry.value.toString(),
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(entry.key,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('إغلاق'),
          ),
        ],
      );
    },
  );
}
