import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/models/hotel_type.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/hotel/hotel_profile.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/hotel_controller.dart';
import '../dashboard/components/header.dart';

class HotelPage extends StatefulWidget {
  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  bool showMakkahHotelsBought = true;
  bool showMadinaHotelsBought = false;
  bool showMakkahHotelsSold = true;
  bool showMadinaHotelsSold = false;

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    Provider.of<HotelController>(context, listen: false).fetchData();
    Provider.of<HotelController>(context, listen: false).getFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Header(title: 'الفنادق'),
                ElevatedButton(
                  onPressed: () {
                    // Show add hotel form
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: addHotelForm(context),
                        );
                      },
                    );
                  },
                  child: Text('إضافة فندق'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column for Purchased Hotels
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showMakkahHotelsBought = true;
                                  showMadinaHotelsBought = false;
                                });
                              },
                              child: Text('فنادق مكة - شراء'),
                            ),
                            SizedBox(width: defaultPadding),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showMakkahHotelsBought = false;
                                  showMadinaHotelsBought = true;
                                });
                              },
                              child: Text('فنادق المدينة - شراء'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Consumer<HotelController>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (value.isLading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return hotelTable(
                              value,
                              context,
                              showMakkahHotelsBought
                                  ? value.hotelsK
                                  : showMadinaHotelsBought
                                      ? value.hotelsM
                                      : [],
                              'فنادق تم شراؤها',
                              true,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Right Column for Sold Hotels
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showMakkahHotelsSold = true;
                                    showMadinaHotelsSold = false;
                                  });
                                },
                                child: Text('فنادق مكة - بيع'),
                              ),
                              SizedBox(width: defaultPadding),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showMakkahHotelsSold = false;
                                    showMadinaHotelsSold = true;
                                  });
                                },
                                child: Text('فنادق المدينة - بيع'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Consumer<HotelController>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              if (value.isLading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return hotelTable(
                                value,
                                context,
                                showMakkahHotelsSold
                                    ? value.soldHotelsK
                                    : showMadinaHotelsSold
                                        ? value.soldHotelsM
                                        : [],
                                'فنادق مباعة',
                                false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding addHotelForm(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final adressController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Card(
        color: secondaryColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Header(title: 'اضافة فندق'),
              SizedBox(height: defaultPadding),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'اسم الفندق',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: defaultPadding),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: defaultPadding),
              DropdownButtonFormField<HotelType>(
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
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          adressController.text.isEmpty) {
                        snackBar(context, 'الرجاء ملئ جميع الحقول', true);
                      } else {
                        await Provider.of<HotelController>(context,
                                listen: false)
                            .addReseller(
                          nameController.text.toString(),
                          phoneController.text.toString(),
                          adressController.text.toString(),
                          context,
                        );
                      }
                    },
                    child: Text('اضافة'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card hotelTable(HotelController value, BuildContext context, List hotels,
      String title, bool isBuying) {
    return Card(
      elevation: 5,
      color: secondaryColor,
      margin: EdgeInsets.all(defaultPadding),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: defaultPadding),
            DataTable(
              columns: [
                DataColumn(label: Text('اسم الفندق')),
                DataColumn(label: Text('عدد الغرف')),
                DataColumn(label: Text(' عدد اليلي')),
                DataColumn(label: Text('سعر الغرفة')),
                DataColumn(label: Text('الواصل ')),
                DataColumn(label: Text('الباقي ')),
              ],
              rows: List.generate(hotels.length, (index) {
                Reseller hotel = hotels[index];
                return DataRow(cells: [
                  DataCell(
                    TextButton(
                      onPressed: () {
                        Provider.of<Rootwidget>(context, listen: false)
                            .getWidet(HotelProfile(
                          hotelId: hotel.id.toString(),
                          showBuy: isBuying,
                        ));
                      },
                      child: Text(
                        hotel.fullName.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.address!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.phoneNumber!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.phoneNumber!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      hotel.phoneNumber!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.red,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        deleteHotel(context, hotel, index);
                      },
                      child: Text("حذف"))),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> deleteHotel(
      BuildContext context, Reseller snapshot, int index) {
    return showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            children: [
              SizedBox(
                height: defaultPadding * 2,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Header(title: 'حذف فندق'),
                      SizedBox(height: defaultPadding),
                      Text("هل أنت متأكد من أنك تريد حذف الفندق؟"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await Provider.of<HotelController>(context,
                                      listen: false)
                                  .delete(snapshot.id!, context);
                            },
                            child: Text('حذف'),
                          ),
                          InkWell(
                            child: Text(
                              "إلغاء",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
