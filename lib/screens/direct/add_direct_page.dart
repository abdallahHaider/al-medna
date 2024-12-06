import 'package:admin/controllers/direct_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/direct/direct_page.dart';
import 'package:admin/screens/widgets/back_batten.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectPage extends StatefulWidget {
  const AddDirectPage({super.key});
  final bool isEdidt = false;

  @override
  State<AddDirectPage> createState() => _AddDirectPageState();
}

class _AddDirectPageState extends State<AddDirectPage> {
  final _formKey = GlobalKey<FormState>();
  final name_of_tripe = TextEditingController();
  final momtamer_name = TextEditingController();
  final phone_number = TextEditingController();
  final cost = TextEditingController();
  final number_of_pushes = TextEditingController();
  final date_of_start = TextEditingController();

  @override
  void initState() {
    Provider.of<DirectController>(context, listen: false).onStaet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(title: 'اضافة رحلة'),
        actions: [
          BackBatten(
            onPressed: () {
              Provider.of<Rootwidget>(context, listen: false)
                  .getWidet(DirectPage());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: defaultPadding),
                _buildDropdowns(),
                SizedBox(height: defaultPadding),
                _buildTravelersField(),
                SizedBox(height: defaultPadding),
                // _buildRoomTable(),
                // SizedBox(height: defaultPadding),
                _buildFinancials(),
                SizedBox(height: defaultPadding),
                _buildNotesField(),
                SizedBox(height: defaultPadding),
                _buildActionButtons(context),
              ],
            ),
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
              child: TextFormField(
                controller: name_of_tripe,
                decoration: InputDecoration(
                  labelText: 'اسم الرحلة',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'يجب ادخال اسم الرحلة';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: !widget.isEdidt
                  ? Consumer<DirectController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return DropdownButtonFormField<dynamic>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "الرحلة",
                          ),
                          onChanged: (dynamic value1) {
                            value.setSelectedTransport(value1.id);
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
                      // labelText: widget.transport == "street" ? "بري" : "جوي",
                      enabled: false,
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
            controller: momtamer_name,
            decoration: InputDecoration(
              labelText: 'اسم المعتمر',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.name,
            validator: (value) => value == null || value.isEmpty
                ? 'يرجى ادخال اسم المعتمر'
                : null,
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: TextFormField(
            controller: phone_number,
            decoration: InputDecoration(
              labelText: 'رقم الهاتف',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'يرجى ادخال رقم الهاتف';
              } else if (value.length < 10) {
                return 'يرجى ادخال رقم الهاتف الصحيح';
              } else
                return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFinancials() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: cost,
            labelText: "المبلغ الكلي",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'يرجى ادخال المبلغ الكلي';
              } else if (double.parse(value) <= 0) {
                return 'يرجى ادخال المبلغ الكلي الصحيح';
              } else
                return null;
            },
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(child: Consumer<DirectController>(
          builder: (BuildContext context, value, Widget? child) {
            return DropdownButtonFormField<dynamic>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "نوع البرنامج",
              ),
              onChanged: (dynamic value1) {
                value.setSelectedRoute(value1.id);
              },
              value: value.directTpye.first,
              items: value.directTpye.map((dynamic companies) {
                return DropdownMenuItem<dynamic>(
                  value: companies,
                  child: Text(companies.name),
                );
              }).toList(),
              validator: (value) =>
                  value == null ? 'يرجى ادخال نوع البرنامج' : null,
            );
          },
        )),
      ],
    );
  }

  Widget _buildNotesField() {
    return Consumer<DirectController>(
        builder: (BuildContext context, value, Widget? child) {
      return Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: number_of_pushes,
              labelText: "عدد الدفعات",
              keyboardType: TextInputType.number,
              enabled: value.selectedRoute == "K",
              validator: (value) {
                if (value.selectedRoute == "K") {
                  if (value!.isEmpty) {
                    return 'يرجى ادخال عدد الدفعات';
                  } else if (double.parse(value) <= 0) {
                    return 'يرجى ادخال عدد الدفعات الصحيح';
                  } else
                    return null;
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(width: defaultPadding),
          Expanded(
            child: TextField(
              controller: date_of_start,
              decoration: InputDecoration(
                labelText: "تاريخ من",
                border: OutlineInputBorder(),
                filled: true,
              ),
              // enabled: value.selectedRoute == "K",
              onTap: () async {
                final DateTime? picker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(Duration(days: 100)),
                );
                if (picker != null) {
                  date_of_start.text = picker.toString();
                }
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Provider.of<Rootwidget>(context, listen: false)
                .getWidet(DirectPage());
          },
          child: Text('الغاء'),
        ),
        SizedBox(width: defaultPadding),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(primaryColor),
              foregroundColor: WidgetStateProperty.all(Colors.white)),
          onPressed: () {
            // if (_formKey.currentState!.validate()) {
            _saveTrapDetails();
            Provider.of<DirectController>(context, listen: false).AddDirect(
                context,
                name_of_tripe.text,
                momtamer_name.text,
                phone_number.text,
                DateTime.now().toString(),
                cost.text,
                number_of_pushes.text,
                date_of_start.text);
            // }
          },
          child: Text('حفظ'),
        ),
      ],
    );
  }

  void _saveTrapDetails() async {
    // Map<String, dynamic> trapDetails = {};
    // if (widget.isEdidt) {
    //   trapDetails = {};
    // } else {
    //   trapDetails = {};
    // }

    // try {} catch (e) {}
  }
}
