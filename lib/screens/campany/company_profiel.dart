import 'package:admin/controllers/company_controller.dart';
import 'package:admin/models/companyy.dart';
import 'package:admin/screens/accounts/acconunt_profael.dart';
import 'package:admin/screens/campany/campany_page.dart';
import 'package:admin/screens/campany/movrment_page.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/screens/widgets/deleteDialog.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spelling_number/spelling_number.dart';

import '../../controllers/rootWidget.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  ScrollController _scrollController = ScrollController();
  bool showT = false;

  @override
  void initState() {
    print(widget.id);
    Provider.of<CompanyController>(context, listen: false)
        .getAllData(widget.id);
    Provider.of<CompanyController>(context, listen: false).showT = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: widget.name),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(CampanyPage());
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTable(),
          Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    // width: double.maxFinite,
                    child: SingleChildScrollView(
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
                                  name: '',
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
                      SizedBox(
                        width: double.maxFinite,
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
                                child: MyDataTable(
                                  columns: [
                                    if (accountsController.showT)
                                      DataColumn(label: Text('المجموعة')),
                                    if (accountsController.showT)
                                      DataColumn(label: Text('التاشيرة')),
                                    if (accountsController.showT)
                                      DataColumn(label: Text('السعر')),
                                    if (accountsController.showT)
                                      DataColumn(label: Text('السعر الكلي')),
                                    DataColumn(label: Text('ف مكة')),
                                    DataColumn(label: Text('غ مكة')),
                                    DataColumn(label: Text('ليالي م')),
                                    DataColumn(label: Text('سعر غرفة م')),
                                    DataColumn(label: Text('ف مدينة')),
                                    DataColumn(label: Text('غ مدينة')),
                                    DataColumn(label: Text('ليل مدينة')),
                                    DataColumn(label: Text('س غ مدينة')),
                                    DataColumn(label: Text('اجمالي ف')),
                                    DataColumn(label: Text('اجمالي كلي')),
                                    DataColumn(label: Text('التاريخ')),
                                    DataColumn(label: Text('الاجراء')),
                                  ],
                                  rows: List.generate(
                                      accountsController.myCompanys.length,
                                      (index) {
                                    Companyy companyy =
                                        accountsController.myCompanys[index];

                                    if (companyy.numberT! > 0) {}

                                    return DataRow(
                                        color: WidgetStateProperty.all(
                                            Colors.white),
                                        cells: [
                                          if (accountsController.showT)
                                            DataCell(
                                              Text(companyy.groupNumber
                                                  .toString()),
                                            ),
                                          if (accountsController.showT)
                                            DataCell(
                                              Text(companyy.numberT.toString()),
                                            ),
                                          if (accountsController.showT)
                                            DataCell(
                                              Text(companyy.priceT.toString()),
                                            ),
                                          if (accountsController.showT)
                                            DataCell(
                                              Text(companyy.totalPriceT
                                                  .toString()),
                                            ),
                                          DataCell(
                                            Text(companyy.hotelNameMaka!),
                                          ),
                                          DataCell(
                                            Text(companyy.roomsMaka == 0
                                                ? ""
                                                : companyy.roomsMaka
                                                    .toString()),
                                          ),
                                          DataCell(
                                            Text(companyy.nightsMaka == 0
                                                ? ""
                                                : companyy.nightsMaka
                                                    .toString()),
                                          ),
                                          DataCell(
                                            Text(companyy
                                                        .roomPricePerNightMaka ==
                                                    0
                                                ? ""
                                                : companyy.roomPricePerNightMaka
                                                    .toString()),
                                          ),
                                          //
                                          DataCell(
                                            Text(companyy.hotelName!),
                                          ),
                                          DataCell(
                                            Text(companyy.rooms == 0
                                                ? ""
                                                : companyy.rooms.toString()),
                                          ),
                                          DataCell(
                                            Text(companyy.nights == 0
                                                ? ""
                                                : companyy.nights.toString()),
                                          ),
                                          DataCell(
                                            Text(companyy.roomPricePerNight == 0
                                                ? ""
                                                : companyy.roomPricePerNight
                                                    .toString()),
                                          ),
                                          //
                                          DataCell(
                                            Text(companyy.totalPriceHotel
                                                .toString()),
                                          ),
                                          DataCell(
                                            Text(companyy.total_price
                                                .toString()),
                                          ),
                                          // DataCell(Text((index + 1).toString())),
                                          DataCell(Text(companyy.createdAt
                                              .toString()
                                              .substring(0, 10))),
                                          DataCell(Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    deleteDialog(context,
                                                        () async {
                                                      await Provider.of<
                                                                  CompanyController>(
                                                              context,
                                                              listen: false)
                                                          .deletCompanyPor(
                                                              accountsController
                                                                  .myCompanys[
                                                                      index]
                                                                  .id,
                                                              context);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          ))
                                        ]);
                                  }),
                                )),
                          );
                        }),
                      ),
                    ],
                  ),
                ))),
          ),
        ],
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          'الحساب بالريال',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Table
        Table(
          border: TableBorder.all(color: Colors.grey, width: 1),
          children: [
            _buildTableRow(
                'مجموع حساب التاشيرات',
                (storage) => storage.total_price_t,
                (storage) => storage.convertTashera(),
                (storage) => storage.isTashera,
                20),
            _buildTableRow(
                'مجموع حساب الفنادق',
                (storage) => storage.total_room_price_per_night,
                (storage) => storage.convertHotel(),
                (storage) => storage.ishotel,
                20),
            _buildTableRow(
                'المجموع الكلي',
                (storage) => storage.total,
                (storage) => storage.convertTotal(),
                (storage) => storage.istotal,
                20),
            _buildTableRow(
                'مجموع التسديد',
                (storage) => storage.pay,
                (storage) => storage.convertPay(),
                (storage) => storage.ispay,
                20),
            _buildTableRow(
                'المجموع المتبقي',
                (storage) => storage.rest,
                (storage) => storage.convertrest(),
                (storage) => storage.isrest,
                20),
            _buildTableRow(
                'المجموع المتبقي بل الدولار',
                (storage) => (double.parse(storage.rest) / 3.75).toString(),
                (storage) => storage.convertRestUsd(),
                (storage) => storage.isrestUSD,
                20),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    String title,
    String Function(CompanyController) valueExtractor,
    void Function(CompanyController) converter,
    bool Function(CompanyController) isSpelling,
    double fontSize,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
        Consumer<CompanyController>(
          builder: (context, storage, child) {
            return InkWell(
              onTap: () => converter(storage),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${isSpelling(storage) ? SpellingNumber(lang: 'ar').convert(double.parse(valueExtractor(storage)).toInt().abs()) : double.parse(valueExtractor(storage)).toInt().toString()}',
                  style: TextStyle(
                    color: double.parse(valueExtractor(storage)).toInt() < 0
                        ? Colors.red
                        : null,
                    fontSize: isSpelling(storage) ? 15 : fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
