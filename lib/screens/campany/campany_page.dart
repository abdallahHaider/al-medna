import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

class CampanyPage extends StatefulWidget {
  const CampanyPage({super.key});

  @override
  State<CampanyPage> createState() => _CampanyPageState();
}

class _CampanyPageState extends State<CampanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Header(title: "حساب الشركات"),
        Expanded(
          child: Card(),
        ),
      ]),
    );
  }
}
