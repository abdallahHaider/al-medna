import 'package:admin/responsive.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/hotel_controller.dart';
import '../dashboard/components/header.dart';

class HotelPage extends StatefulWidget {
  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  final nameController = TextEditingController();

  final adressController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  void dispose() {
    Provider.of<HotelController>(context, listen: false).dispose();
    super.dispose();
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
            child: Header(
              title: 'الفنادق',
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Consumer<HotelController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return FutureBuilder(
                          future: value.fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return MyErrorWidget();
                            } else if (snapshot.hasData) {
                              return Card(
                                elevation: 5,
                                color: secondaryColor,
                                margin: EdgeInsets.all(defaultPadding),
                                child: SizedBox(
                                  height: double.maxFinite,
                                  child: DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text('اسم الفندق'),
                                        ),
                                        DataColumn(
                                          label: Text('العنوان'),
                                        ),
                                        DataColumn(
                                          label: Text('رقم الهاتف'),
                                        ),
                                        DataColumn(
                                          label: Text('الاجراء'),
                                        ),
                                      ],
                                      rows: List.generate(snapshot.data!.length,
                                          (index) {
                                        return DataRow(cells: [
                                          DataCell(
                                            Text(
                                              snapshot.data![index].fullName
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].address,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              snapshot.data![index].phoneNumber,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          DataCell(ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                  Colors.red,
                                                ),
                                                foregroundColor:
                                                    WidgetStateProperty.all(
                                                  Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                drletdHotel(
                                                    context, snapshot, index);
                                              },
                                              child: Text("حذف"))),
                                        ]);
                                      })),
                                ),
                              );
                            } else {
                              return Center(child: Text('لا يوجد فنادق بعد'));
                            }
                          });
                    },
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 1,
                    child: Card(
                        color: secondaryColor,
                        elevation: 5,
                        child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Header(
                                    title: 'اضافة فندق',
                                  ),
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
                                  TextFormField(
                                    controller: adressController,
                                    decoration: InputDecoration(
                                      labelText: 'العنوان',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: defaultPadding),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (nameController.text.isEmpty ||
                                              phoneController.text.isEmpty ||
                                              adressController.text.isEmpty) {
                                            snackBar(context,
                                                'الرجاء ملئ جميع الحقول', true);
                                          } else {
                                            await Provider.of<HotelController>(
                                                    context,
                                                    listen: false)
                                                .addReseller(
                                                    nameController.text
                                                        .toString(),
                                                    phoneController.text
                                                        .toString(),
                                                    adressController.text
                                                        .toString(),
                                                    context);
                                          }
                                        },
                                        child: Text('اضافة'),
                                      ),
                                    ],
                                  ),
                                ]))),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> drletdHotel(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot, int index) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                SizedBox(
                  height: defaultPadding * 5,
                ),
                Card(
                    child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Header(
                                title: 'حذف فندق ',
                              ),
                              SizedBox(height: defaultPadding),
                              Text("هل انت متاكد من انك تريد حذف الفندق؟"),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Provider.of<HotelController>(
                                              context,
                                              listen: false)
                                          .delete(snapshot.data![index].id,
                                              context);
                                    },
                                    child: Text('حذف'),
                                  ),
                                  InkWell(
                                    child: Text(
                                      "الغاء",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ]))),
              ],
            ),
          );
        });
  }
}
