import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/pdf/pdd.dart';
import 'package:admin/screens/trap%20pay/widgets/deletPay.dart';
import 'package:admin/screens/trap%20pay/widgets/edit_pay.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

Consumer<TrapPayController> dataTibel() {
  return Consumer<TrapPayController>(
    builder: (BuildContext context, value, Widget? child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: value.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return MyErrorWidget();
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: MyDataTable(
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
                                (index) => DataRow(
                                        color: WidgetStateProperty.all(
                                            Colors.white),
                                        cells: [
                                          DataCell(
                                            Text(
                                              snapshot.data![index].resellerId
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
                                            Text(snapshot.data![index].createdAt
                                                .toString()
                                                .substring(0, 10)),
                                          ),
                                          DataCell(
                                            TextButton(
                                                onPressed: () async {
                                                  SmartDialog.showLoading();
                                                  try {
                                                    await generatePdfWeb(
                                                        snapshot.data![index]
                                                            .resellerId
                                                            .toString(),
                                                        snapshot
                                                            .data![index].cost,
                                                        snapshot.data![index].id
                                                            .toString(),
                                                        snapshot.data![index]
                                                            .createdAt
                                                            .toString()
                                                            .substring(0, 10),
                                                        snapshot.data![index]
                                                            .nowdebt);
                                                  } catch (e) {
                                                    print(e);
                                                    snackBar(context,
                                                        e.toString(), true);
                                                  } finally {
                                                    SmartDialog.dismiss();
                                                  }
                                                },
                                                child: Text("طباعة الفاتورة")),
                                          ),
                                          DataCell(PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Text(
                                                  "تعديل",
                                                ),
                                                onTap: () {
                                                  editPay(context,
                                                      snapshot.data![index].id);
                                                },
                                              ),
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
                          )),
                    );
                  } else {
                    return Center(child: Text('لا يوجد تسديد بعد'));
                  }
                }),
          ],
        ),
      );
    },
  );
}
