import 'package:admin/controllers/accounts_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/edit_widget.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final banknameController = TextEditingController();
  final accountsBanknameController = TextEditingController();
  final nameEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isEdit = false;
  String eid = "";

  @override
  void initState() {
    Provider.of<AccountsController>(context, listen: false).getSmallBank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          title: "المنافذ",
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 500,
                  padding: EdgeInsets.all(defaultPadding),
                  margin: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Header(
                          title: 'اضافة المنفذ',
                        ),
                        SizedBox(height: defaultPadding),
                        MyTextField(
                          controller: accountsBanknameController,
                          labelText: 'اسم  المنفذ',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' برجاء ادخال اسم المنفذ ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  SmartDialog.showLoading();
                                  await Provider.of<AccountsController>(context,
                                          listen: false)
                                      .addSmallBank(accountsBanknameController
                                          .text
                                          .toString());
                                  accountsBanknameController.clear();
                                  snackBar(context, "تمت الاضافة بنجاح", false);
                                } catch (e) {
                                  print(e);
                                  snackBar(context, e.toString(), true);
                                } finally {
                                  SmartDialog.dismiss();
                                }
                              }
                            },
                            child: Text('اضافة'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isEdit)
                  SizedBox(
                    width: 500,
                    child: EditWidget(
                        savePressed: () async {
                          try {
                            await Provider.of<AccountsController>(context,
                                    listen: false)
                                .updateSmallbank(eid, nameEController.text);
                            snackBar(context, "تم التعديل بنجاح", false);
                          } catch (e) {
                            snackBar(context, e.toString(), true);
                          }
                        },
                        canselPressed: () {
                          nameEController.clear();
                          setState(() {
                            isEdit = false;
                          });
                        },
                        buildActions: [
                          MyTextField(
                            controller: nameEController,
                            labelText: 'اسم البنك',
                          )
                        ]),
                  ),
              ],
            ),
            Consumer<AccountsController>(builder: (
              BuildContext context,
              accountsController,
              child,
            ) {
              return SizedBox(
                  width: double.maxFinite,
                  child: MyDataTable(
                    columns: [
                      DataColumn(label: Text('الاسم')),
                      DataColumn(label: Text('المبلغ')),
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('الاجراء')),
                    ],
                    rows: List.generate(
                        accountsController.SmallBank.length,
                        (index) => DataRow(
                                color: WidgetStateProperty.all(Colors.white),
                                cells: [
                                  DataCell(TextButton(
                                    onPressed: () {
                                      Provider.of<Rootwidget>(context,
                                              listen: false)
                                          .getWidet(AcconuntProfael_page(
                                        id: accountsController
                                            .SmallBank[index].id
                                            .toString(),
                                        isBank: "S",
                                        name: accountsController
                                            .SmallBank[index].name
                                            .toString(),
                                      ));
                                    },
                                    child: Text(accountsController
                                        .SmallBank[index].name
                                        .toString()),
                                  )),
                                  DataCell(Text((index + 1).toString())),
                                  DataCell(Text(accountsController
                                      .SmallBank[index].createdAt
                                      .toString()
                                      .substring(0, 10))),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isEdit = true;
                                              eid = accountsController
                                                  .SmallBank[index].id
                                                  .toString();
                                              nameEController.text =
                                                  accountsController
                                                      .SmallBank[index].name
                                                      .toString();
                                            });
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            deleteDialog(context, () async {
                                              await Provider.of<
                                                          AccountsController>(
                                                      context,
                                                      listen: false)
                                                  .deletSmallbank(
                                                      accountsController
                                                          .SmallBank[index].id,
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
                  ));
            }),
          ]),
    );
  }
}
