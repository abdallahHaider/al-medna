import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/format_price.dart';
import 'package:admin/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TransactionsController extends ChangeNotifier {
  List mySmallBank = [];

  String wallet_USD = "";

  String wallet_IQD = "";

  Future getmySmallBank(String id) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/transactions/index/small_bank?small_bank_id=$id");
      var data = jsonDecode(x.body);
      print(x.body);
      wallet_USD = data["cost_usd"].toString();
      wallet_IQD = data["cost_iqd"].toString();
      mySmallBank = data["data"]["data"]
          .map((json) => Transactions.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future getCompany(String id) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/transactions/index/company?company_id=$id");
      var data = jsonDecode(x.body);
      print(x.body);
      wallet_USD = formatPrice(data["cost_ras"]).toString();
      // wallet_IQD = data["cost_iqd"].toString();
      mySmallBank = data["data"]["data"]
          .map((json) => Transactions.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future getmyBank(String id) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Response x;
    try {
      x = await getpi("/api/transactions/index/bank?bank_id=$id");
      var data = jsonDecode(x.body);
      print(x.body);
      wallet_USD = data["cost_usd"].toString();
      wallet_IQD = data["cost_iqd"].toString();
      mySmallBank = data["data"]["data"]
          .map((json) => Transactions.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future deletSmallbank(id) async {
    Response x;
    try {
      x = await postApi("/api/transactions/delete", {"transaction_id": id});
      if (x.statusCode == 200) {
        // getmyBank();
        notifyListeners();
      } else {
        print(x.body);
        throw jsonDecode(x.body);
      }
    } catch (e) {
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future SendLocalPay(String id, String amount, String name) async {
    Response x;
    try {
      x = await postApi("/api/transactions/create/company", {
        "company_id": id,
        "sender_name": name,
        "cost_RAS": amount,
      });
      if (x.statusCode == 200 || x.statusCode == 201) {
        getCompany(id);
        // notifyListeners();
      } else {
        print(x.body);
        throw jsonDecode(x.body);
      }
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }
}
