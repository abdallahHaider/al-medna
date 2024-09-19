import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/widgets/add_hotel.dart';
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
  final floss = TextEditingController();
  final moreRooms = TextEditingController();
  final day = TextEditingController();
  final price = TextEditingController();
  double numberRooms = 0;
  double allPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<HotelController>(context, listen: false).getFetchData(true);
    Provider.of<HotelController>(context, listen: false).getFetchData(false);
    super.initState();
  }

  getRooms() {
    setState(() {
      numberRooms = (double.tryParse(rooms.text) ?? 0) *
              (double.tryParse(floss.text) ?? 0) +
          (double.tryParse(moreRooms.text) ?? 0);
    });
  }

  getAllPrice() {
    setState(() {
      allPrice = numberRooms *
          (double.tryParse(day.text) ?? 0) *
          (double.tryParse(price.text) ?? 0);
    });
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
          SizedBox(
            height: defaultPadding,
          ),
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
              TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: addHotelForm(context),
                        );
                      },
                    );
                  },
                  child: Text("اضافة فندق جديد")),
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
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blueGrey[50]),
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          'عدد الطوابق',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'عدد الغرف في كل طابق',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'غرف اضافية',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'مجموع الغرف',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child: MyTextField(
                      controller: floss,
                      onChanged: (v) {
                        getRooms();
                        getAllPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: rooms,
                      onChanged: (v) {
                        getRooms();
                        getAllPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: moreRooms,
                      onChanged: (v) {
                        getRooms();
                        getAllPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      labelText: numberRooms.toString(),
                      // controller: Te,
                      enabled: false,
                    )),
                  ],
                ),
              ]),
          SizedBox(
            height: defaultPadding,
          ),
          Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blueGrey[50]),
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          'عدد الليالي',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'سعر الغرفة',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'مجموع السعر',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                        child: MyTextField(
                      controller: day,
                      onChanged: (v) {
                        getAllPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: price,
                      onChanged: (v) {
                        getAllPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      labelText: allPrice.toString(),
                      // controller: Te,
                      enabled: false,
                    )),
                  ],
                ),
              ]),
          ElevatedButton(
              onPressed: () async {
                await Provider.of<HotelController>(context, listen: false)
                    .addBuyHotel(hotelID, moreRooms.text, price.text, day.text,
                        floss.text, rooms.text, context);
              },
              child: Text("اضافة"))
        ]),
      ),
    );
  }
}
