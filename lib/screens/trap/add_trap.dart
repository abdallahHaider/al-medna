import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/trap_controller%20.dart';
import 'package:admin/screens/trap/trap_page.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/components/header.dart';

class AddTrapPage extends StatefulWidget {
  AddTrapPage({super.key});

  @override
  State<AddTrapPage> createState() => _AddTrapPageState();
}

class _AddTrapPageState extends State<AddTrapPage> {
  final duration = TextEditingController();
  final quantity = TextEditingController();
  final pricePerOne = TextEditingController();
  final rasToUsd = TextEditingController();
  final iqdToUsd = TextEditingController();
  final doubleRoomPrice = TextEditingController();
  final tripleRoomPrice = TextEditingController();
  final quadrupleRoomPrice = TextEditingController();
  final doubleRoomCount = TextEditingController();
  final tripleRoomCount = TextEditingController();
  final quadrupleRoomCount = TextEditingController();
  final childrenCount = TextEditingController();
  final childrenPrice = TextEditingController();
  final infantsCount = TextEditingController();
  final infantsPrice = TextEditingController();

  String resslrid = "";
  String trapid = "";
  String transportsid = "";
  int remainingTravelers = 0;
  double totalCost = 0;

  void _calculateTotalCost() {
    final double doubleRoomCost = (int.tryParse(doubleRoomCount.text) ?? 0) *
        (double.tryParse(doubleRoomPrice.text) ?? 0);
    final double tripleRoomCost = (int.tryParse(tripleRoomCount.text) ?? 0) *
        (double.tryParse(tripleRoomPrice.text) ?? 0);
    final double quadrupleRoomCost =
        (int.tryParse(quadrupleRoomCount.text) ?? 0) *
            (double.tryParse(quadrupleRoomPrice.text) ?? 0);
    final double childrenCost = (int.tryParse(childrenCount.text) ?? 0) *
        (double.tryParse(childrenPrice.text) ?? 0);
    final double infantsCost = (int.tryParse(infantsCount.text) ?? 0) *
        (double.tryParse(infantsPrice.text) ?? 0);

    setState(() {
      totalCost = doubleRoomCost +
          tripleRoomCost +
          quadrupleRoomCost +
          childrenCost +
          infantsCost;
      remainingTravelers = int.tryParse(quantity.text) ?? 0;
      remainingTravelers -= (int.tryParse(doubleRoomCount.text) ?? 0) * 2;
      remainingTravelers -= (int.tryParse(tripleRoomCount.text) ?? 0) * 3;
      remainingTravelers -= (int.tryParse(quadrupleRoomCount.text) ?? 0) * 4;
      remainingTravelers = remainingTravelers < 0 ? 0 : remainingTravelers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(title: 'اضافة رحلة'),
          SizedBox(height: defaultPadding),
          _buildDropdowns(),
          SizedBox(height: defaultPadding),
          _buildTravelersField(),
          SizedBox(height: defaultPadding),
          _buildRoomTable(),
          SizedBox(height: defaultPadding),
          _buildFinancials(),
          SizedBox(height: defaultPadding),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildDropdowns() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Consumer<ResellerController>(
                builder: (BuildContext context, value, Widget? child) {
                  return DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "الوكيل",
                    ),
                    onChanged: (dynamic value) {
                      setState(() {
                        resslrid = value.id.toString();
                      });
                    },
                    items: value.resellerss.map((dynamic companies) {
                      return DropdownMenuItem<dynamic>(
                        value: companies,
                        child: Text(companies.fullName!),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Consumer<HotelController>(
                builder: (BuildContext context, value, Widget? child) {
                  return DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "الفندق",
                    ),
                    onChanged: (dynamic value) {
                      setState(() {
                        trapid = value.id.toString();
                      });
                    },
                    items: value.hotels.map((dynamic companies) {
                      return DropdownMenuItem<dynamic>(
                        value: companies,
                        child: Text(companies.fullName!),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: Consumer<TrapController>(
                builder: (BuildContext context, value, Widget? child) {
                  return DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "الرحلة",
                    ),
                    onChanged: (dynamic value) {
                      setState(() {
                        transportsid = value.id;
                      });
                    },
                    items: value.transports.map((dynamic companies) {
                      return DropdownMenuItem<dynamic>(
                        value: companies,
                        child: Text(companies.name),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: TextFormField(
                controller: duration,
                decoration: InputDecoration(
                  labelText: 'مدة الرحلة',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTravelersField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: quantity,
            decoration: InputDecoration(
              labelText: 'عدد المسافرين',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => _calculateTotalCost(),
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: Text(
            'المسافرين المتبقيين: $remainingTravelers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          children: [
            _buildTableCell('النوع'),
            _buildTableCell('السعر'),
            _buildTableCell('عدد'),
          ],
        ),
        _buildRoomTableRow('غرفه ثنائية', doubleRoomPrice, doubleRoomCount, 2),
        _buildRoomTableRow('غرفه ثلاثية', tripleRoomPrice, tripleRoomCount, 3),
        _buildRoomTableRow(
            'غرفه رباعية', quadrupleRoomPrice, quadrupleRoomCount, 4),
        _buildRoomTableRow('عدد الأطفال', childrenPrice, childrenCount, 1),
        _buildRoomTableRow('عدد الرضع', infantsPrice, infantsCount, 1),
      ],
    );
  }

  TableRow _buildRoomTableRow(
      String label,
      TextEditingController priceController,
      TextEditingController countController,
      int multiplier) {
    return TableRow(
      children: [
        _buildTableCell(label, isHeader: false),
        _buildTableCellW(
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'السعر',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => _calculateTotalCost(),
          ),
          isHeader: false,
        ),
        _buildTableCellW(
          TextFormField(
            controller: countController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'عدد',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => _calculateTotalCost(),
          ),
          isHeader: false,
        ),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTableCellW(Widget child, {bool isHeader = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }

  Widget _buildFinancials() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: rasToUsd,
            decoration: InputDecoration(
              labelText: 'الريال مقابل الدولار',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: TextFormField(
            controller: iqdToUsd,
            decoration: InputDecoration(
              labelText: 'الدينار مقابل الدولار',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: Text(
            'التكلفة الاجمالية: \$ $totalCost',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.green),
              foregroundColor: WidgetStateProperty.all(Colors.white)),
          onPressed: () async {
            // Submit Logic
            _saveTrapDetails();
          },
          child: Text('اضافة'),
        ),
        SizedBox(width: defaultPadding),
        TextButton(
          style:
              ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('الغاء'),
        ),
      ],
    );
  }

  void _saveTrapDetails() async {
    // Implement save logic here
    // You can gather the data from the controllers and make API requests
    final trapDetails = {
      'reseller_id': resslrid,
      'hotel_id': trapid,
      'transport': transportsid,
      'duration': duration.text,
      'quantity': quantity.text,
      'price': pricePerOne.text,
      'RAS_to_USD': "0",
      'IQD_to_USD': iqdToUsd.text,
      /////////////
      'price_couple_room': doubleRoomPrice.text,
      'price_triple_room': tripleRoomPrice.text,
      'price_quadruple_room': quadrupleRoomPrice.text,
      'couple_room': doubleRoomCount.text,
      'triple_room': tripleRoomCount.text,
      'quadruple_room': quadrupleRoomCount.text,
      // 'childrenCount': childrenCount.text,
      // 'infantsCount': infantsCount.text,
      // 'totalCost': totalCost,
      ////
      "child": childrenCount.text,
      "very_child": infantsCount.text,
      "price_child": childrenPrice.text,
      "price_very_child": infantsPrice.text,
    };
    try {
      // Assuming you have a method in your TrapController to handle saving
      await Provider.of<TrapController>(context, listen: false)
          .addtrap(trapDetails);

      // Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم حفظ التفاصيل بنجاح')),

      );
       Provider.of<Rootwidget>(context,listen: false).getWidet(TrapPage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    // Optionally, navigate back or clear the form
  }
}
