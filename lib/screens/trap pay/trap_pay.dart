import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/screens/trap%20pay/widgets/addPay.dart';
import 'package:admin/screens/trap%20pay/widgets/dataTibel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/components/header.dart';

class TrapPayPage extends StatefulWidget {
  @override
  State<TrapPayPage> createState() => _TrapPayPageState();
}

class _TrapPayPageState extends State<TrapPayPage> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    Provider.of<TrapPayController>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          title: 'التسديدات',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addPay(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Provider.of<TrapPayController>(context, listen: false)
                        .addpage(-1);
                  },
                  child: Text("الصفحة السابقة")),
              Consumer<TrapPayController>(
                builder: (context, TrapPayController controller, child) {
                  return Text("الصفحة :${controller.page}");
                },
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<TrapPayController>(context, listen: false)
                        .addpage(1);
                  },
                  child: Text("الصفحة التالية")),
            ],
          ),
          Expanded(
            flex: 2,
            child: dataTibel(),
          ),
        ],
      ),
    );
  }
}
