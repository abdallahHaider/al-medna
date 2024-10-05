import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/type_cost.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/hotel_index.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
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
  var price = TextEditingController();
  // final _nameController = TextEditingController();

  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  double Price = 0;
  getPrice() {
    setState(() {
      Price = (double.tryParse(rooms.text) ?? 0) *
          (double.tryParse(day.text) ?? 0) *
          (double.tryParse(price.text) ?? 0);
      print(Price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Header(title: "بيع فندق"),
              SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<Rootwidget>(context, listen: false)
                        .getWidet(HotelIndex());
                  },
                  child: Text("عرض الفنادق"))
            ],
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
            ],
          ),
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            width: 500,
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
                    // setState(() {
                    _reselrID.text = value.id.toString();
                    // });
                  },
                  items: value.buyers.map((companies) {
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
            height: defaultPadding,
          ),
          Table(
              // columnWidths: {
              //   0: FlexColumnWidth(1),
              //   1: FlexColumnWidth(1),
              //   2: FlexColumnWidth(1),
              //   3: FlexColumnWidth(1),
              //   4: FlexColumnWidth(2),
              // },
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
                      onChanged: (v) {
                        getPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: day,
                      onChanged: (v) {
                        getPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      controller: price,
                      onChanged: (v) {
                        getPrice();
                      },
                    )),
                    TableCell(
                        child: MyTextField(
                      labelText: Price.toString(),
                      // controller: Te,
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
              child: Text("اضافة")),

          // Container(
          //   padding: EdgeInsets.all(defaultPadding),
          //   margin: EdgeInsets.all(defaultPadding),
          //   decoration: BoxDecoration(
          //     color: secondaryColor,
          //     borderRadius: const BorderRadius.all(Radius.circular(10)),
          //   ),
          //   child: Form(
          //     key: _formKey,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Header(
          //           title: 'اضافة المشتري',
          //         ),
          //         SizedBox(height: defaultPadding),
          //         MyTextField(
          //           controller: nameController,
          //           labelText: 'اسم المشتري',
          //           validator: (value) {
          //             if (value!.isEmpty) {
          //               return 'برجاء ادخال اسم المشتري';
          //             }
          //             return null;
          //           },
          //         ),
          //         SizedBox(height: defaultPadding),
          //         SizedBox(
          //           width: double.infinity,
          //           child: ElevatedButton(
          //             onPressed: () async {
          //               if (_formKey.currentState!.validate()) {
          //                 try {
          //                   await Provider.of<ResellerController>(context,
          //                           listen: false)
          //                       .addHotelBuyer(
          //                           nameController.text, "", "", context);
          //                   Provider.of<ResellerController>(context,
          //                           listen: false)
          //                       .fetchHotelBuyer();
          //                 } catch (e) {
          //                   snackBar(context, e.toString(), true);
          //                 }
          //               }
          //             },
          //             child: Text('اضافة'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ]);
  }
}
