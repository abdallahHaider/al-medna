import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/controllers/trap_controller%20.dart';
import 'package:admin/screens/trap/trap_page.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/components/header.dart';

class AddTrapPage extends StatefulWidget {
  AddTrapPage({
    super.key,
    this.duration,
    this.quantity,
    this.pricePerOne,
    this.iqdToUsd,
    this.doubleRoomPrice,
    this.tripleRoomPrice,
    this.quadrupleRoomPrice,
    this.doubleRoomCount,
    this.tripleRoomCount,
    this.quadrupleRoomCount,
    this.childrenCount,
    this.childrenPrice,
    this.infantsCount,
    this.infantsPrice,
    this.notesController,
    this.vipController,
    this.priceVipController,
    this.hotel,
    this.realer,
    required this.isEdidt,
    this.trapId,
    this.transport,
  });
  final bool isEdidt;
  final int? trapId;
  final String? duration;
  final String? quantity;
  final String? pricePerOne;
  final String? iqdToUsd;
  final String? doubleRoomPrice;
  final String? tripleRoomPrice;
  final String? quadrupleRoomPrice;
  final String? doubleRoomCount;
  final String? tripleRoomCount;
  final String? quadrupleRoomCount;
  final String? childrenCount;
  final String? childrenPrice;
  final String? infantsCount;
  final String? infantsPrice;
  final String? notesController;
  final String? vipController;
  final String? priceVipController;
  final String? hotel;
  final String? realer;
  final String? transport;

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
  final notesController = TextEditingController();
  final hotelController = TextEditingController();
  final vipController = TextEditingController();
  final priceVipController = TextEditingController();

