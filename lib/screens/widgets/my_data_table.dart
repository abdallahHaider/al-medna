import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class MyDataTable extends StatelessWidget {
  const MyDataTable(
      {super.key, required this.columns, required this.rows, this.expended});
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final bool? expended;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: expended == true ? double.maxFinite : null,
      // padding: EdgeInsets.all(defaultPadding),
      margin: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: DataTable(
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Color.fromRGBO(185, 185, 185, 1),
            width: 1,
          ),
        ),
        // decoration: BoxDecoration(color: blueColor),
        border: TableBorder.all(color: Colors.grey, width: 1),
        dataTextStyle: TextStyle(color: Colors.black),
        headingTextStyle: TextStyle(color: Color.fromRGBO(76, 110, 144, 1)),
        columns: columns,
        rows: rows,
      ),
    );
  }
}
