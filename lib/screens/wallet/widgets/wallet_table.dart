import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/pdf/safe_pdf.dart';
import 'package:flutter/material.dart';

Widget walletTable(WalletProvider controller) {
  return SizedBox(
    width: double.maxFinite,
    child: Card(
      color: Colors.white,
      child: DataTable(
        columns: [
          DataColumn(label: Text('ت')),
          DataColumn(label: Text('النوع')),
          DataColumn(label: Text('الاسم')),
          DataColumn(label: Text('المبلغ بالدينار')),
          DataColumn(label: Text('المبلغ بالدولار')),
          DataColumn(label: Text('القيد')),

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
                              ? "قبض"
                              : "صرف")),
                      DataCell(
                          Text(controller.wallets[index].owner.toString())),
                      DataCell(
                          Text("${controller.wallets[index].costIQD ?? ""}")),
                      DataCell(
                          Text("${controller.wallets[index].costUSD ?? ""}")),
                      DataCell(Text(
                          controller.wallets[index].numberKade.toString())),
                      DataCell(Text(controller.wallets[index].createdAt
                          .toString()
                          .substring(0, 10))),
                      DataCell(Text(controller.wallets[index].note.toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                safePdf(controller.wallets[index]);
                              },
                              icon: Icon(Icons.picture_as_pdf)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete_forever))
                        ],
                      ))
                    ])),
      ),
    ),
  );
}
