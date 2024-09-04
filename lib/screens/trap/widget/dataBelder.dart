import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/trap_controller%20.dart';
import 'package:admin/screens/trap/add_trap.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrapTable extends StatefulWidget {
  final List<dynamic> traps;

  TrapTable({required this.traps});

  @override
  State<TrapTable> createState() => _TrapTableState();
}

class _TrapTableState extends State<TrapTable> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      elevation: 5,
      margin: EdgeInsets.all(defaultPadding),
      child: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('الوكيل')),
              // DataColumn(label: Text('الفندق')),
              // DataColumn(label: Text('المدة')),
              DataColumn(label: Text('عدد المسافرين')),
              DataColumn(label: Text('الأطفال')),
              DataColumn(label: Text('الرضع')),
              DataColumn(label: Text('غ ثنائية')),
              DataColumn(label: Text('غ ثلاثية')),
              DataColumn(label: Text('غ رباعية')),
              DataColumn(label: Text('المسافر الخاص')),
              DataColumn(label: Text('المبلغ')),
              DataColumn(label: Text('المتبقي')),
              // DataColumn(label: Text('قيمة الريال بالنسبة للدولار')),
              // DataColumn(label: Text('قيمة الدينار بالنسبة للدولار')),
              // DataColumn(label: Text('وسيلة النقل')),
              DataColumn(label: Text('تاريخ الإنشاء')),
              DataColumn(label: Text('الملاحظة')),
              DataColumn(label: Text('إجراءات')),
            ],
            rows: widget.traps.map((trap) {
              return DataRow(
                cells: [
                  DataCell(Text(trap.resellerId ?? '')),
                  // DataCell(Text(trap.hotelId ?? '')),
                  // DataCell(Text('${trap.duration ?? 0} يوم')),
                  DataCell(Text('${trap.quantity ?? 0}')),
                  DataCell(Text('${trap.child ?? 0}')),
                  DataCell(Text('${trap.veryChild ?? 0}')),
                  DataCell(Text('${trap.coupleRoom ?? 0}')),
                  DataCell(Text('${trap.tripleRoom ?? 0}')),
                  DataCell(Text('${trap.quadrupleRoom ?? 0}')),
                  DataCell(Text('${trap.vip_travel ?? 0}')),
                  DataCell(Text('${trap.price ?? 0}')),
                  DataCell(Text('${trap.nowDebt ?? 0}')),
                  // DataCell(Text('${trap.rasToUsd ?? 0}')),
                  // DataCell(Text('${trap.iqdToUsd ?? 0}')),
                  // DataCell(Text(trap.transport == 'fly' ? 'جوي' : 'بري')),
                  DataCell(
                      Text(trap.createdAt?.toString().substring(0, 10) ?? '')),
                  DataCell(SizedBox(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('ملاحظات'),
                            content: Text(trap.note ?? ''),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('حسناً'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        trap.note.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )),
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
      ),
    );
  }
}
