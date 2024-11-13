import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/wallet_provider.dart';
import 'package:admin/screens/authority/authority_page.dart';
import 'package:admin/screens/budget/budget_page.dart';
import 'package:admin/screens/campany/campany_page.dart';
import 'package:admin/screens/hotel/hotel_page.dart';
import 'package:admin/screens/reseller/reseller_page.dart';
import 'package:admin/screens/trap/trap_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utl/constants.dart';
import 'components/header.dart';
import 'package:intl/intl.dart';

  // دالة لتنسيق الرقم بإضافة الفواصل
  String formatCustomNumber(String value) {
  if (value.isEmpty) return '';
  final number = double.tryParse(value.replaceAll(',', ''));
  if (number == null) return value;
  return NumberFormat('#000,000').format(number);
}
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: 'الصفحة الرئيسية',
            ),
            SizedBox(height: defaultPadding),
            Row(
              children: [
                Card(
                  color: blueColor,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Header(title: "الصندوق الرئيسي"),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(defaultPadding * 3),
                                child: Column(
                                  children: [
                                    Text(
                                      'الرصيد بالدينار',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.grey),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.money),
                                        Consumer<WalletProvider>(
                                          builder: (context, storage, child) {
                                            return Text(
                                              '${formatCustomNumber(storage.wallet_IQD)}',
                                              style: TextStyle(
                                                fontSize: 24,
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
                            SizedBox(
                              width: defaultPadding,
                            ),
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(defaultPadding * 3),
                                child: Column(
                                  children: [
                                    Text(
                                      'الرصيد بالدولار',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.grey),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.attach_money),
                                        Consumer<WalletProvider>(
                                          builder: (context, storage, child) {
                                            return Text(
                                              '${storage.wallet_USD}',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            Card(
              color: Color.fromRGBO(94, 165, 117, 0.01),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () =>
                              Provider.of<Rootwidget>(context, listen: false)
                                  .getWidet(BudgetPage()),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: blueColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                )),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: primaryColor),
                                    child: Center(child: Text("الميزانية"))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        InkWell(
                          onTap: () =>
                              Provider.of<Rootwidget>(context, listen: false)
                                  .getWidet(ResellerPage()),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: blueColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                )),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: primaryColor),
                                    child: Center(child: Text("الوكلاء"))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        InkWell(
                          onTap: () =>
                              Provider.of<Rootwidget>(context, listen: false)
                                  .getWidet(TrapPage()),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: blueColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                )),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: primaryColor),
                                    child: Center(child: Text("الرحلات"))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () =>
                              Provider.of<Rootwidget>(context, listen: false)
                                  .getWidet(AuthorityPage()),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: blueColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                )),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: primaryColor),
                                    child: Center(
                                        child: Text("الحسابات العامه"))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        InkWell(
                          onTap: () =>
                              Provider.of<Rootwidget>(context, listen: false)
                                  .getWidet(HotelPage()),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: blueColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                )),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: primaryColor),
                                    child: Center(child: Text("الفنادق"))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        InkWell(
                          onTap: () =>
                              Provider.of<Rootwidget>(context, listen: false)
                                  .getWidet(CampanyPage()),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: blueColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey,
                                )),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color: primaryColor),
                                    child: Center(child: Text("الشركات"))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                      ],
                    ),
                  ],
                ),
              ),
            )

            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       flex: 5,
            //       child: Column(
            //         children: [
            //           // MyFiles(),
            //           // SizedBox(height: defaultPadding),
            //           // // RecentFiles(),
            //           // if (Responsive.isMobile(context))
            //           //   SizedBox(height: defaultPadding),
            //           // if (Responsive.isMobile(context)) StorageDetails(),
            //         ],
            //       ),
            //     ),
            //     if (!Responsive.isMobile(context))
            //       SizedBox(width: defaultPadding),
            //     // On Mobile means if the screen is less than 850 we don't want to show it
            //     if (!Responsive.isMobile(context))
            //       Expanded(
            //         flex: 2,
            //         child: StorageDetails(),
            //       ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
