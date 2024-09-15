import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/mybuyer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SellerController extends ChangeNotifier {
  List mySmallBank = [];
  List mySmallBank2 = [];

  String wallet_USD = "";

  String wallet_IQD = "";

  Future getCompany(String id) async {
    Response x;
    try {
      x = await getpi("/api/hotel_pay/index/buyer?buyer_id=$id");
      var data = jsonDecode(x.body);
      print(x.body);
      // wallet_USD = formatPrice(data["cost_ras"]).toString();
      // // wallet_IQD = data["cost_iqd"].toString();
      mySmallBank = data["data"].map((json) => MyBuyer.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future getBuyerPay(String id) async {
    Response x;
    try {
      x = await getpi("/api/hotel_tick/index/pay/buyer?buyer_id=$id");
      var data = jsonDecode(x.body);
      print(x.body);
      // wallet_USD = formatPrice(data["cost_ras"]).toString();
      // // wallet_IQD = data["cost_iqd"].toString();
      // mySmallBank = data["data"].map((json) => MyBuyer.fromJson(json)).toList();
      // notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }
}
