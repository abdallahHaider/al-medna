import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/seller/seller_profiel.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:flutter/material.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';

class sellerPage extends StatelessWidget {
  final nameController = TextEditingController();
  final adressController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          title: 'حسابات المشترين',
        ),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(HotelPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 500,
              padding: EdgeInsets.all(defaultPadding),
              margin: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Header(
                      title: 'اضافة المشتري',
                    ),
                    SizedBox(height: defaultPadding),
                    MyTextField(
                      controller: nameController,
                      labelText: 'اسم المشتري',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'برجاء ادخال اسم المشتري';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: defaultPadding),
                    MyTextField(
                      controller: phoneController,
                      labelText: 'رقم الهاتف',
                      keyboardType: TextInputType.phone,
                      validator: (value) {},
                    ),
                    SizedBox(height: defaultPadding),
                    MyTextField(
                      controller: adressController,
                      labelText: 'العنوان',
                    ),
                    SizedBox(height: defaultPadding),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await Provider.of<ResellerController>(context,
                                    listen: false)
                                .addHotelBuyer(
                                    nameController.text,
                                    phoneController.text,
                                    adressController.text,
                                    context);
                          }
                        },
                        child: Text('اضافة'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<ResellerController>(builder: (context, controller, child) {
              return FutureBuilder(
                  future: controller.fetchHotelBuyer(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return MyErrorWidget();
                    } else if (snapshot.hasData) {
                      return MyDataTable(
                        expended: true,
                        columns: [
                          DataColumn(
                            label: Text('التسلسل'),
                          ),
                          DataColumn(
                            label: Text("اسم المشتري"),
                          ),
                          DataColumn(
                            label: Text("رقم الهاتف"),
                          ),
                          DataColumn(
                            label: Text("العنوان"),
                          ),
                          DataColumn(
                            label: Text("الاجراء"),
                          ),
                        ],
                        rows: List.generate(
                            snapshot.data!.length,
                            (index) => DataRow(
                                    color:
                                        WidgetStateProperty.all(Colors.white),
                                    cells: [
                                      DataCell(
                                        Text(
                                          (index + 1).toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data![index].fullName
                                              .toString(),
                                        ),
                                        onTap: () => Provider.of<Rootwidget>(
                                                context,
                                                listen: false)
                                            .getWidet(SellerProfile(
                                                id: snapshot.data![index].id
                                                    .toString())),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data![index].phoneNumber
                                              .toString(),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data![index].address
                                              .toString(),
                                        ),
                                      ),
                                      DataCell(
                                        InkWell(
                                          hoverColor: Colors.transparent,
                                          onTap: () {
                                            dletedReseller(
                                                context, snapshot, index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 3.5),
                                                child: Text(
                                                  "حذف المشتري",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ])),
                      );
                    } else {
                      return Center(child: Text('لا يوجد مشترين بعد'));
                    }
                  });
            }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dletedReseller(
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
                                title: 'حذف المشتري ',
                              ),
                              SizedBox(height: defaultPadding),
                              Text("هل انت متاكد من انك تريد حذف المشتري"),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Provider.of<ResellerController>(
                                              context,
                                              listen: false)
                                          .deleteHotelbuer(
                                              snapshot.data![index].id,
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
