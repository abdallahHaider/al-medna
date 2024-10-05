import 'package:admin/controllers/transactions.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

/// صفحة الخاصة بتسديدات الفندق

class HotelPay extends StatefulWidget {
  const HotelPay({
    super.key,
    required this.hotelID,
  });

  final String hotelID;
  final String isBank = "C";

  @override
  State<HotelPay> createState() => _HotelPayState();
}

class _HotelPayState extends State<HotelPay> {
  @override
  void initState() {
    Provider.of<TransactionsController>(context, listen: false)
        .getMyHotelPay(widget.hotelID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<TransactionsController>(
          builder: (context, accountsController, child) {
            return Expanded(
              flex: 2,
              child: Card(
                  child: DataTable(
                columns: [
                  DataColumn(label: Text('المرسل')),
                  DataColumn(label: Text('المستلم')),
                  widget.isBank != "C"
                      ? DataColumn(label: Text('المبلغ بالدينار'))
                      : DataColumn(label: Text('المبلغ بالريال')),
                  DataColumn(label: Text('المبلغ بالدولار')),
                  DataColumn(label: Text('رقم القيد')),
                  DataColumn(label: Text('التاريخ')),
                  DataColumn(label: Text('الاجراء')),
                ],
                rows: List.generate(
                    accountsController.mySmallBank.length,
                    (index) => DataRow(cells: [
                          DataCell(
                            Text(accountsController
                                .mySmallBank[index].senderName
                                .toString()),
                          ),
                          DataCell(
                            Text(accountsController
                                .mySmallBank[index].getterName
                                .toString()),
                          ),
                          DataCell(
                            Text(widget.isBank != "C"
                                ? accountsController.mySmallBank[index].costIqd
                                    .toString()
                                : accountsController.mySmallBank[index].costRAS
                                    .toString()),
                          ),
                          DataCell(
                            Text(accountsController.mySmallBank[index].costUsd
                                .toString()),
                          ),
                          DataCell(
                            Text(accountsController
                                .mySmallBank[index].numberKade
                                .toString()),
                          ),
                          // DataCell(Text((index + 1).toString())),
                          DataCell(Text(accountsController
                              .mySmallBank[index].createdAt
                              .toString()
                              .substring(0, 10))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('حذف'),
                                            content: Text(
                                                'هل أنت متأكد من حذف هذا الصيرفة'),
                                            actions: [
                                              TextButton(
                                                child: Text('لا'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                  child: Text('نعم'),
                                                  onPressed: () async {
                                                    try {
                                                      SmartDialog.showLoading();
                                                      await Provider.of<
                                                                  TransactionsController>(
                                                              context,
                                                              listen: false)
                                                          .deletSmallbank(
                                                              accountsController
                                                                  .mySmallBank[
                                                                      index]
                                                                  .id,
                                                              context);
                                                      Navigator.pop(context);
                                                      snackBar(
                                                          context,
                                                          "تم الحذف بنجاح",
                                                          false);
                                                    } catch (e) {
                                                      snackBar(context,
                                                          e.toString(), true);
                                                    } finally {
                                                      SmartDialog.dismiss();
                                                    }
                                                  }),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ))
                            ],
                          ))
                        ])),
              )),
            );
          },
        )
        // Expanded(
        //     child: Card(
        //   color: const Color.fromARGB(255, 255, 0, 0),
        //   child: Column(
        //     children: [
        //       MyTextField(
        //         labelText: 'المبلغ',
        //       ),
        //       MyTextField(
        //         labelText: "المرسل",
        //       ),
        //       ElevatedButton(onPressed: () {}, child: Text("اضافة")),
        //     ],
        //   ),
        // ))
      ],
    );
  }
}
