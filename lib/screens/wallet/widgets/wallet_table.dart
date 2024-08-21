import 'package:admin/controllers/wallet_provider.dart';
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
          DataColumn(label: Text('المبلغ')),
          DataColumn(label: Text('القيد')),
          DataColumn(label: Text('سعر الصرف')),
          DataColumn(label: Text('التاريخ')),
          DataColumn(label: Text('الملاحظة')),
          // DataColumn(label: Text('الطباعة')),
          // DataColumn(label: Text('الاجراء')),
        ],
        rows: List.generate(
            controller.wallets.length,
            (index) => DataRow(cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(controller.wallets[index].type.toString())),
                  DataCell(Text(controller.wallets[index].owner.toString())),
                  DataCell(Text(controller.wallets[index].cost.toString())),
                  DataCell(
                      Text(controller.wallets[index].numberKade.toString())),
                  DataCell(Text(controller.wallets[index].iqdToUsd.toString())),
                  DataCell(Text(controller.wallets[index].createdAt
                      .toString()
                      .substring(0, 10))),
                  DataCell(Text(controller.wallets[index].note.toString())),
                ])),
      ),
    ),
  );
}
