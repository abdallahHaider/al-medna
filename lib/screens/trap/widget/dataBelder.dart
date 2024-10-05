import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/trap_controller%20.dart';
import 'package:admin/screens/trap/add_trap.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/note_dialog.dart';
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
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: MyDataTable(
            columns: [
              DataColumn(label: Text('الوكيل')),
              DataColumn(label: Text('عدد المسافرين')),
              DataColumn(label: Text('الأطفال')),
              DataColumn(label: Text('الرضع')),
              DataColumn(label: Text('غ ثنائية')),
              DataColumn(label: Text('غ ثلاثية')),
              DataColumn(label: Text('غ رباعية')),
              DataColumn(label: Text('المسافر الخاص')),
              DataColumn(label: Text('المتبقي')),
              DataColumn(label: Text('تاريخ الإنشاء')),
              DataColumn(label: Text('الملاحظة')),
              DataColumn(label: Text('إجراءات')),
            ],
            rows: widget.traps.map((trap) {
              return DataRow(
                color: WidgetStateProperty.all(Colors.white),
                cells: [
                  DataCell(Text(trap.resellerId ?? '')),
                  DataCell(Text('${trap.quantity ?? 0}')),
                  DataCell(Text('${trap.child ?? 0}')),
                  DataCell(Text('${trap.veryChild ?? 0}')),
                  DataCell(Text('${trap.coupleRoom ?? 0}')),
                  DataCell(Text('${trap.tripleRoom ?? 0}')),
                  DataCell(Text('${trap.quadrupleRoom ?? 0}')),
                  DataCell(Text('${trap.vip_travel ?? 0}')),
                  DataCell(Text('${trap.nowDebt ?? 0}')),
                  DataCell(
                      Text(trap.createdAt?.toString().substring(0, 10) ?? '')),
                  DataCell(SizedBox(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        noteDialog(context, trap.note ?? "");
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
                              realer: trap.resellerId.toString(),
                              hotel: trap.hotelId.toString(),
                              transport: trap.transport.toString(),
                            ));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            deleteDialog(context, () {
                              Provider.of<TrapController>(context,
                                      listen: false)
                                  .delete(trap.id, context);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          )),
    );
  }
}
