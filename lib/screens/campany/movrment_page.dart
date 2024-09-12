import 'package:admin/controllers/company_controller.dart';
import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class MovementPage extends StatefulWidget {
  MovementPage({super.key, required this.id});
  final String id;

  @override
  State<MovementPage> createState() => _MovementPageState();
}

class _MovementPageState extends State<MovementPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _hotelNameController = TextEditingController();
  final _roomController = TextEditingController();
  final _numberTController = TextEditingController();
  final _cosrTController = TextEditingController();
  final _numberdayController = TextEditingController();
  final _costdayController = TextEditingController();
  final _dadeController = TextEditingController();

  ///
  final _hotelNameM = TextEditingController();
  final _nigetM = TextEditingController();
  final _roomM = TextEditingController();
  final _costM = TextEditingController();
  DateTime? _selectedDate;
  String trapid = "";

  @override
  void initState() {
    Provider.of<HotelController>(context, listen: false).getFetchData(true);
    Provider.of<HotelController>(context, listen: false).getFetchData(false);
    setState(() {
      _dadeController.text = DateTime.now().toString();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // First Row: Two Dropdowns
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _nameController,
                      labelText: 'اسم المجموعة',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter cost';
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  // Expanded(child: SizedBox()),
                  Expanded(child: SizedBox())
                ],
              ),

              SizedBox(height: 16),
              // First Row: Two Dropdowns
              Row(
                children: [
                  // _biledDrop(),
                  // Expanded(
                  //   child: Consumer<HotelController>(
                  //     builder: (BuildContext context, value, Widget? child) {
                  //       return DropdownButtonFormField<dynamic>(
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           labelText: "فندق مدينة",
                  //         ),
                  //         onChanged: (dynamic value) {
                  //           // setState(() {
                  //           trapid = value.id.toString();
                  //           // });
                  //         },
                  //         items: value.hotelsM.map((dynamic companies) {
                  //           return DropdownMenuItem<dynamic>(
                  //             value: companies,
                  //             child: Text(companies.fullName!),
                  //           );
                  //         }).toList(),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // Expanded(
                  //   child: MyTextField(
                  //     controller: _hotelNameController,
                  //     labelText: 'اسم الفندق',
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter cost';
                  //       }
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 16,
                  // ),
                  Expanded(
                    child: MyTextField(
                      controller: _dadeController,
                      labelText: 'التاريخ',
                      enabled: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter cost';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('تحديد'),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
              SizedBox(height: 16),

              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
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
                      _buildTableCell('الفندق'),
                      _buildTableCell('عدد'),
                      _buildTableCell('السعر'),
                      // _buildTableCell('الغرف'),
                      _buildTableCell('السعر الاجمالي'),
                    ],
                  ),
                  _buildRoomTableRow(
                      'الفيزا', _cosrTController, _numberTController, 2),
                ],
              ),

              SizedBox(height: 24), // More spacing before the button
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
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
                      _buildTableCell('فندق المدينة'),
                      _buildTableCell('عدد الليالي'),
                      _buildTableCell('عدد الغرف'),

                      _buildTableCell('السعر'),
                      // _buildTableCell('الغرف'),
                      _buildTableCell('السعر الاجمالي'),
                    ],
                  ),
                  _buildRoomTableRow1(_hotelNameController, _costdayController,
                      _numberdayController, _roomController, 3),
                ],
              ),

              SizedBox(height: 24),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
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
                      _buildTableCell('فندق مكة'),
                      _buildTableCell('عدد الليالي'),
                      _buildTableCell('عدد الغرف'),

                      _buildTableCell('السعر'),
                      // _buildTableCell('الغرف'),
                      _buildTableCell('السعر الاجمالي'),
                    ],
                  ),
                  _buildRoomTableRow1(_hotelNameM, _nigetM, _roomM, _costM, 3),
                ],
              ),

              SizedBox(height: 24),
              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  try {
                    SmartDialog.showLoading();
                    await Provider.of<CompanyController>(context, listen: false)
                        .addMove(
                            widget.id,
                            _nameController.text.isNotEmpty
                                ? _nameController.text
                                : "0",
                            _cosrTController.text.isNotEmpty
                                ? _cosrTController.text
                                : "0",
                            _numberTController.text.isNotEmpty
                                ? _numberTController.text
                                : "0",
                            _hotelNameController.text,
                            _numberdayController.text,
                            _costdayController.text,
                            _roomController.text,
                            _dadeController.text,
                            _hotelNameM.text,
                            _roomM.text,
                            _nigetM.text,
                            _costM.text);
                    snackBar(context, "تمت العملية بمجاح", false);
                  } catch (e) {
                    print(e);
                    snackBar(context, e.toString(), true);
                  } finally {
                    SmartDialog.dismiss();
                  }
                  // }
                },
                child: Text('اضافة'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _biledDrop() {
    return Expanded(
      child: Consumer<HotelController>(
        builder: (BuildContext context, value, Widget? child) {
          return DropdownButtonFormField<dynamic>(
            onChanged: (dynamic value) {
              trapid = value.id.toString();
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
    );
  }

  Widget _buildTableCell(String content) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(content),
    );
  }

  TableRow _buildRoomTableRow(
      String label,
      TextEditingController priceController,
      TextEditingController countController,
      int multiplier) {
    // TextEditingController priceController = TextEditingController();
    // TextEditingController countController = TextEditingController();
    // int roomCount =
    //     ((int.tryParse(countController.text) ?? 0) / multiplier).ceil();
    // int remainingBeds = (int.tryParse(countController.text) ?? 0) % multiplier;
    // String roomComment =
    //     remainingBeds > 0 ? 'متبقي ${multiplier - remainingBeds} أسرّة' : '';
    double total = 0;
    setState(() {
      total = (int.tryParse(countController.text) ?? 0) *
          (double.tryParse(priceController.text) ?? 0);
    });

    return TableRow(
      children: [
        _buildTableCell(label),
        _buildEditableTableCell(priceController, countController),
        _buildEditableTableCell(countController, priceController),
        // _buildTableCell('$roomCount $roomComment'),
        _buildTableCell(total.toStringAsFixed(2)),
      ],
    );
  }

  TableRow _buildRoomTableRow1(
      TextEditingController label,
      TextEditingController priceController,
      TextEditingController countController,
      TextEditingController countController1,
      int multiplier) {
    double total = 0;
    setState(() {
      total = (int.tryParse(countController.text) ?? 0) *
          (double.tryParse(priceController.text) ?? 0) *
          (double.tryParse(countController1.text) ?? 0);
    });

    return TableRow(
      children: [
        // _buildTableCell(label),
        // _biledDrop(),
        _buildEditableTableCell(label, TextEditingController(text: "1")),
        _buildEditableTableCell(priceController, countController),
        _buildEditableTableCell(countController, priceController),
        _buildEditableTableCell(
            countController1, TextEditingController(text: "1")),
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
      onChanged: (value) => {setState(() {})},
      validator: (value) {
        if (value!.isEmpty && target.text.isNotEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // التاريخ الافتراضي هو اليوم الحالي
      firstDate: DateTime(2000), // أقدم تاريخ يمكن اختياره
      lastDate: DateTime(2101), // أحدث تاريخ يمكن اختياره
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dadeController.text = picked.toString();
      });
  }
}
