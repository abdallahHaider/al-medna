import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/edit_widget.dart';
import 'package:admin/screens/reseller/reseller_profiel.dart';
import 'package:admin/screens/reseller/widgets/deletedReseller.dart';
import 'package:admin/screens/widgets/my_button.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';

class ResellerPage extends StatefulWidget {
  @override
  State<ResellerPage> createState() => _ResellerPageState();
}

class _ResellerPageState extends State<ResellerPage> {
  final nameController = TextEditingController();
  final adressController = TextEditingController();
  final phoneController = TextEditingController();

  final nameEController = TextEditingController();

  final adressEController = TextEditingController();

  final phoneEController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isEdit = false;
  String eID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  // height: 500,
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
                          title: 'اضافة وكيل',
                        ),
                        SizedBox(height: defaultPadding),
                        MyTextField(
                          controller: nameController,
                          labelText: 'اسم الوكيل',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'برجاء ادخال اسم الوكيل';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: defaultPadding),
                        MyTextField(
                          controller: phoneController,
                          labelText: 'رقم الهاتف',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'يرجى ادخال رقم الهاتف';
                            } else if (value.length < 10 ||
                                value.length > 11 ||
                                !RegExp(r'^\d{11}$').hasMatch(value)) {
                              return 'يرجى ادخال رقم هاتف صحيح';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: defaultPadding),
                        MyTextField(
                          controller: adressController,
                          labelText: 'العنوان',
                          validator: (value) =>
                              value!.isEmpty ? 'ادخل العنوان' : null,
                        ),
                        SizedBox(height: defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await Provider.of<ResellerController>(context,
                                        listen: false)
                                    .addReseller(
                                        nameController.text.toString(),
                                        phoneController.text.toString(),
                                        adressController.text.toString(),
                                        context);
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
                        buildActions: [
                          MyTextField(
                            controller: nameEController,
                            labelText: 'اسم الوكيل',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          MyTextField(
                            controller: phoneEController,
                            labelText: 'رقم الهاتف',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          MyTextField(
                            controller: adressEController,
                            labelText: 'العنوان',
                          ),
                        ],
                        savePressed: () {
                          Provider.of<ResellerController>(context,
                                  listen: false)
                              .updateReseller(
                                  eID,
                                  nameEController.text,
                                  phoneEController.text,
                                  adressEController.text,
                                  context);
                        },
                        canselPressed: () {
                          nameEController.clear();
                          phoneEController.clear();
                          adressEController.clear();
                          setState(() {
                            isEdit = false;
                          });
                        }),
                  ),
              ],
            ),
            Divider(
              color: blueColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Header(title: "الوكلاء"),
            ),
            FutureBuilder(
                future: Provider.of<ResellerController>(context, listen: false)
                    .fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return MyErrorWidget();
                  } else if (snapshot.hasData) {
                    return MyDataTable(
                      expended: true,
                      columns: [
                        DataColumn(
                          label: Text('التسلسل'),
                        ),
                        DataColumn(
                          label: Text("اسم الوكيل"),
                        ),
                        DataColumn(
                          label: Text("المتبقي"),
                        ),
                        DataColumn(
                          label: Text("رقم الهاتف"),
                        ),
                        DataColumn(
                          label: Text("العنوان"),
                        ),
                        DataColumn(
                          label: Text("الاجراء"),
                        ),
                      ],
                      rows: List.generate(
                          snapshot.data!.length,
                          (index) => DataRow(
                                  color: WidgetStateProperty.all(Colors.white),
                                  cells: [
                                    DataCell(
                                      Text(
                                        (index + 1).toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data![index].fullName
                                            .toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                      ),
                                      onTap: () => Provider.of<Rootwidget>(
                                              context,
                                              listen: false)
                                          .getWidet(ResellerProfiel(
                                              resellerID:
                                                  snapshot.data![index])),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data![index].now_debt
                                            .toString(),
                                        style: TextStyle(
                                            color: double.parse(snapshot
                                                        .data![index]
                                                        .now_debt) <
                                                    0
                                                ? Colors.red
                                                : null),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data![index].phoneNumber
                                            .toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data![index].address
                                            .toString(),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                nameEController.text = snapshot
                                                    .data![index].fullName
                                                    .toString();
                                                phoneEController.text = snapshot
                                                    .data![index].phoneNumber
                                                    .toString();
                                                adressEController.text =
                                                    snapshot
                                                        .data![index].address
                                                        .toString();
                                                setState(() {
                                                  isEdit = true;
                                                  eID = snapshot.data![index].id
                                                      .toString();
                                                });
                                              },
                                              icon: Icon(Icons.edit_outlined)),
                                          IconButton(
                                              onPressed: () {
                                                deletedReseller(
                                                    context, snapshot, index);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    )
                                  ])),
                    );
                  } else {
                    return Center(child: Text('لا يوجد وكلاء بعد'));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
