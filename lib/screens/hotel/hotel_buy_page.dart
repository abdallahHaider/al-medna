import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// صفحة الخاصة شراء الفندق

class HotelBuyPage extends StatefulWidget {
  const HotelBuyPage({
    super.key,
    required this.hotelId,
  });
  final String hotelId;

  @override
  State<HotelBuyPage> createState() => _HotelBuyPageState();
}

class _HotelBuyPageState extends State<HotelBuyPage> {
  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false)
        .getHotelBuy(widget.hotelId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelController>(builder: (
      BuildContext context,
      HotelController hotelController,
      Widget? child,
    ) {
      return MyDataTable(
          columns: [
            DataColumn(label: Text('الفندق')),
            DataColumn(label: Text('التاريخ')),
            DataColumn(label: Text('الطابق')),
            DataColumn(label: Text('الغرف لكل طابق')),
            DataColumn(label: Text('الغرف الاضافية')),
            DataColumn(label: Text('الليالي')),
            DataColumn(label: Text('سعر الغرفة')),
            DataColumn(label: Text("المتبقي")),
            DataColumn(label: Text('المبلغ الكلي')),
            DataColumn(label: Text('الاجراء')),
          ],
          rows: List.generate(hotelController.hotelbuy.length, (index) {
            HotelBuy hotelBuy = hotelController.hotelbuy[index];
            return DataRow(
                color: WidgetStateProperty.all(Colors.white),
                cells: [
                  DataCell(
                    Text(
                      hotelBuy.hotelId.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.createdAt.toString().substring(0, 10),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.number_of_floors.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.number_of_rooms_for_each_floor.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.rooms.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.nights.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.roomPricePerNight.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.now_debt_ras.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotelBuy.total_price_ras.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.red,
                        ),
                        foregroundColor: WidgetStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        deleteDialog(context, () async {
                          await hotelController.deleted(
                              hotelBuy.id!.toString(), context, widget.hotelId);
                          hotelController.getHotelBuy(widget.hotelId);
                        });
                      },
                      child: Text("حذف"))),
                ]);
          }));
    });
  }
}
