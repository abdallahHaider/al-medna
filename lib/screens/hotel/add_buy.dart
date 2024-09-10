import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBuy extends StatefulWidget {
  const AddBuy({super.key});

  @override
  State<AddBuy> createState() => _AddBuyState();
}

class _AddBuyState extends State<AddBuy> {
  String hotelID = "";
  final rooms = TextEditingController();
  final day = TextEditingController();
  final price = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<HotelController>(context, listen: false).getFetchData(true);
    Provider.of<HotelController>(context, listen: false).getFetchData(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "شراء فندق"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(children: [
          SizedBox(
            height: defaultPadding,
          ),
          // MyTextField(
          //   labelText: "اسم المشتري",
          // ),
          SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              // Consumer<HotelController>(
              //   builder: (context, myType, child) {
              //     return ;
              //   },
              // )
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: Consumer<HotelController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return DropdownButtonFormField<dynamic>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "فندق مكة",
                          ),
                          onChanged: (dynamic value) {
                            // setState(() {
                            hotelID = value.id.toString();
                            // });
                          },
                          items: value.hotels.map((companies) {
                            return DropdownMenuItem<dynamic>(
                              value: companies,
                              child: Text(companies.fullName!),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: Consumer<HotelController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return DropdownButtonFormField<dynamic>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "فندق المدينة",
                          ),
                          onChanged: (dynamic value) {
                            // setState(() {
                            hotelID = value.id.toString();
                            // });
                          },
                          items: value.hotelsM.map((companies) {
                            return DropdownMenuItem<dynamic>(
                              value: companies,
                              child: Text(companies.fullName!),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blueGrey[50]),
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          'عدد الغرف',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'عدد الليالي',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'سعر الغرفة',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'مجموع السعر',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child: MyTextField(
                      controller: rooms,
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: day,
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: price,
                    )),
                    TableCell(child: MyTextField()),
                  ],
                ),
              ]),
          ElevatedButton(
              onPressed: () async {
                await Provider.of<HotelController>(context, listen: false)
                    .addBuyHotel(
                        hotelID, rooms.text, price.text, day.text, context);
              },
              child: Text("اضافة"))
        ]),
      ),
    );
  }
}
