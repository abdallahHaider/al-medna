
// import 'package:admin/controllers/rootWidget.dart';
// import 'package:admin/screens/trap/add_trap.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/hotel_controller.dart';
// import '../../controllers/reseller_controller.dart';
// import '../dashboard/components/header.dart';
// import 'package:admin/utl/constants.dart';
// import 'package:admin/screens/widgets/erorr_widget.dart';

// class TrapPage1 extends StatefulWidget {
//   @override
//   State<TrapPage1> createState() => _TrapPage1State();
// }

// class _TrapPage1State extends State<TrapPage1> {
//   final duration = TextEditingController();
//   final quantity = TextEditingController();
//   final pricePerOne = TextEditingController();
//   final rasToUsd = TextEditingController();
//   final iqdToUsd = TextEditingController();
//   final _startDateController = TextEditingController();
//   final _endDateController = TextEditingController();

//   String resslrid = "";
//   String trapid = "";
//   String transportsid = "";
//   int page = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(defaultPadding),
//                       child: Header(title: 'الرحلات'),
//                     ),
//                     InkWell(
//                       hoverColor: Colors.transparent,
//                       onTap: () {
//                         // showDialog to add a new trap
//                         // showDialog(
//                         //   context: context,
//                         //   builder: (context) => AddTrap(),
//                         // );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(defaultPadding),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: primaryColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: defaultPadding * 1.5,
//                             vertical: defaultPadding / 2,
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 "إضافة رحلة",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: defaultPadding),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(defaultPadding),
//                     decoration: BoxDecoration(
//                       color: secondaryColor,
//                       borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     ),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: DataTable(
//                         columns: const <DataColumn>[
//                           DataColumn(
//                             label: Text(
//                               'رقم الرحلة',
//                               style: TextStyle(fontStyle: FontStyle.italic),
//                             ),
//                           ),
//                           DataColumn(
//                             label: Text(
//                               'الكمية',
//                               style: TextStyle(fontStyle: FontStyle.italic),
//                             ),
//                           ),
//                           DataColumn(
//                             label: Text(
//                               'السعر',
//                               style: TextStyle(fontStyle: FontStyle.italic),
//                             ),
//                           ),
//                         ],
//                         rows: List<DataRow>.generate(
//                           10,
//                           (index) => DataRow(
//                             cells: <DataCell>[
//                               DataCell(Text('TRAP${index + 1}')),
//                               DataCell(Text('Quantity ${index + 1}')),
//                               DataCell(Text('Price ${index + 1}')),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
