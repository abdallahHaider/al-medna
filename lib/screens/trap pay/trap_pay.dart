import 'package:admin/controllers/trap_pay_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/trap%20pay/widgets/addPay.dart';
import 'package:admin/screens/trap%20pay/widgets/dataTibel.dart';
import 'package:admin/utl/constants.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Header(
                  title: 'التسديدات',
                ),
              ),
            ],
          ),
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
          SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: dataTibel(),
                ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 1,
                    child: addPay(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
