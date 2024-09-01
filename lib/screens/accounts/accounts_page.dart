import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final banknameController = TextEditingController();
  final accountsBanknameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Header(
                  title: "البنوك",
                ),
              ),
              Expanded(
                  child: DataTable(columns: [
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('المبلغ')),
                DataColumn(label: Text('تاريخ الانشاء')),
              ], rows: [])),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Header(
                  title: "الصيرفات",
                ),
              ),
              Expanded(
                  child: DataTable(columns: [
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('المبلغ')),
                DataColumn(label: Text('تاريخ الانشاء')),
              ], rows: [])),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(defaultPadding),
                margin: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Form(
                  // key: _formKey,
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
                            if (_formKey.currentState!.validate()) {
                              // await Provider.of<ResellerController>(context,
                              //         listen: false)
                              //     .addReseller(
                              //         nameController.text.toString(),
                              //         phoneController.text.toString(),
                              //         adressController.text.toString(),
                              //         context);
                            }
                          },
                          child: Text('اضافة'),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: Container(
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
                              // await Provider.of<ResellerController>(context,
                              //         listen: false)
                              //     .addReseller(
                              //         nameController.text.toString(),
                              //         phoneController.text.toString(),
                              //         adressController.text.toString(),
                              //         context);
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
        ),
      ]),
    );
  }
}
