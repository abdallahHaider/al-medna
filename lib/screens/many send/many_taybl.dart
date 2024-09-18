import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/show_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget manyTaybel(
    WalletProvider controller, BuildContext context, VoidCallback onPressed) {
  final ScrollController controllerOne = ScrollController();
  return SizedBox(
    // width: double.maxFinite,
    child: Card(
      color: Colors.white,
      child: SizedBox(
        width: double.maxFinite,
        child: Scrollbar(
          controller: controllerOne,
          child: SingleChildScrollView(
            controller: controllerOne,
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('ت')),
                DataColumn(label: Text('النوع')),
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('المبلغ بالدينار')),
                DataColumn(label: Text('المبلغ بالدولار')),

                DataColumn(label: Text('التاريخ')),
                DataColumn(label: Text('الملاحظة')),
                // DataColumn(label: Text('الطباعة')),
                DataColumn(label: Text('الاجراء')),
              ],
              rows: List.generate(
                  controller.wallets.length,
                  (index) => DataRow(
                          color:
                              controller.wallets[index].type.toString() == "pay"
                                  ? WidgetStateProperty.all(Colors.grey)
                                  : null,
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(
                                controller.wallets[index].type.toString() ==
                                        "pay"
                                    ? "وارد"
                                    : "صادر")),
                            DataCell(Text(
                                controller.wallets[index].owner.toString())),
                            DataCell(Text(
                                "${controller.wallets[index].costIQD ?? ""}")),
                            DataCell(Text(
                                "${controller.wallets[index].costUSD ?? ""}")),
                            // DataCell(
                            //     Text(controller.wallets[index].id.toString())),
                            DataCell(Text(controller.wallets[index].createdAt
                                .toString()
                                .substring(0, 10))),
                            DataCell(TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (
                                        BuildContext context,
                                      ) {
                                        return ShowNote(
                                            title:
                                                controller.wallets[index].owner,
                                            note:
                                                controller.wallets[index].note);
                                      });
                                },
                                child: Text(
                                    controller.wallets[index].note.length >= 10
                                        ? controller.wallets[index].note
                                            .substring(0, 10)
                                        : controller.wallets[index].note))),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: onPressed,
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteDialog(context, () async {
                                        await Provider.of<WalletProvider>(
                                                context,
                                                listen: false)
                                            .deletWallet(
                                                true,
                                                controller.wallets[index].id,
                                                context);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    )),
                              ],
                            ))
                          ])),
            ),
          ),
        ),
      ),
    ),
  );
}
