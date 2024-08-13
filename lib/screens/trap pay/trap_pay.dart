import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';

class TrapPayPage extends StatelessWidget {
  final nameController = TextEditingController();
  final adressController = TextEditingController();
  final phoneController = TextEditingController();
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
                        title: 'التسديدات',
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
                                    // Card(
                                    //     child: Padding(
                                    //         padding: const EdgeInsets.all(
                                    //             defaultPadding),
                                    //         child: Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             children: [
                                    //               Header(
                                    //                 title: 'اضافة تسديد',
                                    //               ),
                                    //               SizedBox(
                                    //                   height: defaultPadding),
                                    //               TextFormField(
                                    //                 controller: nameController,
                                    //                 decoration: InputDecoration(
                                    //                   labelText: 'اسم الوكيل',
                                    //                   border:
                                    //                       OutlineInputBorder(),
                                    //                 ),
                                    //               ),
                                    //               SizedBox(
                                    //                   height: defaultPadding),
                                    //               TextFormField(
                                    //                 controller: phoneController,
                                    //                 decoration: InputDecoration(
                                    //                   labelText: 'رقم الهاتف',
                                    //                   border:
                                    //                       OutlineInputBorder(),
                                    //                 ),
                                    //                 keyboardType:
                                    //                     TextInputType.phone,
                                    //               ),
                                    //               SizedBox(
                                    //                   height: defaultPadding),
                                    //               TextFormField(
                                    //                 controller:
                                    //                     adressController,
                                    //                 decoration: InputDecoration(
                                    //                   labelText: 'العنوان',
                                    //                   border:
                                    //                       OutlineInputBorder(),
                                    //                 ),
                                    //               ),
                                    //               SizedBox(
                                    //                   height: defaultPadding),
                                    //               Row(
                                    //                 mainAxisAlignment:
                                    //                     MainAxisAlignment
                                    //                         .spaceBetween,
                                    //                 children: [
                                    //                   ElevatedButton(
                                    //                     onPressed: () async {
                                    //                       if (nameController
                                    //                               .text
                                    //                               .isEmpty ||
                                    //                           phoneController
                                    //                               .text
                                    //                               .isEmpty ||
                                    //                           adressController
                                    //                               .text
                                    //                               .isEmpty) {
                                    //                         snackBar(context,
                                    //                             'الرجاء ملئ جميع الحقول');
                                    //                       } else {
                                    //                         await Provider.of<
                                    //                                     ResellerController>(
                                    //                                 context,
                                    //                                 listen:
                                    //                                     false)
                                    //                             .addReseller(
                                    //                                 nameController
                                    //                                     .text
                                    //                                     .toString(),
                                    //                                 phoneController
                                    //                                     .text
                                    //                                     .toString(),
                                    //                                 adressController
                                    //                                     .text
                                    //                                     .toString(),
                                    //                                 context);
                                    //                       }
                                    //                     },
                                    //                     child: Text('اضافة'),
                                    //                   ),
                                    //                   InkWell(
                                    //                     child: Text(
                                    //                       "الغاء",
                                    //                       style: TextStyle(
                                    //                           color:
                                    //                               Colors.red),
                                    //                     ),
                                    //                     onTap: () {
                                    //                       Navigator.of(context)
                                    //                           .pop();
                                    //                     },
                                    //                   )
                                    //                 ],
                                    //               ),
                                    //             ]))),
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
                            child: Text("اضافة تسديد"),
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
                        child: Consumer<TrapPayController>(
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
                                            height: 100,
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
                                                          .resellerId
                                                          .toString()
                                                          .substring(0, 1)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(snapshot
                                                            .data![index]
                                                            .resellerId!),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(snapshot
                                                    .data![index].payNumber
                                                    .toString()),
                                                Text(snapshot
                                                    .data![index].createdAt
                                                    .toString()
                                                    .substring(0, 10)),
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
                                                                                'حذف التسديد ',
                                                                          ),
                                                                          SizedBox(
                                                                              height: defaultPadding),
                                                                          Text(
                                                                              "هل انت متاكد من انك تريد حذف التسديد"),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                onPressed: () async {
                                                                                  await Provider.of<ResellerController>(context, listen: false).delete(snapshot.data![index].id, context);
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
                                                          "حذف التسديد",
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
                                        child: Text('لا يوجد وكلاء بعد'));
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
                                  "معلومات عامة عن الوكلاء",
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
