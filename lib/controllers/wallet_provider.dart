import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/safe.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:spelling_number/spelling_number.dart';
class Wallet {
  final String id;
  final String owner;
  final double? costIQD;
  final double? costUSD;
  final String note;
  final String type;
  final DateTime createdAt;

  Wallet({
    required this.id,
    required this.owner,
    this.costIQD,
    this.costUSD,
    required this.note,
    required this.type,
    required this.createdAt,
  });
}

class WalletProvider extends ChangeNotifier {
  bool isError = false;
  String errorMessage = '';
  String numberWord = "";
  bool isLoading = false;
  List wallets = [];
  var wallet_IQD = 0;
  var wallet_USD = 0;
  int page = 1;

  @override
  void dispose() {
    numberWord = ""; // Clear the number word when the provider is disposed
    super.dispose();
  }

  Future<void> getWallet(bool isSafeDoc) async {
    isLoading = true;
    // notifyListeners();
    try {
      var x = await getpi(
          "/api/safe_doc/index${isSafeDoc ? "/non" : ""}?page=$page");
      if (x.statusCode != 200) {
        print(x.body);
      }
      var data = jsonDecode(x.body);
      wallets =
          data["data"]["data"].map((json) => Safe.fromJson(json)).toList();
      wallet_IQD = data["cost_IQD"];
      wallet_USD = data["cost_USD"];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      isError = true;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future Addpay(bool isSafeDoc, String type, String numberKade, String owner,
      String costIQD, String costUSD, String note, BuildContext context) async {
    SmartDialog.showLoading();
    http.Response x;
    try {
      x = await postApi("/api/safe_doc/create", {
        "is_safeDoc": isSafeDoc,
        "type": type,
        "number_kade": numberKade,
        "owner": owner,
        if (costIQD.isNotEmpty) "cost_IQD": costIQD,
        // costIQD.isEmpty ? "" : ,
        costUSD.isEmpty ? "" : "cost_USD": costUSD,
        // "cost_USD": "11111",
        "IQD_to_USD": "0",
        "note": note,
      });
      if (x.statusCode == 200) {
        // notifyListeners();
        if (isSafeDoc) {
          getWallet(true);
        } else {
          getWallet(false);
        }

        snackBar(context, "تمت العملية بنجاح", false);
      } else {
        print(x.body);
        snackBar(context, jsonDecode(x.body)["message"], true);
      }
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      errorMessage = e.toString();
    } finally {
      SmartDialog.dismiss();
    }
  }

  Future deletWallet(bool isSafeDoc, int id, BuildContext context) async {
    SmartDialog.showLoading();
    http.Response x;
    try {
      x = await postApi("/api/safe_doc/delete", {"safe_id": id});
      print(x.body);
      if (x.statusCode == 200) {
        if (isSafeDoc) {
          getWallet(true);
        } else {
          getWallet(false);
        }
        notifyListeners();
        snackBar(context, "تمت الحذف بنجاح", false);
        Navigator.pop(context);
      } else {
        snackBar(context, jsonDecode(x.body)["message"], true);
      }
    } catch (e) {
      snackBar(context, e.toString(), true);
      print(e);
      errorMessage = e.toString();
    } finally {
      SmartDialog.dismiss();
    }
  }

  void setNumberWord(String value, String type) {
    int x = 0;
    if (value.isNotEmpty) {
      x = int.parse(value);
      numberWord = SpellingNumber(lang: 'ar').convert(x);
      numberWord =
          "${numberWord} $type فقط لا غير "; // Add the phrase "only no other" to the word
      notifyListeners();
    }
  }

  void clearNumberWord() {
    numberWord = "";
    notifyListeners();
  }

  void getPage(int lockage, bool isSafeDoc) {
    if (page > 0) {
      page = page + lockage;
      if (isSafeDoc) {
        getWallet(true);
      } else {
        getWallet(false);
      }
    }
  }
}
