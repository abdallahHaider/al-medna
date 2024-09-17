import 'package:admin/controllers/accounts_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/edit_widget.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Header(
              title: "الصيرفات",
            ),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Consumer<AccountsController>(builder: (
                    BuildContext context,
                    accountsController,
                    child,
                  ) {
                    return SizedBox(
                        width: double.maxFinite,
                        child: Card(
                            color: Colors.white,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('الاسم')),
                                DataColumn(label: Text('المبلغ')),
                                DataColumn(label: Text('التاريخ')),
                                DataColumn(label: Text('الاجراء')),
                              ],
                              rows: List.generate(
                                  accountsController.SmallBank.length,
                                  (index) => DataRow(cells: [
                                        DataCell(TextButton(
                                          onPressed: () {
                                            Provider.of<Rootwidget>(context,
                                                    listen: false)
                                                .getWidet(AcconuntProfael_page(
                                              id: accountsController
                                                  .SmallBank[index].id
                                                  .toString(),
                                              isBank: "S",
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
                                                            .SmallBank[index]
                                                            .name
                                                            .toString();
                                                  });
                                                },
                                                icon: Icon(Icons.edit)),
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
                                                                    await Provider.of<AccountsController>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .deletSmallbank(
                                                                      accountsController
                                                                          .SmallBank[
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
                            )));
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      if (isEdit)
                        EditWidget(
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
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        margin: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Header(
                                title: 'اضافة الصيرفة',
                              ),
                              SizedBox(height: defaultPadding),
                              MyTextField(
                                controller: accountsBanknameController,
                                labelText: 'اسم مكتب الصيرفة',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'برجاء ادخال اسم المكتب';
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
                                        await Provider.of<AccountsController>(
                                                context,
                                                listen: false)
                                            .addSmallBank(
                                                accountsBanknameController.text
                                                    .toString());
                                        accountsBanknameController.clear();
                                        snackBar(context, "تمت الاضافة بنجاح",
                                            false);
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
                    ],
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
