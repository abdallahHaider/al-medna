import 'package:flutter/material.dart';

import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/reseller/reseller_profiel.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';

// class sellerPage extends StatefulWidget {
//   const sellerPage({super.key});

//   @override
//   State<sellerPage> createState() => _sellerPageState();
// }

// class _sellerPageState extends State<sellerPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text("data"),
//       ),
//     );
//   }
// }

class sellerPage extends StatelessWidget {
  final nameController = TextEditingController();
  final adressController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Header(
                title: 'حسابات المشترين',
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    margin: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Consumer<ResellerController>(
                        builder: (context, controller, child) {
                      return FutureBuilder(
                          future: controller.fetchHotelBuyer(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return MyErrorWidget();
                            } else if (snapshot.hasData) {
                              return DataTable(
                                columnSpacing: defaultPadding,
                                columns: [
                                  DataColumn(
                                    label: Text('التسلسل'),
                                  ),
                                  DataColumn(
                                    label: Text("اسم المشتري"),
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
                                    (index) => DataRow(cells: [
                                          DataCell(
                                            Text(
                                              (index + 1).toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].fullName
                                                  .toString(),
                                            ),
                                            onTap: () =>
                                                Provider.of<Rootwidget>(context,
                                                        listen: false)
                                                    .getWidet(ResellerProfiel(
                                                        resellerID: snapshot
                                                            .data![index])),
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
                                            InkWell(
                                              hoverColor: Colors.transparent,
                                              onTap: () {
                                                dletedReseller(
                                                    context, snapshot, index);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 3.5),
                                                    child: Text(
                                                      "حذف المشتري",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ])),
                              );
                            } else {
                              return Center(child: Text('لا يوجد مشترين بعد'));
                            }
                          });
                    }),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    child: Container(
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
                              title: 'اضافة المشتري',
                            ),
                            SizedBox(height: defaultPadding),
                            MyTextField(
                              controller: nameController,
                              labelText: 'اسم المشتري',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'برجاء ادخال اسم المشتري';
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
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await Provider.of<ResellerController>(
                                            context,
                                            listen: false)
                                        .addHotelBuyer(
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
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dletedReseller(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot, int index) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                SizedBox(
                  height: defaultPadding * 5,
                ),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Header(
                                title: 'حذف المشتري ',
                              ),
                              SizedBox(height: defaultPadding),
                              Text("هل انت متاكد من انك تريد حذف المشتري"),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Provider.of<ResellerController>(
                                              context,
                                              listen: false)
                                          .deleteHotelbuer(
                                              snapshot.data![index].id,
                                              context);
                                    },
                                    child: Text('حذف'),
                                  ),
                                  InkWell(
                                    child: Text(
                                      "الغاء",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ]))),
              ],
            ),
          );
        });
  }
}
