import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

/// صفحة الخاصة بتسديدات الفندق

class HotelPay extends StatelessWidget {
  const HotelPay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Card(
              color: secondaryColor,
              child: DataTable(columns: [
                DataColumn(label: Text('النوع')),
                DataColumn(label: Text('المبلغ')),
                DataColumn(label: Text('التاريخ')),
              ], rows: []),
            )),
        Expanded(
            child: Card(
          color: secondaryColor,
          child: Column(
            children: [
              MyTextField(
                labelText: 'المبلغ',
              ),
              MyTextField(
                labelText: "المرسل",
              ),
              ElevatedButton(onPressed: () {}, child: Text("اضافة")),
            ],
          ),
        ))
      ],
    );
  }
}
