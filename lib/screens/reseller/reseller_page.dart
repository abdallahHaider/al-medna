import 'package:admin/responsive.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:admin/screens/widgets/erorr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/reseller_controller.dart';
import '../dashboard/components/header.dart';

class ResellerPage extends StatelessWidget {
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
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Header(
                    title: 'الوكلاء',
                  ),
                ),
                Expanded(
                  child: Consumer<ResellerController>(
                    builder: (BuildContext context, value, Widget? child) {
                      return FutureBuilder(
                          future: value.fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return ErorrWidget();
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text(snapshot
                                        .data![index].fullName!
                                        .substring(0, 1)),
                                    title:
                                        Text(snapshot.data![index].fullName!),
                                    subtitle: Text(snapshot
                                        .data![index].phoneNumber
                                        .toString()),
                                    trailing: Text(snapshot.data![index].address
                                        .toString()),
                                  );
                                },
                              );
                            } else {
                              return Center(child: Text('No data available'));
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (Responsive.isDesktop(context) || Responsive.isTablet(context))
            Expanded(
              child: Column(
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
                                  title: 'اضافة وكيل',
                                ),
                                SizedBox(height: defaultPadding),
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'اسم الوكيل',
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
                                ElevatedButton(
                                  onPressed: () async {
                                    if (nameController.text.isEmpty ||
                                        phoneController.text.isEmpty ||
                                        adressController.text.isEmpty) {
                                      snackBar(
                                          context, 'الرجاء ملئ جميع الحقول');
                                    } else {
                                      await Provider.of<ResellerController>(
                                              context,listen: false)
                                          .addReseller(
                                              nameController.text.toString(),
                                              phoneController.text.toString(),
                                              adressController.text.toString(),
                                              context);
                                    }
                                  },
                                  child: Text('اضافة'),
                                ),
                              ]))),
                ],
              ),
            )
        ],
      ),
    );
  }
}
