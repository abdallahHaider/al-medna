import 'package:admin/models/transport.dart';
import 'package:flutter/material.dart';

class DirectController extends ChangeNotifier {
  String selectedTransport = '';
  String selectedRoute = '';

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
}
