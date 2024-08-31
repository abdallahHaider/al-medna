import 'dart:io';

import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> ResellerToPdf(
    Reseller reseller, ResellerDbet dbet, List traps) async {
  final pdf = pw.Document();
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(theme: pw.ThemeData.withFont(base: costmfond)),
      build: (pw.Context context) => pw.Center(
          child: pw
              .Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
        pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text("كشف حساب ",
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                      fontSize: 24, fontBold: pw.Font.courierBold())),
            ]),
        pw.SizedBox(height: 20),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Expanded(
              child: pw.Container(
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Text("${reseller.fullName}",
                textDirection: pw.TextDirection.rtl,
                textAlign: pw.TextAlign.center),
          )),
          pw.Expanded(
              child: pw.Container(
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Text("اسم الوكيل ",
                textDirection: pw.TextDirection.rtl,
                textAlign: pw.TextAlign.center),
          )),

          // pw.Text(, textDirection: pw.TextDirection.rtl),
        ]),
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            // إضافة صف العناوين هنا
            pw.TableRow(
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(),
                  top: pw.BorderSide(),
                  left: pw.BorderSide(),
                  right: pw.BorderSide(),
                ),
              ),
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child:
                      pw.Text("المتبقي", textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("السداد", textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("رقم الفاتورة",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("مجموع الحساب",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("عدد المعتمرين",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child:
                      pw.Text("التاريخ", textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("رقم الرحلة",
                      textDirection: pw.TextDirection.rtl),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Text("ت", textDirection: pw.TextDirection.rtl),
                ),
              ],
            ),
            // إضافة البيانات بعد صف العناوين
            ...List.generate(
              traps.length,
              (index) {
                bool ispay = traps[index].type == "trap_pay" ? true : false;
                return pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: ispay ? null : PdfColors.grey400,
                    border: pw.Border(
                      bottom: pw.BorderSide(),
                      top: pw.BorderSide(),
                      left: pw.BorderSide(),
                      right: pw.BorderSide(),
                    ),
                  ),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(traps[index].nowDebt.toString(),
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(ispay ? traps[index].price.toString() : "",
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(ispay ? traps[index].id.toString() : "",
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(ispay ? "" : traps[index].price.toString(),
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(
                          ispay ? "" : traps[index].quantity.toString(),
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(
                          traps[index].createdAt.toString().substring(0, 10),
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text(ispay ? "" : traps[index].id.toString(),
                          textDirection: pw.TextDirection.rtl),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Text((index + 1).toString(),
                          textDirection: pw.TextDirection.rtl),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(children: [
                  pw.Text("مجموع المتبقي", textDirection: pw.TextDirection.rtl),
                  pw.Container(
                    padding:
                        pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: pw.Text(
                        "${(dbet.totalCostUsdPays ?? 0) - (dbet.totalCostUsd ?? 0)}",
                        style: pw.TextStyle(fontSize: 20),
                        textDirection: pw.TextDirection.rtl),
                  ),
                ]),
              ),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(children: [
                  pw.Text("مجموع السداد ", textDirection: pw.TextDirection.rtl),
                  pw.Container(
                    padding:
                        pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: pw.Text("${dbet.totalCostUsdPays}",
                        style: pw.TextStyle(fontSize: 20),
                        textDirection: pw.TextDirection.rtl),
                  ),
                ]),
              ),
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(children: [
                  pw.Text("مجموع الطلب ", textDirection: pw.TextDirection.rtl),
                  pw.Container(
                    padding:
                        pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: pw.Text("-${dbet.totalCostUsd}",
                        style: pw.TextStyle(fontSize: 20),
                        textDirection: pw.TextDirection.rtl),
                  ),
                ]),
              ),
              // pw.Text("مجموع التسديدات  : ${dbet.totalCostUsdPays}",
              //     textDirection: pw.TextDirection.rtl),
              // pw.Text("عدد التسديدات : ${dbet.countPays}",
              //     textDirection: pw.TextDirection.rtl),
              // pw.Text(
              //     "مجموع المتبقي : ${(dbet.totalCostUsdPays ?? 0) - (dbet.totalCostUsd ?? 0)}",
              //     textDirection: pw.TextDirection.rtl),
            ])
      ])),
    ),
  );

  // // حفظ ملف PDF على الويب
  // final bytes = await pdf.save();
  // final blob = html.Blob([bytes], 'application/pdf');
  // final url = html.Url.createObjectUrlFromBlob(blob);
  // final anchor = html.AnchorElement(href: url)
  //   ..setAttribute("download", "example.pdf")
  //   ..click();
  // html.Url.revokeObjectUrl(url);

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/${reseller.fullName}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);
}
