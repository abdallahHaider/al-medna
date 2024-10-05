import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/hotel_type.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/hotel/hotel_index.dart';
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
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final adressController = TextEditingController();
  double numberRooms = 0;
  double allPrice = 0;
  bool isNewBuy = false;

  @override
  void initState() {
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Header(title: "شراء فندق"),
              SizedBox(
                width: defaultPadding,
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
                child: isNewBuy
                    ? TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'اسم الفندق',
                          border: OutlineInputBorder(),
                        ),
                      )
                    : Consumer<HotelController>(
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
                height: defaultPadding,
              ),
              SizedBox(
                width: 500,
                child: isNewBuy
                    ? TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      )
                    : Consumer<HotelController>(
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
              isNewBuy
                  ? SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<HotelType>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "العنوان",
                        ),
                        onChanged: (value) {
                          adressController.text = value!.name.toString();
                        },
                        items: HotelType.costs.map((HotelType companies) {
                          return DropdownMenuItem<HotelType>(
                            value: companies,
                            child: Text(companies.name),
                          );
                        }).toList(),
                        validator: (value) =>
                            value == null ? 'يرجى اختيار الوكيل' : null,
                      ),
                    )
                  : SizedBox(),
              TextButton(
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(
                    // child: addHotelForm(context),
                    //     );
                    //   },
                    // );
                    setState(() {
                      isNewBuy = !isNewBuy;
                    });
                  },
                  child: isNewBuy
                      ? Text("اختيار فندق موجود")
                      : Text("اضافة فندق جديد")),
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
          SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
              onPressed: () async {
                if (isNewBuy) {
                  await Provider.of<HotelController>(context, listen: false)
                      .addReseller(
                    nameController.text.toString(),
                    phoneController.text.toString(),
                    adressController.text.toString(),
                    context,
                  );
                }

                await Provider.of<HotelController>(context, listen: false)
                    .addBuyHotel(hotelID, moreRooms.text, price.text, day.text,
                        floss.text, rooms.text, context);
              },
              child: Text("اضافة"))
        ]);
  }
}
