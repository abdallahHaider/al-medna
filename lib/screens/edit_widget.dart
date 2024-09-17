import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class EditWidget extends StatelessWidget {
  const EditWidget({
    super.key,
    required this.savePressed,
    required this.canselPressed,
    required this.buildActions,
  });

  final List<Widget> buildActions;

  final VoidCallback savePressed;
  final VoidCallback canselPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.all(defaultPadding),
      color: secondaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(title: "لوحة التعديل"),
          SizedBox(
            height: defaultPadding,
          ),
          Column(
            children: buildActions,
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: savePressed, child: Text("حفظ")),
              ElevatedButton(onPressed: canselPressed, child: Text("الغاء"))
            ],
          )
        ],
      ),
    );
  }
}
