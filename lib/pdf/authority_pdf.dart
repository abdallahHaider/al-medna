import 'dart:io';
import 'package:admin/models/authority.dart';
import 'package:admin/models/authority_tickt.dart';
import 'package:admin/models/reseller.dart';
import 'package:admin/models/reseller_dbet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html; // Import html for web download support

Future<void> authortiytoPdf(
     List<AuthorityTickt> traps,String name,
       num totalremainingiqd ,num totalcostiqd,num totalpayiqd,
    num totalremainingusd ,num totalcostusd,num totalpayusd) async {
  final pdf = pw.Document();

  // تحميل الخط مرة واحدة
  final fontData = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final customFont = pw.Font.ttf(fontData);

  // تحديد أنماط النص بدون textDirection
  // final textStyle = pw.TextStyle(fontSize: 20);

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: customFont),
        margin: pw.EdgeInsets.all(20),
      ),
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("كشف حساب",
                style:
                    pw.TextStyle(fontSize: 24, fontBold: pw.Font.courierBold()),
                textDirection: pw.TextDirection.rtl),
            pw.SizedBox(height: 20),

            // الصف العلوي لاسم الهيئه
            _buildAgentRow(name ?? "اسم غير متوفر"),
            pw.SizedBox(height: 20),

            // الجدول الرئيسي
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableHeader(),
                ..._buildTableRows(traps),
              ],
            ),
            pw.SizedBox(height: 20),

    //         // ملخص الحساب
            _buildSummary(   totalremainingiqd , totalcostiqd, totalpayiqd,
     totalremainingusd , totalcostusd, totalpayusd),
          ],
        ),
      ),
    ),
  );

  // // حفظ ملف PDF في جهازك
  // final output = await getTemporaryDirectory();
  // final file = File("${output.path}/${name }.pdf");
  // await file.writeAsBytes(await pdf.save());

  // print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // // فتح ملف PDF باستخدام تطبيق خارجي
  // await OpenFilex.open(file.path);
    // // Preview the PDF file
  // await Printing.layoutPdf(
  //   onLayout: (PdfPageFormat format) async => pdf.save(),
  // );
  // // حفظ ملف PDF على الويب
  final bytes = await pdf.save();
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "example.pdf")
    ..click();
  html.Url.revokeObjectUrl(url);

}

// دالة لبناء صف اسم الوكيل
pw.Widget _buildAgentRow(String agentName) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Expanded(
        child: pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          padding: pw.EdgeInsets.all(10),
          child: pw.Text(agentName,
              textAlign: pw.TextAlign.center,
              textDirection: pw.TextDirection.rtl),
        ),
      ),
      pw.Expanded(
        child: pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          padding: pw.EdgeInsets.all(10),
          child: pw.Text("اسم الهيئه",
              textAlign: pw.TextAlign.center,
              textDirection: pw.TextDirection.rtl),
        ),
      ),
    ],
  );
}

// دالة لإنشاء رأس الجدول
pw.TableRow _buildTableHeader() {
  return pw.TableRow(
    decoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(),
        top: pw.BorderSide(),
        left: pw.BorderSide(),
        right: pw.BorderSide(),
      ),
    ),
    children: [
      _buildHeaderCell("التاريخ"),
            _buildHeaderCell("العملة"),
      _buildHeaderCell("الواصل"),
      _buildHeaderCell("المجموع الكلي"),
      _buildHeaderCell("الأجره"),
      _buildHeaderCell("سعر صغير"),
      _buildHeaderCell("هدد صغير"),
      _buildHeaderCell("سعر كبير"),
      _buildHeaderCell("عدد كبير"),
      _buildHeaderCell("اسم ورقم الرحلة"),
      _buildHeaderCell("ت"),
  

    ],
  );
}

// دالة لإنشاء خلية الرأس
pw.Widget _buildHeaderCell(String title) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 5),
    child: pw.Text(title,
        textDirection: pw.TextDirection.rtl, style: pw.TextStyle(fontSize: 10)),
  );
}

// دالة لإنشاء الصفوف من البيانات
List<pw.TableRow> _buildTableRows(List<AuthorityTickt> traps) {
  return List.generate(
    traps.length,
    (index) {
      final trap = traps[index];
      bool isPayment = trap.istyped!;
      print(trap.commission);
      return pw.TableRow(
        decoration: pw.BoxDecoration(
          color: isPayment ==true? null : PdfColors.grey400,
          border: pw.Border.all(),
        ),
        children: [
          _buildTableCell(trap.createdAt.toString().substring(0,11)),
                              _buildTableCell(trap.type.toString()=="iqd"?"دينار":"دولار"),
          _buildTableCell(isPayment ? (trap.totalPrice.toString()) : ""),
          _buildTableCell(isPayment ? "" : (trap.totalPrice.toString())),
          _buildTableCell(isPayment ? "" : (trap.commission.toString())),
          _buildTableCell(isPayment ? "" : (trap.price_of_child.toString())),
          _buildTableCell(isPayment ? "" : (trap.number_of_child.toString())),
          _buildTableCell(isPayment ? "" : (trap.priceOfTravel.toString())),
          _buildTableCell(isPayment ? "" : (trap.numberOfTravel.toString())),
          _buildTableCell(trap.name ?? ""),
          _buildTableCell((index + 1).toString()),
      


        ],
      );
    },
  );
}

// دالة لإنشاء خلية الجدول
pw.Widget _buildTableCell(String content) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 5),
    child: pw.Text(content, textDirection: pw.TextDirection.rtl,style: pw.TextStyle(fontSize: 8)),
  );
}

// دالة لبناء ملخص الحساب
pw.Widget _buildSummary(
  num totalremainingiqd,
  num totalcostiqd,
  num totalpayiqd,
  num totalremainingusd,
  num totalcostusd,
  num totalpayusd
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start, // Align to the left
    children: [
      // IQD Row - this row will fill the width of the page
      pw.Row(
        children: [
          _buildSummaryItem("مجموع المتبقي بالدينار", totalremainingiqd.toString(), 1),
          _buildSummaryItem("مجموع السداد بالدينار", totalcostiqd.toString(), 1),
          _buildSummaryItem("مجموع الطلب بالدينار", totalpayiqd.toString(), 1),
        ],
      ),
      
      // USD Row - this row will also fill the width of the page
      pw.Row(
        children: [
          _buildSummaryItem("مجموع المتبقي بالدولار", totalremainingusd.toString(), 1),
          _buildSummaryItem("مجموع السداد بالدولار", totalcostusd.toString(), 1),
          _buildSummaryItem("مجموع الطلب بالدولار", totalpayusd.toString(), 1),
        ],
      ),
    ],
  );
}

pw.Widget _buildSummaryItem(String title, String value, double flex) {
  return pw.Expanded(
    flex: flex.toInt(),  // Distribute width equally across the row
    child: pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 8), // Reduced padding
      child: pw.Column(
        children: [
          pw.Text(title,
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(fontSize: 10)), // Smaller text for the title
          pw.Text(value,
              style: pw.TextStyle(fontSize: 12), // Smaller text for the value
              textDirection: pw.TextDirection.rtl),
        ],
      ),
    ),
  );
}
