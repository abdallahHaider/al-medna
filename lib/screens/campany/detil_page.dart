// import 'package:admin/controllers/company_controller.dart';
// import 'package:admin/controllers/transactions.dart';
// import 'package:admin/screens/widgets/snakbar.dart';
// import 'package:admin/utl/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:provider/provider.dart';

// class DetilPage extends StatefulWidget {
//   const DetilPage(
//       {super.key, required this.id, required this.isBank});
//   final String id;
//   final bool isBank;

//   @override
//   State<DetilPage> createState() => _DetilPageState();
// }

// class _DetilPageState extends State<DetilPage> {
//   @override
//   void initState() {
//       Provider.of<CompanyController>(context, listen: false)
//           .CompanyController(widget.id);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Card(
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                       width: double.maxFinite,
//                       child: Card(
//                           color: Colors.white,
//                           child: Consumer<CompanyController>(builder: (
//                             BuildContext context,
//                             accountsController,
//                             Widget? child,
//                           ) {
//                             return DataTable(
//                               columns: [
//                                 DataColumn(label: Text('المرسل')),
//                                 DataColumn(label: Text('المستلم')),
//                                 DataColumn(label: Text('المبلغ بالدينار')),
//                                 DataColumn(label: Text('المبلغ بالدولار')),
//                                 DataColumn(label: Text('رقم القيد')),
//                                 DataColumn(label: Text('التاريخ')),
//                                 DataColumn(label: Text('الاجراء')),
//                               ],
//                               rows: List.generate(
//                                   accountsController.mySmallBank.length,
//                                   (index) => DataRow(cells: [
//                                         DataCell(
//                                           Text(accountsController
//                                               .mySmallBank[index].senderName
//                                               .toString()),
//                                         ),
//                                         DataCell(
//                                           Text(accountsController
//                                               .mySmallBank[index].getterName
//                                               .toString()),
//                                         ),
//                                         DataCell(
//                                           Text(accountsController
//                                               .mySmallBank[index].costIqd
//                                               .toString()),
//                                         ),
//                                         DataCell(
//                                           Text(accountsController
//                                               .mySmallBank[index].costUsd
//                                               .toString()),
//                                         ),
//                                         DataCell(
//                                           Text(accountsController
//                                               .mySmallBank[index].numberKade
//                                               .toString()),
//                                         ),
//                                         // DataCell(Text((index + 1).toString())),
//                                         DataCell(Text(accountsController
//                                             .mySmallBank[index].createdAt
//                                             .toString()
//                                             .substring(0, 10))),
//                                         DataCell(Row(
//                                           children: [
//                                             IconButton(
//                                                 onPressed: () {
//                                                   showDialog(
//                                                       context: context,
//                                                       builder: (BuildContext
//                                                           context) {
//                                                         return AlertDialog(
//                                                           title: Text('حذف'),
//                                                           content: Text(
//                                                               'هل أنت متأكد من حذف هذا الصيرفة'),
//                                                           actions: [
//                                                             TextButton(
//                                                               child: Text('لا'),
//                                                               onPressed: () {
//                                                                 Navigator.of(
//                                                                         context)
//                                                                     .pop();
//                                                               },
//                                                             ),
//                                                             TextButton(
//                                                                 child:
//                                                                     Text('نعم'),
//                                                                 onPressed:
//                                                                     () async {
//                                                                   try {
//                                                                     SmartDialog
//                                                                         .showLoading();
//                                                                     await Provider.of<TransactionsController>(
//                                                                             context,
//                                                                             listen:
//                                                                                 false)
//                                                                         .deletSmallbank(
//                                                                       accountsController
//                                                                           .mySmallBank[
//                                                                               index]
//                                                                           .id,
//                                                                     );
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                     snackBar(
//                                                                         context,
//                                                                         "تم الحذف بنجاح",
//                                                                         false);
//                                                                   } catch (e) {
//                                                                     snackBar(
//                                                                         context,
//                                                                         e.toString(),
//                                                                         true);
//                                                                   } finally {
//                                                                     SmartDialog
//                                                                         .dismiss();
//                                                                   }
//                                                                 }),
//                                                           ],
//                                                         );
//                                                       });
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.delete_forever,
//                                                   color: Colors.red,
//                                                 ))
//                                           ],
//                                         ))
//                                       ])),
//                             );
//                           }))))),
//         ),
//         Expanded(
//           flex: 1,
//           child: Card(
//             elevation: 5,
//             color: secondaryColor,
//             child: Padding(
//               padding: const EdgeInsets.all(defaultPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Icon(
//                   //   Icons.account_balance,
//                   //   size: 100,
//                   // ),
//                   SizedBox(
//                     height: defaultPadding,
//                   ),
//                   Text(
//                     'الرصيد بالدينار',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.money),
//                       Consumer<CompanyController>(
//                         builder: (context, storage, child) {
//                           return Text(
//                             '${storage.wallet_IQD}',
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: defaultPadding,
//                   ),
//                   Text(
//                     'الرصيد بالدولار',
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.attach_money),
//                       Consumer<TransactionsController>(
//                         builder: (context, storage, child) {
//                           return Text(
//                             '${storage.wallet_USD}',
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
