import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/type_cost.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSale extends StatefulWidget {
  const AddSale({super.key});

  @override
  State<AddSale> createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  String hotelID = "";
  final rooms = TextEditingController();
  final day = TextEditingController();
  final price = TextEditingController();
  final _nameController = TextEditingController();

  // final _priceUSDController = TextEditingController();
  // final _priceRASController = TextEditingController();
  // final _numberController = TextEditingController();
  // final _roomController = TextEditingController();
  final _reselrID = TextEditingController();
  String curreny = "";
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<HotelController>(context, listen: false).getFetchData(true);
    Provider.of<HotelController>(context, listen: false).getFetchData(false);
    Provider.of<ResellerController>(context, listen: false).fetchHotelBuyer();
    super.initState();
  }

  String Price = "0";
  getPrice() {
    // setState(() {
    //   Price = (double.tryParse(rooms.text.isEmpty ? "0" : rooms.text)! *
    //           double.tryParse(rooms.text.isEmpty ? "0" : rooms.text)! *
    //           double.tryParse(rooms.text.isEmpty ? "0" : rooms.text)!)
    //       .toString();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: "بيع فندق"),
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
          SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              SizedBox(
                width: 500,
                child: Consumer<ResellerController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return DropdownButtonFormField<dynamic>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "الوكيل",
                      ),
                      onChanged: (dynamic value) {
                        _reselrID.text = value.id.toString();
                        _nameController.clear();
                      },
                      items: value.buyers.map((dynamic companies) {
                        return DropdownMenuItem<dynamic>(
                          value: companies,
                          child: Text(companies.fullName!),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'يرجى اختبار الوكيل ' : null,
                    );
                  },
                ),
              ),
              // SizedBox(
              //   width: 500,
              //   child: MyTextField(
              //     controller: _nameController,
              //     labelText: 'اسم المشتري',
              //     onChanged: (v) {
              //       _reselrID.clear();
              //     },
              //   ),
              // ),
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
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
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
                      controller: rooms,
                      onChanged: getPrice(),
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: day,
                      onChanged: getPrice(),
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: price,
                      onChanged: getPrice(),
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: TextEditingController(text: Price),
                      enabled: false,
                    )),
                  ],
                ),
              ]),
          Row(
            children: [
              SizedBox(
                width: 500,
                child: Consumer<ResellerController>(
                  builder: (BuildContext context, value, Widget? child) {
                    return DropdownButtonFormField<dynamic>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "العملة",
                      ),
                      onChanged: (dynamic value) {
                        curreny = value.id.toString();
                        // _nameController.clear();
                      },
                      items: TypeCost2.costs.map((dynamic companies) {
                        return DropdownMenuItem<dynamic>(
                          value: companies,
                          child: Text(companies.name!),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'يرجى اختبار الوكيل ' : null,
                    );
                  },
                ),
              ),
              // SizedBox(
              //   width: 500,
              //   child: MyTextField(
              //     // controller: _priceUSDController,
              //     labelText: 'سعر الغرفة',
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
              onPressed: () async {
                await Provider.of<HotelController>(context, listen: false)
                    .addSaleHotel(
                  hotelID,
                  rooms.text,
                  price.text,
                  curreny,
                  day.text,
                  context,
                  _reselrID.text.toString(),
                  _reselrID.text,
                  // _nameController.text.toString(),
                );
              },
              child: Text("اضافة"))
        ]),
      ),
    );
  }
}
