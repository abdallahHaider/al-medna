import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget cardResellerDetels(Reseller resellerID) {
  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "اسم الوكيل",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "رقم الوكيل",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "رقم الهاتف",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "العنوان",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor.withOpacity(0.3)),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "${resellerID.fullName!}",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${resellerID.id}",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${resellerID.phoneNumber}",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "${resellerID.address}",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor),
            child: Table(children: [
              TableRow(children: [
                TableCell(
                  child: Text(
                    "مجموع الطلب",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "مجموع التسديدات",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "عدد التسديدات",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                TableCell(
                  child: Text(
                    "مجموع المتبقي",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ]),
            ]),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    10), // this will be the rounded corner
                color: blueColor.withOpacity(0.3)),
            child: Consumer<ResellerController>(builder: (context, ref, child) {
              return Table(children: [
                TableRow(children: [
                  TableCell(
                    child: Text(
                      "${ref.resellerDbet.totalCostUsd!}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ref.resellerDbet.totalCostUsdPays!}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${ref.resellerDbet.totalCostUsdPays!}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${resellerID.now_debt}",
                      style: TextStyle(
                        color: double.parse(resellerID.now_debt!) < 0
                            ? Colors.red
                            : Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ]),
              ]);
            }),
          ),
        ],
      ));
}
