import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
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
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _numberController = TextEditingController();
  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false)
        .getHotelBuy(widget.hotelId);
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
                color: secondaryColor,
                child: DataTable(
                    columns: [
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('الغرف')),
                      DataColumn(label: Text('الليالي')),
                      DataColumn(label: Text('سعر الغرفة')),
                      DataColumn(label: Text('المبلغ الكلي')),
                      DataColumn(label: Text('اسم الشركة')),
                      DataColumn(label: Text('رقم الحركة')),
                      DataColumn(label: Text('الاجراء')),
                    ],
                    rows:
                        List.generate(hotelController.hotelbuy.length, (index) {
                      HotelBuy hotelBuy = hotelController.hotelbuy[index];
                      return DataRow(cells: [
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
                            hotelBuy.totalPrice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.company.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            hotelBuy.companyProgramId.toString(),
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
                              // drletdHotel(
                              //     context, snapshot, index);
                            },
                            child: Text("حذف"))),
                      ]);
                    })),
              );
            })),
        Expanded(
            child: Card(
          color: secondaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                Consumer<HotelController>(
                    builder: (context, watch, child) => Text(
                          "مجموع الشراء الاجمالي \n${watch.total_cost}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                SizedBox(
                  height: 15,
                ),
                Divider(),
                Text("انشاء حجز جديد"),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _nameController,
                  labelText: 'عدد الغرف',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _numberController,
                  labelText: 'عدد الليالي',
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _priceController,
                  labelText: 'السعر لكل غرفة',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<HotelController>(context, listen: false)
                          .addBuyHotel(
                              widget.hotelId,
                              _nameController.text,
                              _priceController.text,
                              _numberController.text,
                              context);
                    },
                    child: Text("اضافة"))
              ],
            ),
          ),
        ))
      ],
    );
  }
}
