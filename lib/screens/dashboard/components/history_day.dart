import 'package:admin/models/history.dart';
import 'package:admin/screens/dashboard/components/show_data_dialog.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controllers/history_controller.dart';

class HistoryDay extends StatelessWidget {
  const HistoryDay({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryController()..getHistory(),
      child: SizedBox(
        child: Consumer<HistoryController>(
          builder: (context, myType, child) {
            if (myType.isHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (myType.isHistoryError) {
              return const Center(
                child: MyErrorWidget(),
              );
            }
            if (myType.history.isEmpty) {
              return const Center(
                child: Text('لايوجد عمليات بعد'),
              );
            }
            return SizedBox(
              width: double.maxFinite,
              child: ListView(
                children: [
                  MyDataTable(
                      columns: [
                        DataColumn(label: Text('القسم')),
                        DataColumn(label: Text('النوع')),
                        DataColumn(label: Text('وصف مختصر')),
                        DataColumn(label: Text('التاريخ')),
                        DataColumn(label: Text('الاجراء')),
                      ],
                      rows: myType.history.map((e) {
                        History history = e;
                        return DataRow(
                            color: WidgetStatePropertyAll(Colors.white),
                            cells: [
                              DataCell(Text(history.title!)),
                              DataCell(Text(myType.getType(history.type!))),
                              DataCell(Text(history.description!)),
                              DataCell(Text(DateFormat('hh:mm a').format(
                                  history.createdAt!.add(Duration(hours: 3))))),
                              DataCell(Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      print(history.details);
                                      showDataDialog(context, history.details!);
                                    },
                                    label: Text("التفاصيل"),
                                    icon: Icon(Icons.details),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      myType.restoreHistory(
                                          context, history.id!);
                                    },
                                    label: Text("تراجع"),
                                    icon: Icon(Icons.settings_backup_restore),
                                  ),
                                ],
                              )),
                            ]);
                      }).toList()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void showDynamicDataDialog(BuildContext context, List dataList) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('عرض القائمة'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dataList.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> data = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'العنصر ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Divider(),
                        ...data.entries.map((e) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${e.key}: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    '${e.value}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
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
    },
  );
}
