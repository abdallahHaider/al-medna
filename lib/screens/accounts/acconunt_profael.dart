import 'package:admin/controllers/transactions.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class AcconuntProfael_page extends StatefulWidget {
  const AcconuntProfael_page(
      {super.key, required this.id, required this.isBank});
  final String id;
  final String isBank;

  @override
  State<AcconuntProfael_page> createState() => _AcconuntProfael_pageState();
}

class _AcconuntProfael_pageState extends State<AcconuntProfael_page> {
  @override
  void initState() {
    if (widget.isBank == "B") {
      Provider.of<TransactionsController>(context, listen: false)
          .getmyBank(widget.id);
    } else if (widget.isBank == "S") {
      Provider.of<TransactionsController>(context, listen: false)
          .getmySmallBank(widget.id);
    } else {
      Provider.of<TransactionsController>(context, listen: false)
          .getCompany(widget.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Card(
                          color: Colors.white,
                          child: Consumer<TransactionsController>(builder: (
                            BuildContext context,
                            accountsController,
                            Widget? child,
                          ) {
                            return DataTable(
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
                                              ? accountsController
                                                  .mySmallBank[index].costIqd
                                                  .toString()
                                              : accountsController
                                                  .mySmallBank[index].costRAS
                                                  .toString()),
                                        ),
                                        DataCell(
                                          Text(accountsController
                                              .mySmallBank[index].costUsd
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
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text('حذف'),
                                                          content: Text(
                                                              'هل أنت متأكد من حذف هذا الصيرفة'),
                                                          actions: [
                                                            TextButton(
                                                              child: Text('لا'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                                child:
                                                                    Text('نعم'),
                                                                onPressed:
                                                                    () async {
                                                                  try {
                                                                    SmartDialog
                                                                        .showLoading();
                                                                    await Provider.of<TransactionsController>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .deletSmallbank(
                                                                      accountsController
                                                                          .mySmallBank[
                                                                              index]
                                                                          .id,
                                                                    );
                                                                    Navigator.pop(
                                                                        context);
                                                                    snackBar(
                                                                        context,
                                                                        "تم الحذف بنجاح",
                                                                        false);
                                                                  } catch (e) {
                                                                    snackBar(
                                                                        context,
                                                                        e.toString(),
                                                                        true);
                                                                  } finally {
                                                                    SmartDialog
                                                                        .dismiss();
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
                            );
                          }))))),
        ),
        Expanded(
          flex: 1,
          child: Card(
            elevation: 5,
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.account_balance,
                  //   size: 100,
                  // ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'الرصيد بالدينار',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.money),
                      Consumer<TransactionsController>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.wallet_IQD}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    widget.isBank != "C" ? 'الرصيد بالدولار' : "المبلغ بالريال",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money),
                      Consumer<TransactionsController>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.wallet_USD}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  if (widget.isBank == "C")
                    LoclPay(
                      id: widget.id,
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoclPay extends StatelessWidget {
  LoclPay({
    super.key,
    required this.id,
  });
  final String id;
  final costController = TextEditingController();
  final senderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Text(
            'سداد مباشر',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          MyTextField(
            controller: senderController,
            labelText: "اسم المرسل",
          ),
          SizedBox(
            height: 10,
          ),
          MyTextField(
            controller: costController,
            labelText: "المبلغ بالريال",
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  SmartDialog.showLoading();
                  await Provider.of<TransactionsController>(context,
                          listen: false)
                      .SendLocalPay(
                          id, costController.text, senderController.text);
                  snackBar(context, "تم الاضافة بنجاح", false);
                  costController.clear();
                  senderController.clear();
                } catch (e) {
                  print(e);
                  snackBar(context, e.toString(), true);
                } finally {
                  SmartDialog.dismiss();
                }
              },
              child: Text("اضافة"))
        ],
      ),
    );
  }
}
