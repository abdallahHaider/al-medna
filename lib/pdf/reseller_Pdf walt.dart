import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> ResellerToPdfWalt(
    List traps, String wallet_IQD, String wallet_USD) async {
  final pdf = pw.Document();

  // تحميل الخط مرة واحدة
  final fontData = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final customFont = pw.Font.ttf(fontData);
  print(traps);
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

            // الجدول الرئيسي
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableHeader(),
                ..._buildTableRows(traps),
              ],
            ),
            pw.SizedBox(height: 20),

            // ملخص الحساب
            _buildSummary(wallet_IQD, wallet_USD),
          ],
        ),
      ),
    ),
  );

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/${'ص'}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);
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
          child: pw.Text('الصندوق الرئيسي'),
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
      _buildHeaderCell("الملاحظة"),
      _buildHeaderCell("التاريخ"),
      _buildHeaderCell("رقم القيد"),
      _buildHeaderCell("المبلغ بالدولار"),
      _buildHeaderCell("المبلغ بالدينار"),
      _buildHeaderCell("الاسم"),
    ],
  );
}

// دالة لإنشاء خلية الرأس
pw.Widget _buildHeaderCell(String title) {
  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 5),
    child: pw.Text(title,
        textDirection: pw.TextDirection.rtl, style: pw.TextStyle()),
  );
}

// دالة لإنشاء الصفوف من البيانات
List<pw.TableRow> _buildTableRows(List traps) {
  return List.generate(
    traps.length,
    (index) {
      final trap = traps[index];
      print(trap.type.toString ());
      return pw.TableRow(
        children: [
          _buildTableCell(trap.note ),
        _buildTableCell(trap.createdAt.toString().substring(0,11) ),
           _buildTableCell(trap.numberKade ?? ""),
          _buildTableCell(trap.costUSD.toString()== "null" ?"":trap.costUSD.toString()),
          _buildTableCell(trap.costIQD.toString()== "null" ?"":trap.costIQD.toString()),
          _buildTableCell(trap.owner),
          // _buildTableCell(trap.type =='pay'?"سحب":"إيداع" ),
        ],
      );
    },
  );
}

// دالة لإنشاء خلية الجدول
pw.Widget _buildTableCell(String content,{pw.TextStyle ? textstyle}) {
  return pw.Padding(
    
    padding: pw.EdgeInsets.symmetric(horizontal: 5),
    child: 
    pw.SizedBox(
  child : pw.Text(content, textDirection: pw.TextDirection.rtl,style: textstyle?? pw.TextStyle (fontSize: 7)),
width: 25
)

  );
}

// دالة لبناء ملخص الحساب
pw.Widget _buildSummary(String wallet_IQD, String wallet_USD) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: [
      _buildSummaryItem("الرصيد بالدينار", wallet_IQD),
      _buildSummaryItem("مجموع الرصيد بالدولار", wallet_USD),
    ],
  );
}

// دالة لإنشاء عنصر الملخص
pw.Widget _buildSummaryItem(String title, String value) {
  return pw.Container(
    decoration: pw.BoxDecoration(border: pw.Border.all()),
    padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: pw.Column(
      children: [
        pw.Text(title, textDirection: pw.TextDirection.rtl),
        pw.Text(value,
            style: pw.TextStyle(fontSize: 20),
            textDirection: pw.TextDirection.rtl),
      ],
    ),
  );
}
