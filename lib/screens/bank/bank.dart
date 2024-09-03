import 'package:admin/controllers/accounts_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final banknameController = TextEditingController();
  final accountsBanknameController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<AccountsController>(context, listen: false).getBank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Header(title: "البنك"),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Card(
                    color: Colors.white,
                    child:
                        Expanded(child: Consumer<AccountsController>(builder: (
                      BuildContext context,
                      accountsController,
                      child,
                    ) {
                      return DataTable(
                        columns: [
                          DataColumn(label: Text('الاسم')),
                          DataColumn(label: Text('المبلغ')),
                          DataColumn(label: Text('التاريخ')),
                          DataColumn(label: Text('الاجراء')),
                        ],
                        rows: List.generate(
                            accountsController.banks.length,
                            (index) => DataRow(cells: [
                                  DataCell(TextButton(
                                    onPressed: () {
                                      Provider.of<Rootwidget>(context,
                                              listen: false)
                                          .getWidet(AcconuntProfael_page(
                                        id: accountsController.banks[index].id
                                            .toString(),
                                        isBank: true,
                                      ));
                                    },
                                    child: Text(accountsController
                                        .banks[index].name
                                        .toString()),
                                  )),
                                  DataCell(Text((index + 1).toString())),
                                  DataCell(Text(accountsController
                                      .banks[index].createdAt
                                      .toString()
                                      .substring(0, 10))),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('حذف'),
                                                    content: Text(
                                                        'هل أنت متأكد من حذف هذا البنك'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('لا'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                          child: Text('نعم'),
                                                          onPressed: () async {
                                                            try {
                                                              SmartDialog
                                                                  .showLoading();
                                                              await Provider.of<
                                                                          AccountsController>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .deletbank(
                                                                accountsController
                                                                    .banks[
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
                    }))),
              ),
              SizedBox(
                width: defaultPadding,
              ),
              // Expanded(
              //   flex: 1,
              //   child: ActionBankCard(),
              // ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(defaultPadding),
                margin: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Form(
                  key: _formKey1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Header(
                        title: 'اضافة البنك',
                      ),
                      SizedBox(height: defaultPadding),
                      MyTextField(
                        controller: banknameController,
                        labelText: 'اسم البنك',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'برجاء ادخال اسم البنك';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: defaultPadding),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey1.currentState!.validate()) {
                              try {
                                SmartDialog.showLoading();
                                await Provider.of<AccountsController>(context,
                                        listen: false)
                                    .addBank(
                                        banknameController.text.toString());
                                banknameController.clear();
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
              )),
            ],
          ),
        ],
      ),
    );
  }
}
