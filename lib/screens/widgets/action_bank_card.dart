import 'package:admin/controllers/action_bank_controller.dart';
import 'package:admin/models/action.dart';
import 'package:admin/models/type_cost.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class ActionBankCard extends StatelessWidget {
  ActionBankCard({super.key});

  final _formKey = GlobalKey<FormState>();
  final _namberKedeController = TextEditingController();
  final _costController = TextEditingController();

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
                    child: _buildDropdown(
                        "نوع العملية", TypeAction2.actions, (value) {}),
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
                  Expanded(
                    child: _buildDropdown("من", TypeAction3.actions, (value) {
                      Provider.of<ActionBankController>(context, listen: false)
                          .setType(value!.name);
                    }),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Consumer<ActionBankController>(
                      builder: (context, ref, child) => ref.isfrom
                          ? _buildDynamicDropdown(
                              "",
                              ref.mineActions,
                              (value) {
                                print(value);
                                Provider.of<ActionBankController>(context,
                                        listen: false)
                                    .fromID = value.id.toString();
                              },
                            )
                          : SizedBox(),
                    ),
                  ),
                  // Expanded(child: SizedBox())
                ],
              ),

              SizedBox(height: 16),

              // Second Row: One Dynamic Dropdown

              SizedBox(height: 16),

              // Third Row: Two Dropdowns
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown("الى", TypeAction3.actions, (value) {
                      print(value.id);
                      Provider.of<ActionBankController>(context, listen: false)
                          .setTypeTO(value!.name);
                    }),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Consumer<ActionBankController>(
                      builder: (context, ref, child) => ref.isTo
                          ? _buildDynamicDropdown(
                              "",
                              ref.mineActionsTO,
                              (value) {
                                print("333333");
                                print(value.id);
                                Provider.of<ActionBankController>(context,
                                        listen: false)
                                    .toID = value.id.toString();
                              },
                            )
                          : SizedBox(),
                    ),
                  ),
                  // Expanded(child: SizedBox())
                ],
              ),

              SizedBox(height: 16),

              // Fourth Row: One Dynamic Dropdown
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown("العملة", TypeCost.costs, (value) {
                      if (value!.id == "1") {
                        Provider.of<ActionBankController>(context,
                                listen: false)
                            .isIQD = "f";
                      } else {
                        Provider.of<ActionBankController>(context,
                                listen: false)
                            .isIQD = "t";
                      }
                    }),
                  ),
                  SizedBox(width: 16),
                  Expanded(child: SizedBox()),
                  // Expanded(child: SizedBox())
                ],
              ),

              SizedBox(height: 16),

              // Fifth Row: Three Text Fields
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: _costController,
                      labelText: ' المبلغ',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter cost';
                        }
                      },
                      onChanged: (v) {
                        Provider.of<ActionBankController>(context,
                                listen: false)
                            .setNumberWord(_costController.text, '');
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MyTextField(
                      controller: _namberKedeController,
                      labelText: 'رقم القيد',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter namber kede';
                        }
                      },
                    ),
                  ),
                  // Expanded(child: SizedBox())
                  // Expanded(
                  //   child: MyTextField(
                  //     controller: _dateController,
                  //     labelText: 'اسم الملاحضة',
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Please enter date';
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 16),
              Consumer<ActionBankController>(
                builder: (context, walletProvider, child) {
                  return MyTextField(
                    controller: TextEditingController(
                      text: walletProvider.numberWord,
                    ),
                    enabled: false,
                    labelText: "المبلغ كتابة",
                  );
                },
              ),

              SizedBox(height: 24), // More spacing before the button

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      SmartDialog.showLoading();
                      await Provider.of<ActionBankController>(context,
                              listen: false)
                          .addpay(_costController.text.toString(),
                              _namberKedeController.text.toString());
                      snackBar(context, "تمت العملية بمجاح", false);
                    } catch (e) {
                      snackBar(context, e.toString(), true);
                    } finally {
                      SmartDialog.dismiss();
                    }
                  }
                },
                child: Text('اضافة'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ... (rest of the code remains the same)

  Widget _buildDropdown<T>(
      String labelText, List<T> items, ValueChanged<dynamic> onChanged) {
    return DropdownButtonFormField<dynamic>(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      // value: items.isEmpty ? "" : items.first,
      items: items.map((dynamic toElement) {
        return DropdownMenuItem(
          child: Text(toElement!.name.toString()),
          value: toElement,
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDynamicDropdown(
      String labelText, List<dynamic> items, ValueChanged<dynamic> onChanged) {
    return DropdownButtonFormField<dynamic>(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      value: items.isEmpty ? "" : items.first,
      items: items.map((dynamic toElement) {
        return DropdownMenuItem(
          child: Text(toElement.name!),
          value: toElement,
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select an item';
        }
        return null;
      },
    );
  }
}