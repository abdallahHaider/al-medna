import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/models/type_cost.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
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
  final _nameController = TextEditingController();

  final _priceUSDController = TextEditingController();
  // final _priceRASController = TextEditingController();
  final _numberController = TextEditingController();
  final _roomController = TextEditingController();
  final _reselrID = TextEditingController();
  String curreny = "";

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
                child: DataTable(
                    border: TableBorder.all(
                        width: 1, style: BorderStyle.solid, color: Colors.grey),
                    columns: [
                      DataColumn(label: Text('اسم المشتري')),
                      DataColumn(label: Text('الغرف')),
                      DataColumn(label: Text('الليالي')),
                      DataColumn(label: Text('سعر الغرفة')),
                      DataColumn(label: Text('المبلغ الكلي')),
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('الاجراء')),
                    ],
                    rows:
                        List.generate(hotelController.hotelbuy.length, (index) {
                      HotelBuy hotelBuy = hotelController.hotelbuy[index];
                      return DataRow(
                          color: WidgetStateProperty.all(Colors.white),
                          cells: [
                            DataCell(
                              Text(
                                hotelBuy.reseller.toString(),
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
                                "${hotelBuy.totalPrice} ${hotelBuy.curreny == "usd" ? "دولار" : "ريال"}",
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
                                  await Provider.of<HotelController>(context,
                                          listen: false)
                                      .deleted(hotelBuy.id.toString(), context);
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
                // Text("انشاء حجز جديد"),
                // SizedBox(
                //   height: 20,
                // ),
                // Consumer<ResellerController>(
                //   builder: (BuildContext context, value, Widget? child) {
                //     return DropdownButtonFormField<dynamic>(
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         labelText: "الوكيل",
                //       ),
                //       onChanged: (dynamic value) {
                //         _reselrID.text = value.id.toString();
                //         _nameController.clear();
                //       },
                //       items: value.resellerss.map((dynamic companies) {
                //         return DropdownMenuItem<dynamic>(
                //           value: companies,
                //           child: Text(companies.fullName!),
                //         );
                //       }).toList(),
                //       validator: (value) =>
                //           value == null ? 'يرجى اختبار الوكيل ' : null,
                //     );
                //   },
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // MyTextField(
                //   controller: _nameController,
                //   labelText: 'اسم المشتري',
                //   onChanged: (v) {
                //     _reselrID.clear();
                //   },
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // MyTextField(
                //   controller: _roomController,
                //   labelText: 'عدد الغرف',
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // MyTextField(
                //   controller: _numberController,
                //   labelText: 'عدد الليالي',
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // DropdownButtonFormField<dynamic>(
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     labelText: "العملة",
                //   ),
                //   onChanged: (dynamic value) {
                //     curreny = value.id.toString();
                //     // _nameController.clear();
                //   },
                //   items: TypeCost2.costs.map((dynamic companies) {
                //     return DropdownMenuItem<dynamic>(
                //       value: companies,
                //       child: Text(companies.name!),
                //     );
                //   }).toList(),
                //   validator: (value) =>
                //       value == null ? 'يرجى اختبار الوكيل ' : null,
                // ),
                // MyTextField(
                //   controller: _priceUSDController,
                //   labelText: 'سعر الغرفة',
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       Provider.of<HotelController>(context, listen: false)
                //           .addSaleHotel(
                //         widget.hotelId,
                //         _roomController.text.toString(),
                //         _priceUSDController.text.toString(),
                //         curreny,
                //         _numberController.text.toString(),
                //         context,
                //         _reselrID.text.toString(),
                //         _nameController.text.toString(),
                //       );
                //     },
                //     child: Text("اضافة"))
              ],
            ),
          ),
        ))
      ],
    );
  }
}
