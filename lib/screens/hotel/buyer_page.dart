import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/buyer.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key, required this.hotelID});

  final String hotelID;

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  final buyerID = TextEditingController();
  final cost = TextEditingController();
  final note = TextEditingController();

  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false)
        .getHotelPay(widget.hotelID);
    Provider.of<ResellerController>(context, listen: false).fetchHotelBuyer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 4,
              child: Consumer<HotelController>(builder: (
                BuildContext context,
                HotelController hotelController,
                Widget? child,
              ) {
                return Card(
                  color: Colors.grey,
                  child: DataTable(
                      border: TableBorder.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.grey),
                      columns: [
                        DataColumn(label: Text('الاسم')),
                        // DataColumn(label: Text('التاريخ')),
                        DataColumn(label: Text('المبلغ بالدولار')),
                        DataColumn(label: Text('المبلغ بالريال')),
                        DataColumn(label: Text('ملاحضة')),
                        // DataColumn(label: Text('المبلغ الكلي')),
                        // DataColumn(label: Text('اسم الشركة')),
                        // DataColumn(label: Text('رقم الحركة')),
                        // DataColumn(label: Text('الاجراء')),
                      ],
                      rows:
                          List.generate(hotelController.buyers.length, (index) {
                        Buyer hotelBuy = hotelController.buyers[index];
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
                              ),
                              // DataCell(
                              //   Text(
                              //     hotelBuy.createdAt
                              //         .toString()
                              //         .substring(0, 10),
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              DataCell(
                                Text(
                                  hotelBuy.costUsd.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  hotelBuy.costRas.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  hotelBuy.note.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // DataCell(
                              //   Text(
                              //     hotelBuy.totalPrice.toString(),
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              // DataCell(
                              //   Text(
                              //     hotelBuy.company.toString(),
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              // DataCell(
                              //   Text(
                              //     hotelBuy.companyProgramId.toString(),
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              // DataCell(ElevatedButton(
                              //     style: ButtonStyle(
                              //       backgroundColor: WidgetStateProperty.all(
                              //         Colors.red,
                              //       ),
                              //       foregroundColor: WidgetStateProperty.all(
                              //         Colors.white,
                              //       ),
                              //     ),
                              //     onPressed: () {
                              //       // drletdHotel(
                              //       //     context, snapshot, index);
                              //     },
                              //     child: Text("حذف"))),
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
                  // Consumer<HotelController>(
                  //     builder: (context, watch, child) => Text(
                  //           "مجموع الشراء الاجمالي \n${watch.total_cost}",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //           ),
                  //         )),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Divider(),
                  Text("انشاء تسديد جديد"),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    // width: 500,
                    child: Consumer<ResellerController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return DropdownButtonFormField<dynamic>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "المشتري",
                          ),
                          onChanged: (dynamic value) {
                            buyerID.text = value.id.toString();
                            // _nameController.clear();
                          },
                          items: value.buyers.map((dynamic companies) {
                            return DropdownMenuItem<dynamic>(
                              value: companies,
                              child: Text(companies.fullName!),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'يرجى اختبار المشتري ' : null,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: cost,
                    labelText: 'المبلغ بالدولار',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: note,
                    labelText: 'ملاحظة',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await Provider.of<HotelController>(context,
                                listen: false)
                            .addSalepay(widget.hotelID, buyerID.text, cost.text,
                                note.text.isEmpty ? "_" : note.text, context);
                      },
                      child: Text("اضافة"))
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
