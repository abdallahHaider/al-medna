import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/pdf/pdd.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';

class TrapPayPage extends StatefulWidget {
  @override
  State<TrapPayPage> createState() => _TrapPayPageState();
}

class _TrapPayPageState extends State<TrapPayPage> {
  String resslrid = "";

  final costController = TextEditingController();

  final namberController = TextEditingController();

  final uSDController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    Provider.of<TrapPayController>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Header(
                  title: 'التسديدات',
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Provider.of<TrapPayController>(context, listen: false)
                        .addpage(-1);
                  },
                  child: Text("الصفحة السابقة")),
              Consumer<TrapPayController>(
                builder: (context, TrapPayController controller, child) {
                  return Text("الصفحة :${controller.page}");
                },
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<TrapPayController>(context, listen: false)
                        .addpage(1);
                  },
                  child: Text("الصفحة التالية")),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Consumer<TrapPayController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return FutureBuilder(
                          future: value.fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return ErorrWidget();
                            } else if (snapshot.hasData) {
                              return Card(
                                color: secondaryColor,
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: DataTable(
                                    columnSpacing: defaultPadding,
                                    columns: [
                                      DataColumn(
                                        label: Text("اسم الوكيل"),
                                      ),
                                      DataColumn(
                                        label: Text("رقم الوصل"),
                                      ),
                                      DataColumn(
                                        label: Text("المبلغ"),
                                      ),
                                      DataColumn(
                                        label: Text("سعر الصرف"),
                                      ),
                                      DataColumn(
                                        label: Text(" التاريخ"),
                                      ),
                                      DataColumn(
                                        label: Text("الفاتورة"),
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
                                                  snapshot
                                                      .data![index].resellerId
                                                      .toString(),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  snapshot.data![index].id
                                                      .toString(),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  snapshot.data![index].cost
                                                      .toString(),
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  snapshot.data![index].iqdToUsd
                                                      .toString(),
                                                ),
                                              ),
                                              DataCell(
                                                Text(snapshot
                                                    .data![index].createdAt
                                                    .toString()
                                                    .substring(0, 10)),
                                              ),
                                              DataCell(
                                                TextButton(
                                                    onPressed: () async {
                                                      SmartDialog.showLoading();
                                                      try {
                                                        await generatePdfWeb(
                                                            snapshot
                                                                .data![index]
                                                                .resellerId
                                                                .toString(),
                                                            snapshot
                                                                .data![index]
                                                                .cost,
                                                            snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            snapshot
                                                                .data![index]
                                                                .createdAt
                                                                .toString()
                                                                .substring(
                                                                    0, 10),
                                                            snapshot
                                                                .data![index]
                                                                .nowdebt);
                                                      } catch (e) {}
                                                      SmartDialog.dismiss();
                                                    },
                                                    child:
                                                        Text("طباعة الفاتورة")),
                                              ),
                                              DataCell(PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: Text(
                                                      "حذف",
                                                    ),
                                                    onTap: () {
                                                      deletPay(
                                                        context,
                                                        snapshot,
                                                        index,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              )),
                                            ])),
                                  ),
                                ),
                              );
                            } else {
                              return Center(child: Text('لا يوجد تسديد بعد'));
                            }
                          });
                    },
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: secondaryColor,
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Header(
                                  title: 'اضافة تسديد',
                                ),
                                SizedBox(height: defaultPadding),
                                Consumer<ResellerController>(
                                  builder: (BuildContext context, value,
                                      Widget? child) {
                                    return DropdownButtonFormField<dynamic>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "الوكيل",
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      onChanged: (dynamic value) {
                                        resslrid = value.id.toString();
                                      },
                                      items: value.resellerss
                                          .map((dynamic companies) {
                                        return DropdownMenuItem<dynamic>(
                                          value: companies,
                                          child: Text(companies.fullName!),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                                SizedBox(height: defaultPadding),
                                TextFormField(
                                  controller: costController,
                                  decoration: InputDecoration(
                                    labelText: 'المبلغ',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: defaultPadding),
                                SizedBox(height: defaultPadding),
                                TextFormField(
                                  controller: uSDController,
                                  decoration: InputDecoration(
                                    labelText: 'سعر الصرف',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: defaultPadding),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Provider.of<TrapPayController>(
                                                context,
                                                listen: false)
                                            .addReseller(
                                                costController.text.toString(),
                                                namberController.text
                                                    .toString(),
                                                uSDController.text.toString(),
                                                resslrid,
                                                context);
                                        // }
                                      },
                                      child: Text('اضافة'),
                                    ),
                                  ],
                                ),
                              ])),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> deletPay(
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
                                title: 'حذف التسديد ',
                              ),
                              SizedBox(height: defaultPadding),
                              Text("هل انت متاكد من انك تريد حذف التسديد"),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Provider.of<TrapPayController>(
                                              context,
                                              listen: false)
                                          .delete(snapshot.data![index].id,
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
