import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// صفحة الخاصة بتسديدات الفندق

class HotelPay extends StatelessWidget {
  const HotelPay({
    super.key,
    required this.hotelID,
  });

  final String hotelID;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer<HotelController>(
          builder: (context, myType, child) {
            return Expanded(
                flex: 2,
                child: Card(
                  child: DataTable(columns: [
                    DataColumn(label: Text('النوع')),
                    DataColumn(label: Text('المبلغ')),
                    DataColumn(label: Text('التاريخ')),
                  ], rows: []),
                ));
          },
        )
        // Expanded(
        //     child: Card(
        //   color: const Color.fromARGB(255, 255, 0, 0),
        //   child: Column(
        //     children: [
        //       MyTextField(
        //         labelText: 'المبلغ',
        //       ),
        //       MyTextField(
        //         labelText: "المرسل",
        //       ),
        //       ElevatedButton(onPressed: () {}, child: Text("اضافة")),
        //     ],
        //   ),
        // ))
      ],
    );
  }
}
