import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/trap_controller%20.dart';
import 'package:admin/screens/trap/add_trap.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrapTableReseller extends StatefulWidget {
  final List<dynamic> traps;

  TrapTableReseller({required this.traps});

  @override
  State<TrapTableReseller> createState() => _TrapTableResellerState();
}

class _TrapTableResellerState extends State<TrapTableReseller> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: MyDataTable(
          expended: false,
          columns: [
            DataColumn(label: Text('رقم الفاتورة')),
            DataColumn(label: Text('رقم الرحلة')),
            DataColumn(label: Text('اجمالي المبلغ بالدولار')),
            // DataColumn(label: Text('قيمة الدينار بالنسبة للدولار')),
            DataColumn(label: Text('الفندق')),
            DataColumn(label: Text('المدة')),
            DataColumn(label: Text('عدد المسافرين')),
            DataColumn(label: Text('عدد الأطفال')),
            DataColumn(label: Text('عدد الرضع')),
            DataColumn(label: Text('غرفة ثنائية')),
            DataColumn(label: Text('غرفة ثلاثية')),
            DataColumn(label: Text('غرفة رباعية')),
            DataColumn(label: Text('وسيلة النقل')),
            DataColumn(label: Text('المتبقي')),
            DataColumn(label: Text('تاريخ الإنشاء')),
            DataColumn(label: Text('إجراءات')),
          ],
          rows: widget.traps.map((trap) {
            bool ispay = trap.type == "trap_pay" ? true : false;
            return DataRow(
              color: ispay
                  ? WidgetStateProperty.all(Colors.white)
                  : WidgetStateProperty.all(Colors.grey.shade400),
              cells: [
                DataCell(Text("${ispay ? trap.id ?? '' : ""}")),
                DataCell(Text("${!ispay ? trap.id ?? '' : ""}")),
                DataCell(Text('${trap.price ?? 0}')),
                // DataCell(Text('${trap.iqdToUsd ?? 0}')),
                DataCell(Text(ispay ? "" : trap.hotelId ?? '')),
                DataCell(Text('${ispay ? "" : trap.duration ?? 0}')),
                DataCell(Text('${ispay ? "" : trap.quantity ?? 0}')),
                DataCell(Text('${ispay ? "" : trap.child ?? 0}')),
                DataCell(Text('${ispay ? "" : trap.veryChild ?? 0}')),
                DataCell(Text('${ispay ? "" : trap.coupleRoom ?? 0}')),
                DataCell(Text('${ispay ? "" : trap.tripleRoom ?? 0}')),
                DataCell(Text('${ispay ? "" : trap.quadrupleRoom ?? 0}')),
                // DataCell(Text('\$${trap.pricePerOne ?? 0}')),

                // DataCell(Text('${trap.rasToUsd ?? 0}')),
                DataCell(Text(ispay
                    ? ""
                    : trap.transport == 'fly'
                        ? 'جوي'
                        : 'بري')),
                DataCell(Text('${trap.nowDebt ?? 0}')),
                DataCell(
                    Text(trap.createdAt?.toString().substring(0, 10) ?? '')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Provider.of<Rootwidget>(context, listen: false)
                              .getWidet(AddTrapPage(
                            trapId: trap.id,
                            duration: trap.duration.toString(),
                            quantity: trap.quantity.toString(),
                            iqdToUsd: trap.iqdToUsd.toString(),
                            doubleRoomPrice: trap.priceCoupleRoom.toString(),
                            tripleRoomPrice: trap.priceTripleRoom.toString(),
                            quadrupleRoomPrice:
                                trap.priceQuadrupleRoom.toString(),
                            doubleRoomCount: trap.coupleRoom.toString(),
                            tripleRoomCount: trap.tripleRoom.toString(),
                            quadrupleRoomCount: trap.quadrupleRoom.toString(),
                            childrenCount: trap.child.toString(),
                            childrenPrice: trap.priceChild.toString(),
                            infantsCount: trap.veryChild.toString(),
                            isEdidt: true,
                            infantsPrice: trap.priceVeryChild.toString(),
                            notesController: trap.note.toString(),
                            vipController: trap.vip_travel.toString(),
                            priceVipController:
                                trap.price_vip_travel.toString(),
                          ));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          // Implement delete functionality
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('حذف'),
                                  content:
                                      Text('هل أنت متأكد من حذف هذا الرحلة'),
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
                                          Provider.of<TrapController>(context,
                                                  listen: false)
                                              .delete(trap.id, context);
                                        }),
                                  ],
                                );
                              });
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
