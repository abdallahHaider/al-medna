import 'package:admin/controllers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget manyTaybel(WalletProvider controller, BuildContext context) {
  return SizedBox(
    // width: double.maxFinite,
    child: Card(
      color: Colors.white,
      child: SizedBox(
        width: double.maxFinite,
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
                      color: controller.wallets[index].type.toString() == "pay"
                          ? WidgetStateProperty.all(Colors.grey)
                          : null,
                      cells: [
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(
                            controller.wallets[index].type.toString() == "pay"
                                ? "وارد"
                                : "صادر")),
                        DataCell(
                            Text(controller.wallets[index].owner.toString())),
                        DataCell(
                            Text("${controller.wallets[index].costIQD ?? ""}")),
                        DataCell(
                            Text("${controller.wallets[index].costUSD ?? ""}")),
                        // DataCell(
                        //     Text(controller.wallets[index].id.toString())),
                        DataCell(Text(controller.wallets[index].createdAt
                            .toString()
                            .substring(0, 10))),
                        DataCell(
                            Text(controller.wallets[index].note.toString())),
                        DataCell(IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('حذف'),
                                      content: Text(
                                          'هل أنت متأكد من حذف هذا الرحلة'),
                                      actions: [
                                        TextButton(
                                          child: Text('لا'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                            child: Text('نعم'),
                                            onPressed: () {
                                              Provider.of<WalletProvider>(
                                                      context,
                                                      listen: false)
                                                  .deletWallet(
                                                      true,
                                                      controller
                                                          .wallets[index].id,
                                                      context);
                                            }),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            )))
                      ])),
        ),
      ),
    ),
  );
}
