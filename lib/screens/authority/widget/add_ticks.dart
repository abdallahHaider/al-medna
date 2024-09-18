import 'package:admin/controllers/authority_controller.dart';
import 'package:admin/screens/authority/authority_profiel.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_text_field.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class addTicks extends StatelessWidget {
  addTicks({
    super.key,
    // required this.number,
    // required this.cost,
    // required this.commission,
    required this.widget,
  });

  final number = TextEditingController();
  final cost = TextEditingController();
  final commission = TextEditingController();
  final name = TextEditingController();
  final number_of_child = TextEditingController();
  final price_of_child = TextEditingController();
  final AuthorityProfile widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Header(title: "اضافة حجز"),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          MyTextField(
            labelText: "اسم الوكيل",
            controller: name,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          MyTextField(
            labelText: "عدد المسافرين",
            controller: number,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          MyTextField(
            labelText: "السعر لكل مسافر",
            controller: cost,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          MyTextField(
            labelText: "عدد الاطفال",
            controller: number_of_child,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          MyTextField(
            labelText: "سعر الطفل",
            controller: price_of_child,
          ),
          MyTextField(
            labelText: "العمولة",
            controller: commission,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
              onPressed: () async {
                await Provider.of<AuthorityController>(context, listen: false)
                    .addAuthorityTicks(
                        widget.id,
                        number.text,
                        cost.text,
                        commission.text,
                        number_of_child.text,
                        price_of_child.text,
                        name.text,
                        context);
                Provider.of<AuthorityController>(context, listen: false)
                    .getAuthorityTicks(widget.id);
              },
              child: Text("اضافة"))
        ],
      ),
    );
  }
}
