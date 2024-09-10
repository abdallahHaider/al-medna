import 'package:admin/controllers/hotel_controller.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> deleteHotel(
    BuildContext context, Reseller snapshot, int index) {
  return showDialog(
    context: context,
    builder: (c) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Column(
          children: [
            SizedBox(
              height: defaultPadding * 2,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Header(title: 'حذف فندق'),
                    SizedBox(height: defaultPadding),
                    Text("هل أنت متأكد من أنك تريد حذف الفندق؟"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<HotelController>(context,
                                    listen: false)
                                .delete(snapshot.id!, context);
                          },
                          child: Text('حذف'),
                        ),
                        InkWell(
                          child: Text(
                            "إلغاء",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
