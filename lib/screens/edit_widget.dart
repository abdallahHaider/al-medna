import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/widgets/my_button.dart';
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
    return Card(
      // margin: const EdgeInsets.all(defaultPadding),
      // padding: EdgeInsets.all(defaultPadding),
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
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
                MyButton(onPressed: savePressed, child: Text("حفظ")),
                MyButton(onPressed: canselPressed, child: Text("الغاء"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
