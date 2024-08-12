import 'dart:convert';

import 'package:admin/utl/api.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postApi(String endpoint, Map<String, dynamic> body) async {
  final response =
      await http.post(Uri.parse('$bessUrl$endpoint'), body: jsonEncode(body), headers: {
    'Content-Type': 'application/json',
    
  });
  return response;
}

Future<http.Response> getpi(String endpoint) async {
  final response = await http.get(Uri.parse('$bessUrl$endpoint'), headers: {
    'Content-Type': 'application/json',
  });
  return response;
}
