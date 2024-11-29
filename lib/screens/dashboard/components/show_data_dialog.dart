import 'package:flutter/material.dart';

void showDataDialog(BuildContext context, Map<String, dynamic> data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      print(data);
      return contents(data['قبل التعديل'] != null, context, data);
    },
  );
}

Widget contents(
    bool isUpdate, BuildContext context, Map<String, dynamic> data) {
  if (isUpdate) {
    Map<String, dynamic> beta = data["قبل التعديل"];
    Map<String, dynamic> heta = data["بعد التعديل"];

    return AlertDialog(
      title: Center(child: Text('تفاصيل التعديل')),
      content: SizedBox(
          width: 510,
             height: 600,
          child: Row(
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: beta.entries.map<Widget>((entry) {
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                  }).toList()..insert(0, Center(child: Text("قبل التعديل",style: TextStyle(fontSize: 20),))),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: heta.entries.map<Widget>((entry) {
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                  }).toList()..insert(0, Center(child: Text("بعد التعديل",style: TextStyle(fontSize: 20),))),
                ),
              ),
            ].reversed.toList(),
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
  }
  return AlertDialog(
    title: Center(child: Text('تفاصيل العنصر')),
    content: SizedBox(
        width: 500,
        height: 600,
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.entries.map((entry) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
            ),
          
        ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('إغلاق'),
      ),
    ],
  );
}
