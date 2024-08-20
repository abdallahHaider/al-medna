import 'package:admin/controllers/wallet_provider.dart';
import 'package:flutter/material.dart';

Widget walletTable(WalletProvider controller) {
  return SizedBox(
    width: double.maxFinite,
    child: Card(
      color: Colors.white,
      child: DataTable(
        columns: [
          DataColumn(label: Text('التسلسل')),
          DataColumn(label: Text('النوع')),
          DataColumn(label: Text('الرصيد')),
          DataColumn(label: Text('سعر الصرف')),
          DataColumn(label: Text('الملاحظة')),
          DataColumn(label: Text('الطباعة')),
          DataColumn(label: Text('الاجراء')),
        ],
        rows: List.generate(
            controller.wallets.length,
            (index) => DataRow(cells: [
                  DataCell(Text(controller.wallets[index].balance.toString())),
                  DataCell(
                      Text(controller.wallets[index].operations.toString())),
                ])),
      ),
    ),
  );
}
