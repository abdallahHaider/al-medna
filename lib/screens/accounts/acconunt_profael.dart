import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/transactions.dart';
import 'package:admin/screens/accounts/accounts_page.dart';
import 'package:admin/screens/bank/bank.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AcconuntProfael_page extends StatefulWidget {
  const AcconuntProfael_page(
      {super.key, required this.id, required this.isBank, required this.name});
  final String id;
  final String isBank;
  final String name;

  @override
  State<AcconuntProfael_page> createState() => _AcconuntProfael_pageState();
}
  // دالة لتنسيق الرقم بإضافة الفواصل
  String formatCustomNumber(String value) {
    if (value.isEmpty) return '';
    final number = double.tryParse(value.replaceAll(',', ''));
    if (number == null) return value;
    return NumberFormat('#,##0.00').format(number); // يستخدم هذا التنسيق الفاصلة بين الألوف
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
    } else if (widget.isBank == "H") {
      Provider.of<TransactionsController>(context, listen: false)
          .getmyT(widget.id);
    } else {
      Provider.of<TransactionsController>(context, listen: false)
          .getCompany(widget.id);
    }

    super.initState();
  }

  String formatCustomNumber(String value) {
    if (value.isEmpty) return '';
    final number = double.tryParse(value.replaceAll(',', ''));
    if (number == null) return value;
    return NumberFormat('#,##0')
        .format(number); // يستخدم هذا التنسيق الفاصلة بين الألوف
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: widget.name),
        actions: [
          BackBatten(
            onPressed: () {
              if (widget.isBank == "B") {
                Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(BankPage());
              }
              if (widget.isBank == "S") {
                Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(AccountsPage());
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: blueColor,
                    child: InteractiveViewer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              children: [
                                Text(
                                  'الرصيد بالدينار',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                Consumer<TransactionsController>(
                                  builder: (context, storage, child) {
                                    return Text(
                                      '${formatCustomNumber(double.parse(storage.wallet_IQD).toInt().toString())}',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 140, child: VerticalDivider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              children: [
                                Text(
                                  widget.isBank != "C"
                                      ? 'الرصيد بالدولار'
                                      : "المبلغ بالريال",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                Consumer<TransactionsController>(
                                  builder: (context, storage, child) {
                                    return Text(
                                      '${formatCustomNumber( storage.wallet_USD.toString()) }',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (widget.isBank == "C")
                  LoclPay(
                    id: widget.id,
                  )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                TextButton(
                    onPressed: () {
                      Provider.of<TransactionsController>(context,
                              listen: false)
                          .updete(widget.id, -1);
                    },
                    child: Text("الصفحة السابقة")),
                Consumer(
                  builder: (context, TransactionsController companyController,
                      child) {
                    return Text(
                      "الصفحة الحالية: ${companyController.page}",
                    );
                  },
                ),
                TextButton(
                    onPressed: () {
                      Provider.of<TransactionsController>(context,
                              listen: false)
                          .updete(widget.id, 1);
                    },
                    child: Text("الصفحة التالية")),
                Expanded(child: SizedBox()),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Consumer<TransactionsController>(builder: (
                      BuildContext context,
                      accountsController,
                      Widget? child,
                    ) {
                      return MyDataTable(
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
                            (index) => DataRow(
                                    color:
                                        WidgetStateProperty.all(Colors.white),
                                    cells: [
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
                                                        .mySmallBank[index]
                                                        .costIqd ==
                                                    "0"
                                                ? ""
                                                : accountsController
                                                    .mySmallBank[index].costIqd
                                            : accountsController
                                                        .mySmallBank[index]
                                                        .costRAS ==
                                                    "0"
                                                ? ""
                                                : accountsController
                                                    .mySmallBank[index]
                                                    .costRAS),
                                      ),
                                      DataCell(
                                        Text(accountsController
                                                    .mySmallBank[index].costUsd
                                                    .toString() ==
                                                "0"
                                            ? ""
                                            : accountsController
                                                .mySmallBank[index].costUsd
                                                .toString()),
                                      ),
                                      DataCell(
                                        Text(accountsController
                                            .mySmallBank[index].numberKade
                                            .toString()),
                                      ),
                                      DataCell(Text(accountsController
                                          .mySmallBank[index].createdAt
                                          .toString()
                                          .substring(0, 10))),
                                      DataCell(Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                deleteDialog(context, () async {
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
                    }))),
          ],
        ),
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
      ),
    );
  }
}
