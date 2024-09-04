import 'dart:convert';
import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/company.dart';
import 'package:admin/models/companyy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CompanyController extends ChangeNotifier {
  List companys = [];
  List myCompanys = [];

  String total_price_t = "";
  String total_room_price_per_night = "";
  String total = "";
  int page = 1;

  Future getCompanys() async {
    Response x;
    try {
      x = await getpi("/api/company/index");
      print(x.body);
      var data = jsonDecode(x.body);
      companys = data.map((json) => Company.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future addBank(String name) async {
    Response x;
    try {
      x = await postApi("/api/company/create", {"name": name});
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getCompanys();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  Future deletbank(id) async {
    Response x;
    try {
      x = await postApi("/api/company/delete", {"id": id});
      if (x.statusCode == 200) {
        getCompanys();
      } else {
        print(x.body);
        throw jsonDecode(x.body);
      }
    } catch (e) {
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future deletCompanyPor(id) async {
    Response x;
    try {
      x = await postApi(
          "/api/company_program/delete", {"company_program_id": id});
      if (x.statusCode == 200) {
        // getCompanys();
        notifyListeners();
      } else {
        print(x.body);
        throw jsonDecode(x.body);
      }
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future getAllData(String id) async {
    Response x;
    try {
      x = await getpi("/api/company_program/index?page=$page&id=$id");
      var data = jsonDecode(x.body);
      print(x.body);
      total = data["total"].toString();
      total_price_t = data["total_price_t"].toString();
      total_room_price_per_night =
          data["total_room_price_per_night"].toString();

      myCompanys = data["data"].map((json) => Companyy.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
  }

  Future addMove(
    String company_id,
    String group_number,
    String number_t,
    String price_t,
    String hotel_name,
    String rooms,
    String nights,
    String room_price_per_night,
    String created_at,
  ) async {
    Response x;
    try {
      x = await postApi("/api/company_program/create", {
        "company_id": company_id,
        "group_number": group_number,
        "number_t": number_t,
        "price_t": price_t,
        "hotel_name": hotel_name,
        "rooms": rooms,
        "nights": nights,
        "room_price_per_night": room_price_per_night,
        "created_at": created_at,
      });
    } catch (e) {
      print(e);
      throw "حصل خطا في ارسال البيانات";
    }
    if (x.statusCode == 200 || x.statusCode == 201) {
      getCompanys();
      print(x.body);
    } else {
      throw jsonDecode(x.body);
    }
  }

  void updete(String id, int page) {
    this.page = this.page + page;
    getAllData(id);
  }

  // Future getDealsData(String id) async {
  //   Response x;
  //   try {
  //     x = await getpi("/api/company_program/index?page=$page&id=$id");
  //     var data = jsonDecode(x.body);
  //     print(x.body);
  //     myCompanys = data["data"].map((json) => Companyy.fromJson(json)).toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     throw "حصل خطا في ارسال البيانات";
  //   }
  // }
}
