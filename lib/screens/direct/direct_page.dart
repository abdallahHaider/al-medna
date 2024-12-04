import 'package:admin/controllers/direct_controller.dart';
import 'package:admin/controllers/rootWidget.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_button.dart';
import 'package:admin/screens/widgets/my_data_table.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/back_batten.dart';

class DirectPage extends StatefulWidget {
  const DirectPage({super.key});

  @override
  State<DirectPage> createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Header(title: "المباشر والاقساط"),
          Divider(),
          MyButton(
              onPressed: () {
                Provider.of<Rootwidget>(context, listen: false)
                    .getWidet(AddDirectPage());
              },
              child: Text("اضافة جديد")),
          SizedBox(
            width: double.infinity,
            child: MyDataTable(columns: [
              DataColumn(label: Text("الرقم")),
              DataColumn(label: Text("الاسم")),
              DataColumn(label: Text("اسم المعتمر")),
              DataColumn(label: Text("رقم الهاتف")),
              DataColumn(label: Text("التاريخ")),
              DataColumn(label: Text("نوع البرنامج")),
              DataColumn(label: Text("الواصل")),
              DataColumn(label: Text("الاجمالي")),
              DataColumn(label: Text("الاباقي")),
            ], rows: []),
          )
        ],
      ),
    );
  }
}

class AddDirectPage extends StatefulWidget {
  const AddDirectPage({super.key});
  final bool isEdidt = false;

  @override
  State<AddDirectPage> createState() => _AddDirectPageState();
}

class _AddDirectPageState extends State<AddDirectPage> {
  final _formKey = GlobalKey<FormState>();

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
                // controller: quantity,
                decoration: InputDecoration(
                  labelText: 'اسم الرحلة',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
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
            // controller: quantity,
            decoration: InputDecoration(
              labelText: 'اسم المعتمر',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.name,
          ),
        ),
        SizedBox(width: defaultPadding),
        Expanded(
          child: TextFormField(
            // controller: quantity,
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
            // controller: iqdToUsd,
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
              // controller: iqdToUsd,
              labelText: "عدد الدفعات",
              keyboardType: TextInputType.number,
              enabled: value.selectedRoute == "K",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'يرجى ادخال عدد الدفعات';
                } else if (double.parse(value) <= 0) {
                  return 'يرجى ادخال عدد الدفعات الصحيح';
                } else
                  return null;
              },
            ),
          ),
          SizedBox(width: defaultPadding),
          Expanded(
            child: MyTextField(
              // controller: iqdToUsd,
              labelText: "تاريخ استحقاق الدفعة",
              keyboardType: TextInputType.number,
              enabled: value.selectedRoute == "K",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'يرجى ادخال تاريخ استحقاق الدفعة';
                } else
                  return null;
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
    // Map<String, dynamic> trapDetails = {};
    // if (widget.isEdidt) {
    //   trapDetails = {};
    // } else {
    //   trapDetails = {};
    // }

    // try {} catch (e) {}
  }
}
