import 'package:admin/controllers/company_controller.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/campany/movrment_page.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../controllers/rootWidget.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key, required this.id});
  final String id;

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    print(widget.id);
    Provider.of<CompanyController>(context, listen: false)
        .getAllData(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(MovementPage(
                                  id: widget.id,
                                ));
                              },
                              child: Text("اضافة حركة")),
                          ElevatedButton(
                              onPressed: () {
                                Provider.of<Rootwidget>(context, listen: false)
                                    .getWidet(AcconuntProfael_page(
                                  id: widget.id,
                                  isBank: "C",
                                ));
                              },
                              child: Text("الحوالات")),
                          Expanded(
                            child: SizedBox(),
                          ),
                          TextButton(
                              onPressed: () {
                                Provider.of<CompanyController>(context,
                                        listen: false)
                                    .updete(widget.id, -1);
                              },
                              child: Text("الصفحة السابقة")),
                          Consumer(
                            builder: (context,
                                CompanyController companyController, child) {
                              return Text(
                                "الصفحة الحالية: ${companyController.page}",
                              );
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                Provider.of<CompanyController>(context,
                                        listen: false)
                                    .updete(widget.id, 1);
                              },
                              child: Text("الصفحة التالية")),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                      Card(
                          color: Colors.white,
                          child: Consumer<CompanyController>(builder: (
                            BuildContext context,
                            accountsController,
                            Widget? child,
                          ) {
                            return Scrollbar(
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(label: Text('المجموعة')),
                                      DataColumn(label: Text('التاشيرة')),
                                      DataColumn(label: Text('السعر')),
                                      DataColumn(label: Text('السعر الكلي')),
                                      DataColumn(label: Text('الفندق')),
                                      DataColumn(label: Text('الغرف')),
                                      DataColumn(label: Text('الليالي')),
                                      DataColumn(label: Text('سعر غرفة')),
                                      DataColumn(label: Text('الاجمالي')),
                                      DataColumn(label: Text('التاريخ')),
                                      DataColumn(label: Text('الاجراء')),
                                    ],
                                    rows: List.generate(
                                        accountsController.myCompanys.length,
                                        (index) => DataRow(cells: [
                                              // DataCell(
                                              //   Text(accountsController
                                              //       .myCompanys[index].groupNumber
                                              //       .toString()),
                                              // ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index]
                                                    .groupNumber
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index].numberT
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index].priceT
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index]
                                                    .totalPriceT
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index].hotelName
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index].rooms
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index].nights
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index]
                                                    .roomPricePerNight
                                                    .toString()),
                                              ),
                                              DataCell(
                                                Text(accountsController
                                                    .myCompanys[index]
                                                    .totalPriceHotel
                                                    .toString()),
                                              ),
                                              // DataCell(Text((index + 1).toString())),
                                              DataCell(Text(accountsController
                                                  .myCompanys[index].createdAt
                                                  .toString()
                                                  .substring(0, 10))),
                                              DataCell(Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title:
                                                                    Text('حذف'),
                                                                content: Text(
                                                                    'هل أنت متأكد من حذف هذا الصيرفة'),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text(
                                                                        'لا'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                      child: Text(
                                                                          'نعم'),
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          SmartDialog
                                                                              .showLoading();
                                                                          await Provider.of<CompanyController>(context, listen: false)
                                                                              .deletCompanyPor(
                                                                            accountsController.myCompanys[index].id,
                                                                          );
                                                                          Navigator.pop(
                                                                              context);
                                                                          snackBar(
                                                                              context,
                                                                              "تم الحذف بنجاح",
                                                                              false);
                                                                        } catch (e) {
                                                                          print(
                                                                              e);
                                                                          snackBar(
                                                                              context,
                                                                              e.toString(),
                                                                              true);
                                                                        } finally {
                                                                          SmartDialog
                                                                              .dismiss();
                                                                        }
                                                                      }),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                      ))
                                                ],
                                              ))
                                            ])),
                                  ),
                                ),
                              ),
                            );
                          })),
                    ],
                  ))),
        ),
        Expanded(
          flex: 1,
          child: Card(
            elevation: 5,
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'المجموع الكلي',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CompanyController>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.total}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'مجموع التاشيرات',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CompanyController>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.total_price_t}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'مجموع حساب الفنادق',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CompanyController>(
                        builder: (context, storage, child) {
                          return Text(
                            '${storage.total_room_price_per_night}ر.ع',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
