import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class TrapTable extends StatelessWidget {
  final List<dynamic> traps;

  TrapTable({required this.traps});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      elevation: 5,
      margin: EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('الوكيل')),
            DataColumn(label: Text('الفندق')),
            DataColumn(label: Text('المدة')),
            DataColumn(label: Text('عدد المسافرين')),
            DataColumn(label: Text('عدد الأطفال')),
            DataColumn(label: Text('عدد الرضع')),
            DataColumn(label: Text('غرفة ثنائية')),
            DataColumn(label: Text('غرفة ثلاثية')),
            DataColumn(label: Text('غرفة رباعية')),
            // DataColumn(label: Text('السعر بالدولار لكل مسافر')),
            DataColumn(label: Text('اجمالي المبلغ بالدولار')),
            // DataColumn(label: Text('قيمة الريال بالنسبة للدولار')),
            DataColumn(label: Text('قيمة الدينار بالنسبة للدولار')),
            DataColumn(label: Text('وسيلة النقل')),
            DataColumn(label: Text('تاريخ الإنشاء')),
            DataColumn(label: Text('إجراءات')),
          ],
          rows: traps.map((trap) {
            return DataRow(
              cells: [
                DataCell(Text(trap.resellerId ?? '')),
                DataCell(Text(trap.hotelId ?? '')),
                DataCell(Text('${trap.duration ?? 0} يوم')),
                DataCell(Text('${trap.quantity ?? 0}')),
                DataCell(Text('${trap.child ?? 0}')),
                DataCell(Text('${trap.veryChild ?? 0}')),
                DataCell(Text('${trap.coupleRoom ?? 0}')),
                DataCell(Text('${trap.tripleRoom ?? 0}')),
                DataCell(Text('${trap.quadrupleRoom ?? 0}')),
                // DataCell(Text('\$${trap.pricePerOne ?? 0}')),
                DataCell(Text('${trap.price ?? 0}')),
                // DataCell(Text('${trap.rasToUsd ?? 0}')),
                DataCell(Text('${trap.iqdToUsd ?? 0}')),
                DataCell(Text(trap.transport == 'fly' ? 'جوي' : 'بري')),
                DataCell(
                    Text(trap.createdAt?.toString().substring(0, 10) ?? '')),
                DataCell(
                  Row(
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.edit),
                      //   onPressed: () {
                      //     // Implement edit functionality
                      //   },
                      // ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          // Implement delete functionality
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
