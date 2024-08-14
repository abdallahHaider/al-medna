import 'package:admin/models/reseller.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

Container cardResellerDetels(Reseller resellerID) {
  return Container(
      color: secondaryColor,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "اسم الوكيل: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  resellerID.fullName!,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "رقم الوكيل: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  resellerID.id.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "رقم الهاتف: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  resellerID.phoneNumber!,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "العنوان: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  resellerID.address!,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ])));
}
