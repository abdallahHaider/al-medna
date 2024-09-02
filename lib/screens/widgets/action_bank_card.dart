import 'package:admin/controllers/action_bank_controller.dart';
import 'package:admin/models/action.dart';
import 'package:admin/models/type_cost.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class ActionBankCard extends StatelessWidget {
  ActionBankCard({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();
  final _namberKedeController = TextEditingController();
  final _costController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<TypeAction2>(
                  decoration: InputDecoration(
                    labelText: "نوع العملية",
                    border: OutlineInputBorder(),
                  ),
                  items: TypeAction2.actions.map((TypeAction2 toElement) {
                    return DropdownMenuItem(
                      child: Text(toElement.name),
                      value: toElement,
                    );
                  }).toList(),
                  onChanged: (value) {
                    // type = value!.id;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: defaultPadding),
                DropdownButtonFormField<TypeAction3>(
                  decoration: InputDecoration(
                    labelText: "من",
                    border: OutlineInputBorder(),
                  ),
                  items: TypeAction3.actions.map((TypeAction3 toElement) {
                    return DropdownMenuItem(
                      child: Text(toElement.name),
                      value: toElement,
                    );
                  }).toList(),
                  onChanged: (value) {
                    // type = value!.id;
                    print("2222222222222222222222");
                    Provider.of<ActionBankController>(context, listen: false)
                        .setType(value!.name);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: defaultPadding),
                Consumer<ActionBankController>(
                  builder: (context, ref, child) =>
                      DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      labelText: "",
                      border: OutlineInputBorder(),
                    ),
                    items: ref.mineActions.map((dynamic toElement) {
                      return DropdownMenuItem(
                        child: Text(toElement.name!),
                        value: toElement,
                      );
                    }).toList(),
                    onChanged: (value) {
                      // type = value!.id;
                      print(value.id);
                      Provider.of<ActionBankController>(context, listen: false)
                          .fromID = value.id.toString();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select type';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: defaultPadding),
                DropdownButtonFormField<TypeAction3>(
                  decoration: InputDecoration(
                    labelText: "الى",
                    border: OutlineInputBorder(),
                  ),
                  items: TypeAction3.actions.map((TypeAction3 toElement) {
                    return DropdownMenuItem(
                      child: Text(toElement.name),
                      value: toElement,
                    );
                  }).toList(),
                  onChanged: (value) {
                    // type = value!.id;
                    Provider.of<ActionBankController>(context, listen: false)
                        .setTypeTO(value!.name);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: defaultPadding),
                Consumer<ActionBankController>(
                  builder: (context, ref, child) =>
                      DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      labelText: "",
                      border: OutlineInputBorder(),
                    ),
                    items: ref.mineActionsTO.map((dynamic toElement) {
                      return DropdownMenuItem(
                        child: Text(toElement.name!),
                        value: toElement,
                      );
                    }).toList(),
                    onChanged: (value) {
                      // type = value!.id;
                      Provider.of<ActionBankController>(context, listen: false)
                          .toID = value.id.toString();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select type';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: defaultPadding),
                DropdownButtonFormField<TypeCost>(
                  decoration: InputDecoration(
                    labelText: "العملة",
                    border: OutlineInputBorder(),
                  ),
                  items: TypeCost.costs.map((TypeCost toElement) {
                    return DropdownMenuItem(
                      child: Text(toElement.name),
                      value: toElement,
                    );
                  }).toList(),
                  onChanged: (value) {
                    // type = value!.id;
                    if (value!.id == "1") {
                      Provider.of<ActionBankController>(context, listen: false)
                          .isIQD = "t";
                    } else {
                      Provider.of<ActionBankController>(context, listen: false)
                          .isIQD = "f";
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: defaultPadding),
                MyTextField(
                  controller: _costController,
                  labelText: ' المبلغ',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter cost';
                    }
                  },
                ),
                SizedBox(height: defaultPadding),
                MyTextField(
                  controller: _namberKedeController,
                  labelText: 'رقم القيد',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter namber kede';
                    }
                  },
                ),
                SizedBox(height: defaultPadding),
                MyTextField(
                  controller: _dateController,
                  labelText: 'اسم الملاحضة',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter date';
                    }
                  },
                ),
                SizedBox(height: defaultPadding),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.blue,
                      ),
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
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
