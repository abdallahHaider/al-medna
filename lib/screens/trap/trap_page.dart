import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/hotel_controller.dart';
import '../../controllers/reseller_controller.dart';
import '../../controllers/trap_controller .dart';
import '../../models/reseller.dart';
import '../dashboard/components/header.dart';

class TrapPage extends StatelessWidget {
  final duration = TextEditingController();
  final quantity = TextEditingController();
  final price_per_one = TextEditingController();
  final RAS_to_USD = TextEditingController();
  final IQD_to_USD = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Header(
                        title: 'الرحلات',
                      ),
                    ),
                    InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        showDialog(
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
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            child: MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => ResellerController()..getfetchData(),
    ),
    ChangeNotifierProvider(
      create: (context) => HotelController()..getfetchData(),
    ),
    ChangeNotifierProvider(
      create: (context) => TrapController(),
    ),
  ],
  child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Header(
                                                    title: 'اضافة رحلة',
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Consumer<ResellerController>(builder: (BuildContext context, value, Widget? child){
                                                    // value.fetchData();
                                                    return DropdownButtonFormField<dynamic>(
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        labelText: "الوكيل",
                                                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                                                      ),
                                                      onChanged: (dynamic value) {
                                                        print(value.id);
                                                        Provider.of<TrapController>(context,listen: false).resslrid==value.id;
                                                      },
                                                      items: value.resellerss.map((dynamic companies) {
                                                        return DropdownMenuItem<dynamic>(
                                                          value: companies,
                                                          child: Text(companies.fullName!),
                                                        );
                                                      }).toList(),
                                                    );
                                                  }),
                                                  SizedBox(
                                                      height: defaultPadding),


                                                  Consumer<HotelController>(builder: (BuildContext context, value, Widget? child){
                                                    // value.fetchData();
                                                    return DropdownButtonFormField<dynamic>(
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        labelText: "الفندق",
                                                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                                                      ),
                                                      onChanged: (dynamic value) {
                                                        // controller.setSelectedCompanies(value!);
                                                        Provider.of<TrapController>(context,listen: false).trapid==value.id;
                                                      },
                                                      items: value.hotels.map((dynamic companies) {
                                                        return DropdownMenuItem<dynamic>(
                                                          value: companies,
                                                          child: Text(companies.fullName!),
                                                        );
                                                      }).toList(),
                                                    );
                                                  }),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Consumer<TrapController>(builder: (BuildContext context, value, Widget? child){
                                                    // value.fetchData();
                                                    return DropdownButtonFormField<dynamic>(
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        labelText: "الرحلة",
                                                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                                                      ),
                                                      onChanged: (dynamic value) {
                                                        // controller.setSelectedCompanies(value!);
                                                        Provider.of<TrapController>(context,listen: false).transportsid==value.id;
                                                      },
                                                      items: value.transports.map((dynamic companies) {
                                                        return DropdownMenuItem<dynamic>(
                                                          value: companies,
                                                          child: Text(companies.name),
                                                        );
                                                      }).toList(),
                                                    );
                                                  }),
                                                  SizedBox(
                                                      height: defaultPadding),


                                                  TextFormField(
                                                    controller: duration,
                                                    decoration: InputDecoration(
                                                      labelText: 'مدة الرحلة',
                                                      border:
                                                      OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  TextFormField(
                                                    controller: quantity,
                                                    decoration: InputDecoration(
                                                      labelText: 'عدد المسافرين',
                                                      border:
                                                      OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                    TextInputType.phone,
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  TextFormField(
                                                    controller:
                                                    price_per_one,
                                                    decoration: InputDecoration(
                                                      labelText: 'السعر لكل مسافر',
                                                      border:
                                                      OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  TextFormField(
                                                    controller:
                                                    IQD_to_USD,
                                                    decoration: InputDecoration(
                                                      labelText: 'سعر الصرف الدينار',
                                                      border:
                                                      OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  TextFormField(
                                                    controller:
                                                    RAS_to_USD,
                                                    decoration: InputDecoration(
                                                      labelText: 'سعر الصرف الريال',
                                                      border:
                                                      OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: defaultPadding),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                            await Provider.of<
                                                                TrapController>(
                                                                context,
                                                                listen:
                                                                false)
                                                                .addReseller(
                                                                duration
                                                                    .text
                                                                    .toString(),
                                                                quantity
                                                                    .text
                                                                    .toString(),
                                                                price_per_one
                                                                    .text
                                                                    .toString(),
                                                                RAS_to_USD
                                                                    .text
                                                                    .toString(),
                                                                IQD_to_USD
                                                                    .text
                                                                    .toString(),
                                                                context);
                                                            // Provider.of<TrapController>(context,listen: false).addReseller(duration, quantity, price_per_one, RAS_to_USD, IQD_to_USD, context);

                                                        },
                                                        child: Text('اضافة'),
                                                      ),
                                                      InkWell(
                                                        child: Text(
                                                          "الغاء",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.red),
                                                        ),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ]),
))),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 7),
                            child: Text("اضافة رحلة"),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 26, 26, 48),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Consumer<TrapController>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return FutureBuilder(
                                future: value.fetchData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return ErorrWidget();
                                  } else if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: secondaryColor,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      child: Text(snapshot
                                                          .data![index]
                                                          .resellerId!
                                                          .substring(0, 1)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(snapshot
                                                            .data![index]
                                                            .resellerId!),
                                                        Text(snapshot
                                                            .data![index]
                                                            .hotelId
                                                            .toString()),
                                                        Text(snapshot
                                                            .data![index].transport
                                                            .toString()),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                                InkWell(
                                                  hoverColor:
                                                  Colors.transparent,
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (c) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                            Colors
                                                                .transparent,
                                                            content: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                  defaultPadding *
                                                                      5,
                                                                ),
                                                                Card(
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.all(defaultPadding),
                                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                                                          Header(
                                                                            title:
                                                                            'حذف رحلة ',
                                                                          ),
                                                                          SizedBox(
                                                                              height: defaultPadding),
                                                                          Text(
                                                                              "هل انت متاكد من انك تريد حذف الرحلة؟"),
                                                                          SizedBox(height: 10,),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                onPressed: () async {
                                                                                  await Provider.of<ResellerController>(context, listen: false).delete(snapshot
                                                                                      .data![index].id, context);
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
                                                  },
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 10),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 15,
                                                            vertical: 3.5),
                                                        child: Text(
                                                          "حذف الرحلة",
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              30)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                        child: Text('لا يوجد رحلات بعد'));
                                  }
                                });
                          },
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "معلومات عامة عن الرحلات",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
}
