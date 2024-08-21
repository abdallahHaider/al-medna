import 'dart:convert';

import 'package:admin/api%20server/api_servers.dart';
import 'package:admin/models/safe.dart';
import 'package:admin/screens/widgets/snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:spelling_number/spelling_number.dart';

class WalletProvider extends ChangeNotifier {
  bool isError = false;
  String errorMessage = '';
  String numberWord = "";
  bool isLoading = false;
  List wallets = [];

  @override
  void dispose() {
    numberWord = ""; // Clear the number word when the provider is disposed
    super.dispose();
  }

  Future<void> getWallet() async {
    print("1111111111111111");
    isLoading = true;
    notifyListeners();
    try {
      var x = await getpi("/api/safe_doc/index");
      print(x.body);
      var data = jsonDecode(x.body);
      wallets =
          data["data"]["data"].map((josn) => Safe.fromJson(josn)).toList();
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

  Future Addpay(String type, String numberKade, String owner, String cost,
      String ItoU, String note, BuildContext context) async {
    SmartDialog.showLoading();
    http.Response x;
    try {
      x = await postApi("/api/safe_doc/create", {
        "type": type,
        "number_kade": numberKade,
        "owner": owner,
        "cost": cost,
        "IQD_to_USD": ItoU,
        "note": note,
      });
      print(x.body);
      if (x.statusCode == 200) {
        notifyListeners();
        getWallet();
        snackBar(context, "تمت العملية بنجاح", false);
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

  void setNumberWord(String value) {
    int x = 0;
    if (value.isNotEmpty) {
      x = int.parse(value);
      numberWord = SpellingNumber(lang: 'ar').convert(x);
      numberWord =
          "${numberWord} فقط لا غير"; // Add the phrase "only no other" to the word
      notifyListeners();
    }
  }
}
