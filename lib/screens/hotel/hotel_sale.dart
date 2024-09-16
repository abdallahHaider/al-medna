import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/screens/seller/seller_profiel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelSale extends StatefulWidget {
  const HotelSale({
    super.key,
    required this.hotelId,
  });
  final String hotelId;

  @override
  State<HotelSale> createState() => _HotelSaleState();
}

class _HotelSaleState extends State<HotelSale> {
  String curreny = "";
  final ScrollController controllerOne = ScrollController();

  /// صفحة الخاصة بيع الفندق

  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false)
        .getHotelSale(widget.hotelId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Consumer<HotelController>(builder: (
              BuildContext context,
              HotelController hotelController,
              Widget? child,
            ) {
              return Card(
                color: Colors.grey,
                child: Scrollbar(
                  controller: controllerOne,
                  child: SingleChildScrollView(
                    controller: controllerOne,
                    // scrollDirection: Axis.horizontal,
                    child: DataTable(
                        border: TableBorder.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.grey),
                        columns: [
                          DataColumn(label: Text('اسم المشتري')),
                          DataColumn(label: Text('الغرف')),
                          DataColumn(label: Text('الليالي')),
                          DataColumn(label: Text('سعر الغرفة')),
                          DataColumn(label: Text('المتبقي بالدولار')),
                          DataColumn(label: Text('المتبقي بالريال')),
                          DataColumn(label: Text('المبلغ الكلي بالدولار')),
                          DataColumn(label: Text('المبلغ الكلي بالريال')),
                          DataColumn(label: Text('التاريخ')),
                          DataColumn(label: Text('الاجراء')),
                        ],
                        rows: List.generate(hotelController.hotelbuy.length,
                            (index) {
                          HotelBuy hotelBuy = hotelController.hotelbuy[index];
                          return DataRow(
                              color: WidgetStateProperty.all(Colors.white),
                              cells: [
                                DataCell(
                                  Text(
                                    hotelBuy.buyer.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onTap: () => Provider.of<Rootwidget>(context,
                                          listen: false)
                                      .getWidet(SellerProfile(
                                          id: hotelBuy.buyer_id.toString())),
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
                                    "${hotelBuy.roomPricePerNight}  ${hotelBuy.curreny == "usd" ? "دولار" : "ريال"}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    hotelBuy.now_debt_usd.toString(),
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
                                    "${hotelBuy.total_price_usd} ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${hotelBuy.total_price_ras} ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    hotelBuy.createdAt
                                        .toString()
                                        .substring(0, 10),
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
                                    onPressed: () async {
                                      await Provider.of<HotelController>(
                                              context,
                                              listen: false)
                                          .deleted(
                                              hotelBuy.id.toString(), context);
                                    },
                                    child: Text("حذف"))),
                              ]);
                        })),
                  ),
                ),
              );
            })),
      ],
    );
  }
}
