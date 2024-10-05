import 'package:admin/controllers/company_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/campany/company_profiel.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class CampanyPage extends StatefulWidget {
  const CampanyPage({super.key});

  @override
  State<CampanyPage> createState() => _CampanyPageState();
}

class _CampanyPageState extends State<CampanyPage> {
  final banknameController = TextEditingController();
  final accountsBanknameController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<CompanyController>(context, listen: false).getCompanys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "الشركات"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Header(
                    title: 'اضافة شركة',
                  ),
                  SizedBox(height: defaultPadding),
                  MyTextField(
                    controller: banknameController,
                    labelText: 'اسم الشركة',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء ادخال اسم الشركة';
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
                            await Provider.of<CompanyController>(context,
                                    listen: false)
                                .addBank(banknameController.text.toString());
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
          Consumer<CompanyController>(builder: (
            BuildContext context,
            accountsController,
            child,
          ) {
            return MyDataTable(
              expended: true,
              columns: [
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('التاريخ')),
                DataColumn(label: Text('الاجراء')),
              ],
              rows: List.generate(
                  accountsController.companys.length,
                  (index) => DataRow(
                          color: WidgetStateProperty.all(Colors.white),
                          cells: [
                            DataCell(TextButton(
                              onPressed: () {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(CompanyProfilePage(
                                  id: accountsController.companys[index].id
                                      .toString(),
                                  name: accountsController.companys[index].name
                                      .toString(),
                                  // isBank: true,
                                ));
                              },
                              child: Text(accountsController
                                  .companys[index].name
                                  .toString()),
                            )),
                            // DataCell(Text((index + 1).toString())),
                            DataCell(Text(accountsController
                                .companys[index].createdAt
                                .toString()
                                .substring(0, 10))),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      deleteDialog(context, () async {
                                        await Provider.of<CompanyController>(
                                                context,
                                                listen: false)
                                            .deletbank(
                                                accountsController
                                                    .companys[index].id,
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