  String resslrid = "";
  // String trapid = "";
  String transportsid = "";
  int remainingTravelers = 0;
  double totalCost = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    duration.text = widget.duration ?? "";
    quantity.text = widget.quantity ?? "";
    pricePerOne.text = widget.pricePerOne ?? "";
    iqdToUsd.text = widget.iqdToUsd ?? "";
    doubleRoomPrice.text = widget.doubleRoomPrice ?? "";
    tripleRoomPrice.text = widget.tripleRoomPrice ?? "";
    quadrupleRoomPrice.text = widget.quadrupleRoomPrice ?? "";
    doubleRoomCount.text = widget.doubleRoomCount ?? "";
    tripleRoomCount.text = widget.tripleRoomCount ?? "";
    quadrupleRoomCount.text = widget.quadrupleRoomCount ?? "";
    childrenCount.text = widget.childrenCount ?? "";
    childrenPrice.text = widget.childrenPrice ?? "";
    infantsCount.text = widget.infantsCount ?? "";
    infantsPrice.text = widget.infantsPrice ?? "";
    notesController.text = widget.notesController ?? "";
    vipController.text = widget.vipController ?? "";
    priceVipController.text = widget.priceVipController ?? "";
    hotelController.text = widget.hotel ?? "";
    _calculateTotalCost();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<HotelController>(context).dispose();
    Provider.of<ResellerController>(context).dispose();
    super.dispose();
  }

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
    final double vip = (int.tryParse(vipController.text) ?? 0) *
        (double.tryParse(priceVipController.text) ?? 0);

    setState(() {
      totalCost = doubleRoomCost +
          tripleRoomCost +
          quadrupleRoomCost +
          childrenCost +
          infantsCost +
          vip;

      int totalTravelers = int.tryParse(quantity.text) ?? 0;
      int travelersInDoubleRooms = (int.tryParse(doubleRoomCount.text) ?? 0);
      int travelersInTripleRooms = (int.tryParse(tripleRoomCount.text) ?? 0);
      int travelersInQuadrupleRooms =
          (int.tryParse(quadrupleRoomCount.text) ?? 0);
      int totalChildren = int.tryParse(childrenCount.text) ?? 0;
      int totalInfants = int.tryParse(infantsCount.text) ?? 0;
      int totalvip = int.tryParse(vipController.text) ?? 0;

      remainingTravelers = totalTravelers -
          (travelersInDoubleRooms +
              travelersInTripleRooms +
              travelersInQuadrupleRooms +
              totalChildren +
              totalInfants +
              totalvip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              _buildNotesField(),
              SizedBox(height: defaultPadding),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdowns() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: !widget.isEdidt
                  ? Consumer<ResellerController>(
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
                          items: value.resellerss.map((companies) {
                            return DropdownMenuItem<dynamic>(
                              value: companies,
                              child: Text(companies.fullName!),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'يرجى اختبار الوكيل ' : null,
                        );
                      },
                    )
                  : MyTextField(
                      labelText: widget.realer,
                      enabled: false,
                    ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: TextFormField(
                controller: hotelController,
                decoration: InputDecoration(
                  labelText: 'الفندق',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            Expanded(
              child: !widget.isEdidt
                  ? Consumer<TrapController>(
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
                          validator: (value) =>
                              value == null ? 'يرجى ادخال نوع الرحلة' : null,
                        );
                      },
                    )
                  : MyTextField(
                      labelText: widget.transport == "street" ? "بري" : "جوي",
                      enabled: false,
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
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: remainingTravelers < 0
                    ? Colors.red
                    : remainingTravelers == 0
                        ? Colors.green
                        : Colors.black),
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
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          children: [
            _buildTableCell('النوع'),
            _buildTableCell('السعر لكل فرد'),
            _buildTableCell('عدد الافراد'),
            _buildTableCell('الغرف'),
            _buildTableCell('السعر الاجمالي'),
          ],
        ),
        _buildRoomTableRow('غرفه ثنائية', doubleRoomPrice, doubleRoomCount, 2),
        _buildRoomTableRow('غرفه ثلاثية', tripleRoomPrice, tripleRoomCount, 3),
        _buildRoomTableRow(
            'غرفه رباعية', quadrupleRoomPrice, quadrupleRoomCount, 4),
        _buildRoomTableRow('عدد الأطفال', childrenPrice, childrenCount, 1),
        _buildRoomTableRow('عدد الرضع', infantsPrice, infantsCount, 1),
        _buildRoomTableRow(
            'المسافر الخاص', priceVipController, vipController, 1),
      ],
    );
  }

  TableRow _buildRoomTableRow(
      String label,
      TextEditingController priceController,
      TextEditingController countController,
      int multiplier) {
    int roomCount =
        ((int.tryParse(countController.text) ?? 0) / multiplier).ceil();
    int remainingBeds = (int.tryParse(countController.text) ?? 0) % multiplier;
    String roomComment =
        remainingBeds > 0 ? 'متبقي ${multiplier - remainingBeds} أسرّة' : '';
    double total = (int.tryParse(countController.text) ?? 0) *
        (double.tryParse(priceController.text) ?? 0);

    return TableRow(
      children: [
        _buildTableCell(label),
        _buildEditableTableCell(priceController, countController),
        _buildEditableTableCell(countController, priceController),
        _buildTableCell('$roomCount $roomComment'),
        _buildTableCell(total.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildEditableTableCell(
      TextEditingController controller, TextEditingController target) {
    return MyTextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
            gapPadding: 0),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => _calculateTotalCost(),
      validator: (value) {
        if (value!.isEmpty && target.text.isNotEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
    );
  }

  Widget _buildTableCell(String content) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(content),
    );
  }

  Widget _buildFinancials() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: defaultPadding),
            Expanded(
              child: MyTextField(
                  controller: iqdToUsd,
                  labelText: "رقم العقد",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجى ادخال رقم العقد';
                    }
                    final x = int.tryParse(value);
                    if (x == null) {
                      return ' يرجى ادخال رقم صحيح';
                    }
                    return null;
                  }),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Text(
                'السعر الكلي: $totalCost',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: notesController,
      decoration: InputDecoration(
        labelText: 'ملاحظات',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Provider.of<Rootwidget>(context, listen: false)
                .getWidet(TrapPage());
          },
          child: Text('الغاء'),
        ),
        SizedBox(width: defaultPadding),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(primaryColor),
              foregroundColor: WidgetStateProperty.all(Colors.white)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _saveTrapDetails();
            }
          },
          child: Text('حفظ'),
        ),
      ],
    );
  }

  void _saveTrapDetails() async {
    Map<String, dynamic> trapDetails = {};
    if (widget.isEdidt) {
      trapDetails = {
        'trap_id': widget.trapId,
        // 'reseller_id': resslrid,
        // 'hotel_id': trapid,
        // 'transport': transportsid,
        if (duration.text.isNotEmpty) 'duration': duration.text,
        // pricePerOne.text.isNotEmpty ? 'price' : pricePerOne.text: "",
        // 'RAS_to_USD': "0",
        // 'IQD_to_USD': iqdToUsd.text.isNotEmpty ? iqdToUsd.text : "0",
        /////////////
        if (doubleRoomPrice.text.isNotEmpty)
          'price_couple_room': doubleRoomPrice.text,
        if (tripleRoomPrice.text.isNotEmpty)
          'price_triple_room': tripleRoomPrice.text,
        if (quadrupleRoomPrice.text.isNotEmpty)
          'price_quadruple_room': quadrupleRoomPrice.text,
        if (doubleRoomCount.text.isNotEmpty)
          'couple_room': doubleRoomCount.text,
        if (tripleRoomCount.text.isNotEmpty)
          'triple_room': tripleRoomCount.text,
        if (quadrupleRoomCount.text.isNotEmpty)
          'quadruple_room': quadrupleRoomCount.text,
        // 'childrenCount': childrenCount.text,
        // 'infantsCount': infantsCount.text,
        // 'totalCost': totalCost,
        ////
        if (childrenCount.text.isNotEmpty) "child": childrenCount.text,
        if (infantsCount.text.isNotEmpty) "very_child": infantsCount.text,
        if (childrenPrice.text.isNotEmpty) "price_child": childrenPrice.text,
        if (infantsPrice.text.isNotEmpty) "price_very_child": infantsPrice.text,
        if (infantsPrice.text.isNotEmpty) "note": notesController.text,
        if (infantsPrice.text.isNotEmpty) "vip_travel": vipController.text,
        if (infantsPrice.text.isNotEmpty)
          "price_vip_travel": priceVipController.text,
      };
    } else {
      trapDetails = {
        'reseller_id': resslrid,
        'hotel_name': hotelController.text.isNotEmpty
            ? hotelController.text.toString()
            : "_",
        'transport': transportsid,
        'duration': duration.text.isNotEmpty ? duration.text : "0",
        'quantity': quantity.text,
        'price': pricePerOne.text,
        'RAS_to_USD': "0",
        'IQD_to_USD': "0",
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
        "number_trap": iqdToUsd.text,
        "note": notesController.text,
        "vip_travel": vipController.text,
        "price_vip_travel": priceVipController.text,
      };
    }

    try {
      if (widget.isEdidt) {
        await Provider.of<TrapController>(context, listen: false)
            .updateTrap(trapDetails);
      } else {
        await Provider.of<TrapController>(context, listen: false)
            .addtrap(trapDetails);
      }
      snackBar(context, 'تم حفظ التفاصيل بنجاح', false);
      Provider.of<Rootwidget>(context, listen: false).getWidet(TrapPage());
    } catch (e) {
      snackBar(context, e.toString(), true);
    }
  }
}
