import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

class ErorrWidget extends StatelessWidget {
  const ErorrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            color: Colors.red,
            // margin: EdgeInsets.all(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 150, vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber,
                    size: 100,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text('حصلت مشكلة في جلب البيانات'),
                ],
              ),
            )));
  }
}
