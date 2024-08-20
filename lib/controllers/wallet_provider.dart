import 'package:flutter/material.dart';
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
    isLoading = true;
    notifyListeners();
    try {
      // API call to get wallet
      await Future.delayed(Duration(seconds: 2));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
      errorMessage = e.toString();
      notifyListeners();
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
