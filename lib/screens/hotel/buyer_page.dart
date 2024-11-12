import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/buyer.dart';
import 'package:admin/pdf/pdd.dart';
import 'package:admin/screens/seller/seller_profiel.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key, required this.hotelID, required this.fullCost});

  final String hotelID;
  final String fullCost;

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
                if (hotelController.isLading) {
                  return Center(child: CircularProgressIndicator());
                }
                return MyDataTable(
                    columns: [
                      DataColumn(label: Text('الاسم')),
                      DataColumn(label: Text('المبلغ بالدولار')),
                      DataColumn(label: Text('المبلغ بالريال')),
                      DataColumn(label: Text('ملاحضة')),
                      DataColumn(label: Text('الاجراء')),
                    ],
                    rows: List.generate(hotelController.buyers.length, (index) {
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
                              onTap: () => Provider.of<Rootwidget>(context,
                                      listen: false)
                                  .getWidet(SellerProfile(
                                      id: hotelBuy.buyer_id.toString())),
                            ),
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
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      try {
                                        // await generateInvoice();
                                        // final pdf = await generateInvoice();
                                        // await Printing.layoutPdf(
                                        //     onLayout:
                                        //         (PdfPageFormat format) async =>
                                        //             pdf.save());
                                        generatePdfWeb(
                                            hotelBuy.buyer.toString(),
                                            hotelBuy.costRas.toString(),
                                            hotelBuy.id.toString(),
                                            DateTime.now()
                                                .toString()
                                                .substring(0, 10),
                                            widget.fullCost);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    icon: Icon(Icons.picture_as_pdf)),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.red,
                                      ),
                                      foregroundColor: WidgetStateProperty.all(
                                        Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (
                                            BuildContext context,
                                          ) {
                                            return AlertDialog(
                                              title: Text("حذف"),
                                              content:
                                                  Text("هل انت متاكد من الحذف"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("الغاء"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    // await Provider.of<>(context,listen: false)
                                                    await hotelController
                                                        .hotelPayDelete(
                                                            hotelBuy.id!,
                                                            context);
                                                  },
                                                  child: Text("حذف"),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Text("حذف")),
                              ],
                            )),
                          ]);
                    }));
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
                  Text("انشاء تسديد جديد"),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
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
