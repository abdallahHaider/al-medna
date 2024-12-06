import 'dart:convert';
import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/momter.dart';
import 'package:admin/models/momterPay.dart';
import 'package:admin/models/transport.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class DirectController extends ChangeNotifier {
  String selectedTransport = '';
  String selectedRoute = '';
  bool is_archive = false;

  List momters = [];
  List momterPays = [];

  List<Transport> transports = [
    Transport(name: "بري", id: "street"),
    Transport(name: "جوي", id: "fly"),
  ];

  List<Transport> directTpye = [
    Transport(name: "اقساط", id: "K"),
    Transport(name: "مباشر", id: "D"),
  ];

  void onStaet() {
    selectedTransport = transports.first.id;
    selectedRoute = directTpye.first.id;
    notifyListeners();
  }

  void setSelectedRoute(String value) {
    selectedRoute = value;
    notifyListeners();
  }

  void setSelectedTransport(String value) {
    selectedRoute = value;
    notifyListeners();
  }

  void setArchive(bool value) {
    is_archive = value;
    notifyListeners();
    getDirect(is_archive);
  }

  Future<void> AddDirect(
    BuildContext context,
    String name_of_tripe,
    String momtamer_name,
    String phone_number,
    String date_of_trip,
    String cost,
    String number_of_pushes,
    String date_of_start,
  ) async {
    try {
      SmartDialog.showLoading();
      var response = await postApi("/api/drictapays/create", {
        "name_of_tripe": name_of_tripe,
        "momtamer_name": momtamer_name,
        "phone_number": phone_number,
        "address": "..",
        "date_of_trip": date_of_trip,
        "cost": cost,
        if (number_of_pushes.isNotEmpty) "number_of_pushes": number_of_pushes,
        "date_of_start": date_of_start,
        if (number_of_pushes.isNotEmpty)
          "day_in_month": date_of_start.substring(8, 10)
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        snackBar(context, "تم الاضافة بنجاح", false);
      } else {
        print(response.statusCode.toString());
        print(response.body);
        snackBar(context, "حدث خطأ", true);
      }
    } catch (e) {
      print(e);
      snackBar(context, " حدث خطأ", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<void> getDirect(bool is_archive) async {
    try {
      momters.clear();
      var response =
          await getpi("/api/momter/index?is_archive=${is_archive ? 1 : 0}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        var data = jsonDecode(response.body);
        momters = data["data"].map((json) => Momter.fromJson(json)).toList();
        // momters = resellers;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> momterDelete(
    BuildContext context,
    String id,
  ) async {
    try {
      SmartDialog.showLoading();
      var response = await postApi("/api/momter/delete", {
        "id": id,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        getDirect(is_archive);
        snackBar(context, "تم الحذف بنجاح", false);
      } else {
        print(response.statusCode.toString());
        print(response.body);
        snackBar(context, "حدث خطأ", true);
      }
    } catch (e) {
      print(e);
      snackBar(context, " حدث خطأ", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<void> getDirectProfiel(String id) async {
    try {
      momterPays.clear();
      var response = await getpi("/api/momterpay/index?id=$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        var data = jsonDecode(response.body);
        momterPays = data.map((json) => MomterPay.fromJson(json)).toList();
        // momters = resellers;
        notifyListeners();
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> archive(
    BuildContext context,
    String id,
    int value,
  ) async {
    try {
      SmartDialog.showLoading();
      var response = await postApi("/api/momter/update", {
        "id": id,
        "is_archive": value,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        getDirect(is_archive);
        notifyListeners();
        snackBar(context, "تم الاضافة بنجاح", false);
      } else {
        print(response.statusCode.toString());
        print(response.body);
        snackBar(context, "حدث خطأ", true);
      }
    } catch (e) {
      print(e);
      snackBar(context, " حدث خطأ", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<void> payUpdete(
    BuildContext context,
    String id,
    String value,
    String idM,
  ) async {
    print("88888888888");
    try {
      SmartDialog.showLoading();
      var response = await postApi("/api/momterpay/update", {
        "id": id,
        "cost": value,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        getDirectProfiel(idM);
        notifyListeners();
        Navigator.pop(context);
        snackBar(context, "تم الاضافة بنجاح", false);
      } else {
        print(response.statusCode.toString());
        print(response.body);
        Navigator.pop(context);
        snackBar(context, "حدث خطأ", true);
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      snackBar(context, " حدث خطأ", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<void> payDelete(
    BuildContext context,
    String id,
    String idM,
  ) async {
    try {
      SmartDialog.showLoading();
      var response = await postApi("/api/momterpay/delete", {
        "id": id,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        getDirectProfiel(idM);
        notifyListeners();
        snackBar(context, "تم الحذف بنجاح", false);
      } else {
        print(response.statusCode.toString());
        print(response.body);
        snackBar(context, "حدث خطأ", true);
      }
    } catch (e) {
      print(e);
      snackBar(context, " حدث خطأ", true);
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future<void> momterpay(
    BuildContext context,
    String id,
    String cost,
  ) async {
    try {
      SmartDialog.showLoading();
      var response = await postApi("/api/momterpay/create", {
        "drict_id": id,
        "cost": cost,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        getDirectProfiel(id);
        notifyListeners();
        snackBar(context, "تم الاضافة بنجاح", false);
      } else {
        print(response.statusCode.toString());
        print(response.body);
        snackBar(context, "حدث خطأ", true);
      }
    } catch (e) {
      print(e);
      snackBar(context, " حدث خطأ", true);
    } finally {
      SmartDialog.dismiss();
    }
  }
}
