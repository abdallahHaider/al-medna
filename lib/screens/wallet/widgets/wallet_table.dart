import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/pdf/safe_pdf.dart';
import 'package:admin/screens/wallet/widgets/wallet_action.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/show_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget walletTable(WalletProvider controller, BuildContext context) {
  ScrollController scrollController = ScrollController();
  return SizedBox(
    width: double.maxFinite,
    child: Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
          controller: scrollController,
          child: MyDataTable(
            columns: [
              DataColumn(label: Text('ت')),
              DataColumn(label: Text('النوع')),
              DataColumn(label: Text('الاسم')),
              DataColumn(label: Text('المبلغ بالدينار')),
              DataColumn(label: Text('المبلغ بالدولار')),
              DataColumn(label: Text('القيد')),
              DataColumn(label: Text('التاريخ')),
              DataColumn(label: Text('الملاحظة')),
              DataColumn(label: Text('الإجراء')),
            ],
            rows: List.generate(
              controller.wallets.length,
              (index) => DataRow(
                color: controller.wallets[index].type.toString() == "pay"
                    ? WidgetStateProperty.all(const Color.fromARGB(255, 146, 218, 164))
                    : WidgetStateProperty.all(Colors.white),
                cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(
                      controller.wallets[index].type.toString() == "pay"
                          ? "قبض"
                          : "صرف")),
                  DataCell(Text(controller.wallets[index].owner.toString())),
                  DataCell(Text("${controller.wallets[index].costIQD ?? ""}")),
                  DataCell(Text("${controller.wallets[index].costUSD ?? ""}")),
                  DataCell(Text(controller.wallets[index].id.toString())),
                  DataCell(Text(controller.wallets[index].createdAt
                      .toString()
                      .substring(0, 10))),
                  DataCell(
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowNote(
                              title: controller.wallets[index].owner.toString(),
                              note: controller.wallets[index].note.toString(),
                            );
                          },
                        );
                      },
                      child: Text(controller.wallets[index].note.length >= 10
                          ? controller.wallets[index].note
                              .toString()
                              .substring(0, 10)
                          : controller.wallets[index].note.toString()),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            safePdf(controller.wallets[index]);
                          },
                          icon: Icon(Icons.picture_as_pdf),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteDialog(context, () {
                              Provider.of<WalletProvider>(context,
                                      listen: false)
                                  .deletWallet(false,
                                      controller.wallets[index].id, context);
                            });
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                        // زر تعديل البيانات
                        IconButton(
                          onPressed: () {
                            Provider.of<Rootwidget>(context, listen: false)
                                .getWidet(WalletAction(
                              isAdd: false,
                              cost_AQR:
                                  "${controller.wallets[index].costIQD ??  ""}",
                              cost_USD:
                                  "${controller.wallets[index].costUSD ?? ""}",
                              not: controller.wallets[index].note.toString(),
                              id: controller.wallets[index].id.toString(),
                            ));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    ),
  );
}
