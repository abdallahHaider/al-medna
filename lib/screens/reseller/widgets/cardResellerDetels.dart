import 'package:admin/controllers/reseller_controller.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/utl/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Card cardResellerDetels(Reseller resellerID) {
  return Card(
      color: secondaryColor,
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "اسم الوكيل: ${resellerID.fullName!}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "رقم الوكيل: ${resellerID.id}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "رقم الهاتف: ${resellerID.phoneNumber}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "العنوان: ${resellerID.address}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ]),
              ),
              Expanded(
                child: Consumer<ResellerController>(
                    builder: (context, ref, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "مجموع الطلب: ${ref.resellerDbet.totalCostUsd!}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "مجموع التسديدات: ${ref.resellerDbet.totalCostUsdPays!}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "عدد التسديدات: ${ref.resellerDbet.countPays}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        "مجموع المتبقي: ${resellerID.now_debt}",
                        style: TextStyle(
                          color: double.parse(resellerID.now_debt!) < 0
                              ? Colors.red
                              : Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                }),
              )
            ],
          )));
}
