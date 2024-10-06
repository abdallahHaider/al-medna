import 'package:admin/controllers/accounts_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/edit_widget.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_button.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
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
  final nameEController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  bool isEdit = false;
  String eid = "";

  @override
  void initState() {
    Provider.of<AccountsController>(context, listen: false).getBank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "البنك"),
      ),
      body: Column(
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
                  key: _formKey1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: MyButton(
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
              ),
              if (isEdit)
                SizedBox(
                  width: 500,
                  child: EditWidget(
                      savePressed: () async {
                        try {
                          await Provider.of<AccountsController>(context,
                                  listen: false)
                              .updateBank(eid, nameEController.text);
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
          SizedBox(
            width: defaultPadding,
          ),
          Consumer<AccountsController>(builder: (
            BuildContext context,
            accountsController,
            child,
          ) {
            return MyDataTable(
              expended: true,
              columns: [
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('المبلغ')),
                DataColumn(label: Text('التاريخ')),
                DataColumn(label: Text('الاجراء')),
              ],
              rows: List.generate(
                  accountsController.banks.length,
                  (index) => DataRow(
                          color: WidgetStateProperty.all(Colors.white),
                          cells: [
                            DataCell(TextButton(
                              onPressed: () {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(AcconuntProfael_page(
                                  id: accountsController.banks[index].id
                                      .toString(),
                                  isBank: "B",
                                  name: accountsController.banks[index].name
                                      .toString(),
                                ));
                              },
                              child: Text(accountsController.banks[index].name
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
                                      setState(() {
                                        isEdit = true;
                                        eid = accountsController.banks[index].id
                                            .toString();

                                        nameEController.text =
                                            accountsController.banks[index].name
                                                .toString();
                                      });
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteDialog(context, () async {
                                        await Provider.of<AccountsController>(
                                                context,
                                                listen: false)
                                            .deletbank(
                                                accountsController
                                                    .banks[index].id,
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
          }),
        ],
      ),
    );
  }
}
