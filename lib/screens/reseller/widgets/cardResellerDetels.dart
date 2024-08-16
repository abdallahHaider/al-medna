import 'package:admin/models/reseller.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';

Card cardResellerDetels(Reseller resellerID) {
  return Card(
      color: secondaryColor,
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "اسم الوكيل: ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  resellerID.fullName!,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "رقم الوكيل: ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  resellerID.id.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "رقم الهاتف: ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  resellerID.phoneNumber!,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "العنوان: ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  resellerID.address!,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ])));
}
