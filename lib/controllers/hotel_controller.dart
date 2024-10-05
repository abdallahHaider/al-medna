import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/buyer.dart';
import 'package:admin/models/hotel.dart';
import 'package:admin/models/hotel_buy.dart';
import 'package:admin/models/reseller.dart';
// import 'package:admin/screens/hotel/hotel_profile.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

class HotelController extends ChangeNotifier {
  List hotels = [];
  List hotels2 = [];
  List hotelsM = [];
  List hotelsPay = [];
  List hotelsSale = [];
  List hotelbuy = [];
  List buyers = [];
  String total_cost = "0";
  bool isLading = true;
  bool isMagk = true;
  bool isMagk2 = true;

  Future fetchData(bool maka, bool type) async {
    try {
      var x = await getpi(
          "/api/hotel/index/${type ? "buy" : "sell"}?type=${maka ? "مكة" : "المدينة"}");
      print(x.body);
      var data = jsonDecode(x.body);
      final List resellers = data.map((json) => Hotel.fromJson(json)).toList();
      if (type) {
        hotelsPay = resellers;
      } else {
        hotelsSale = resellers;
      }
      notifyListeners();
    } catch (e) {
      print("11111111111111111111");
      print(e);
      throw "jjj";
    } finally {
      isLading = false;
      notifyListeners();
    }
  }

  Future getFetchData(bool ismaka) async {
    try {
      var x =
          await getpi("/api/hotel/index?type=${ismaka ? "مكة" : "المدينة"}");
      print(x.body);
      var data = jsonDecode(x.body);
      final List resellers =
          data.map((json) => Reseller.fromJson(json)).toList();
      if (ismaka) {
        hotels = resellers;
        // hotels2 = resellers;
      } else {
        hotels2 = resellers;
        // hotels = resellers;
        hotelsM = resellers;
      }

      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addReseller(String name, String phone_number, String address,
      BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel/create", {
        "full_name": name,
        "address": address,
        "phone_number": phone_number,
      });

      //  Navigator.pop(context);
    } catch (e) {
      snackBar(context, "حصل خطا غير متوقع", true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      // fetchData();
      // notifyListeners();
      snackBar(context, "تم اضافة الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
    }
  }

  Future delete(int id, BuildContext context) async {
    print(id);
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel/delete", {
        "id": id,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      // notifyListeners();
      // Navigator.pop(context);
      snackBar(context, "تم حذف الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future getHotelBuy(id) async {
    try {
      var x = await getpi("/api/hotel_tick/index/buy?hotel_id=$id");
      print(x.body);
      var data = jsonDecode(x.body);
      total_cost = data["total_cost"].toString();
      hotelbuy = data["data"].map((json) => HotelBuy.fromJson(json)).toList();
      print(x.body);
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addBuyHotel(
      hotel_id,
      String rooms,
      String room_price_per_night,
      String nights,
      String number_of_floors,
      String number_of_rooms_for_each_floor,
      BuildContext context) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_tick/create", {
        "hotel_id": hotel_id,
        "rooms": rooms.isNotEmpty ? rooms : 0,
        "nights": nights,
        "curreny": "ras",
        "number_of_floors": number_of_floors.isNotEmpty ? number_of_floors : 0,
        "number_of_rooms_for_each_floor":
            number_of_rooms_for_each_floor.isNotEmpty
                ? number_of_rooms_for_each_floor
                : 0,
        "room_price_per_night": room_price_per_night,
      });
    } catch (e) {
      snackBar(context, "حصل خطا غير متوقع", true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      getHotelBuy(hotel_id);
      snackBar(context, "تم اضافة الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body)["message"], true);
    }
  }

  Future getHotelSale(id) async {
    print(id);
    try {
      var x = await getpi("/api/hotel_tick/index/pay?hotel_id=$id");
      print(x.body);
      var data = jsonDecode(x.body);
      total_cost = data["total_cost"].toString();
      hotelbuy = data["data"].map((json) => HotelBuy.fromJson(json)).toList();
      print(x.body);
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addSaleHotel(
      hotel_id,
      String rooms,
      String room_price_per_night,
      String RAS,
      String nights,
      BuildContext context,
      String reseller_id,
      String buyer_name) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_tick/create", {
        if (reseller_id.isNotEmpty) "reseller_id": reseller_id,
        if (buyer_name.isNotEmpty) "buyer_id": buyer_name,
        "hotel_id": hotel_id,
        "curreny": RAS,
        "rooms": rooms,
        "nights": nights,
        "room_price_per_night": room_price_per_night,
        "number_of_floors": 0,
        "number_of_rooms_for_each_floor": 0,
      });
    } catch (e) {
      snackBar(context, e.toString(), false);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      getHotelSale(hotel_id);
      snackBar(context, "تم اضافة الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future deleted(String id, BuildContext context) async {
    print(id);
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_tick/delete", {
        "id": id,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      Navigator.pop(context);
      snackBar(context, "تم حذف الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future getHotelPay(id) async {
    print(id);
    try {
      var x = await getpi("/api/hotel_pay/index/hotel?hotel_id=$id");
      var data = jsonDecode(x.body);
      print(x.body);

      // total_cost = data["total_cost"].toString();
      buyers = data["data"].map((json) => Buyer.fromJson(json)).toList();
      print(x.body);
      notifyListeners();
    } catch (e) {
      print(e);
      throw "jjj";
    }
  }

  Future addSalepay(
    // hotel_id,
    String hotel_id,
    String buyer_id,
    String cost_USD,
    String note,
    BuildContext context,
    // String reseller_id,
    // String buyer_name
  ) async {
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_pay/create", {
        "hotel_id": hotel_id,
        "buyer_id": buyer_id,
        "cost_USD": cost_USD,
        "note": note,
      });
    } catch (e) {
      // snackBar(context, e.toString(), false);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      getHotelPay(hotel_id);
      snackBar(context, "تم اضافة الفندق بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }

  Future hotelPayDelete(int id, BuildContext context) async {
    print(id);
    http.Response x;
    try {
      SmartDialog.showLoading();
      x = await postApi("/api/hotel_pay/delete", {
        "id": id,
      });
    } catch (e) {
      snackBar(context, e.toString(), true);
      throw e;
    } finally {
      SmartDialog.dismiss();
    }
    print(x.body);
    if (x.statusCode == 200 || x.statusCode == 201) {
      notifyListeners();
      Navigator.pop(context);
      snackBar(context, "تم حذف التسديد بنجاح", false);
    } else {
      snackBar(context, jsonDecode(x.body), true);
    }
  }
}
