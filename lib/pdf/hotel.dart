import 'dart:io';
import 'dart:typed_data';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

Future<void> createHotelPDF({
  // required String hotelName,
  required String startDate,
  required String endDate,
  required String seller,
  required String buyer,
  required int roomCount,
  required double pricePerRoom,
  required int days,
  // required String Time,
}) async {
  final fonddata = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  final costmfond = pw.Font.ttf(fonddata);

  // تحميل صورة من assets
  final ByteData imageData = await rootBundle.load('assets/images/forma.png');
  final Uint8List imageBytes = imageData.buffer.asUint8List();

  final image = pw.MemoryImage(imageBytes);
  // حساب السعر الكلي
  final totalPrice = roomCount * pricePerRoom;

  // إنشاء مستند PDF
  final pdf = pw.Document();

  // إضافة صفحة إلى مستند PDF
  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 5,
          marginRight: 5,
          marginTop: 5,
          marginBottom: 5,
        ),
        theme: pw.ThemeData.withFont(base: costmfond),
        textDirection: pw.TextDirection.rtl,
      ),
      build: (pw.Context context) {
        return pw.Stack(children: [
          pw.Image(
            image,
          ),
          pw.Positioned(
              top: 120,
              left: 10,
              right: 10,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 20),
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('عقد شراء غرف',
                            style: pw.TextStyle(fontSize: 24),
                            textDirection: pw.TextDirection.rtl,
                            textAlign: pw.TextAlign.center),
                      ]),
                  // عنوان العقد

                  // مقدمة العقد
                  pw.Text(
                      'الطرف الأول السيد محمد حسن سليم مستأجر الفندق (${seller}) لموسم رمضان 2046 حسب العقود المبرمة مع أصحاب الفنادق .',
                      style: pw.TextStyle(fontSize: 17),
                      textDirection: pw.TextDirection.rtl),

                  pw.Text(
                      'الطرف الثاني السيد (${buyer}) حيث أبدى الطرف الثاني باستئجار غرف من الطرف الأول للفندق (${seller}) 	وتكون عدد الغرف (${roomCount})   سعر الغرف  (${pricePerRoom})  المجموع (${pricePerRoom * totalPrice * days})   وتكون الفترة من (${startDate}) ولي غايت (${endDate.toString().substring(0, 10)}) يوم ',
                      style: pw.TextStyle(fontSize: 17),
                      textDirection: pw.TextDirection.rtl),

                  // بند التفاصيل العامة
                  pw.Text(
                      '1.  يلتزم  الطرف الأول بتامين جميع الخدمات المنصوص عليا في تعليمات وزارت الحج وضوابط اسكان المعتمرين وتنفيذ لوائح وزارة الحج والعمرة في المملكة العربية السعودية ',
                      style: pw.TextStyle(fontSize: 17),
                      textDirection: pw.TextDirection.rtl),
                  // pw.Text(
                  //   'تاريخ العقد: من $startDate إلى $endDate',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),
                  // pw.Text(
                  //   'الطرف الأول (البائع): $seller',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),
                  // pw.Text(
                  //   'الطرف الثاني (المشتري): $buyer',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),

                  // بند تفاصيل الغرف والأسعار
                  pw.Text(
                      '2. يلتزم الطرف الثاني بالمحافظة على أثاث الفندق ويتحمل أي ضرر أو تلف أثاث الغرفة',
                      style: pw.TextStyle(
                        fontSize: 17,
                      ),
                      textDirection: pw.TextDirection.rtl),
                  // pw.Text(
                  //   'عدد الغرف المشمولة: $roomCount غرفة',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),
                  // pw.Text(
                  //   'سعر الغرفة الواحدة: ${pricePerRoom.toStringAsFixed(2)} دينار',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),
                  // pw.Text(
                  //   'السعر الكلي: ${totalPrice.toStringAsFixed(2)} دينار',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),

                  // بند التزامات الطرفين
                  pw.Text(
                      '3.على الطرف الثاني تسديد المبلغ المتفق عليه قبل دخول المعتمرين .',
                      style: pw.TextStyle(fontSize: 17),
                      textDirection: pw.TextDirection.rtl),
                  // pw.Text(
                  //   'يلتزم الطرف الأول بتوفير الغرف المتفق عليها وتسليمها للطرف الثاني في التاريخ المحدد.',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),
                  // pw.Text(
                  //   'يلتزم الطرف الثاني بدفع المبلغ المتفق عليه في موعده المحدد.',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),

                  // بند إنهاء العقد
                  pw.Text(
                      '4. يحق للطرف الاول فسخ العقد في حال عدم سداد الدفعات .',
                      style: pw.TextStyle(fontSize: 17),
                      textDirection: pw.TextDirection.rtl),
                  // pw.Text(
                  //   'يحق للطرفين إنهاء العقد باتفاق مشترك.',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),
                  // pw.Text(
                  //   'يلتزم الطرف الذي يقرر إنهاء العقد بإخطار الطرف الآخر قبل فترة لا تقل عن 15 يوماً.',
                  //   style: pw.TextStyle(fontSize: 12),
                  //   textDirection: pw.TextDirection.rtl,
                  // ),

                  // بند شروط عامة
                  pw.Text('5. شروط عامة:',
                      style: pw.TextStyle(
                        fontSize: 20,
                      ),
                      textDirection: pw.TextDirection.rtl),
                  pw.Text(
                    'يعتبر هذا العقد ساري المفعول بمجرد توقيعه من قبل الطرفين.',
                    style: pw.TextStyle(fontSize: 16),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'جميع الشروط والبنود في هذا العقد ملزمة للطرفين.',
                    style: pw.TextStyle(fontSize: 16),
                    textDirection: pw.TextDirection.rtl,
                  ),

                  pw.SizedBox(height: 20),
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        // التوقيعات
                        pw.Text('توقيع الطرف الأول (البائع):',
                            style: pw.TextStyle(fontSize: 16),
                            textDirection: pw.TextDirection.rtl),

                        pw.Text('توقيع الطرف الثاني (المشتري):',
                            style: pw.TextStyle(fontSize: 16),
                            textDirection: pw.TextDirection.rtl),
                      ]),
                ],
              ))
        ]);
      },
    ),
  );

  // // تحديد المسار وحفظ ملف PDF
  // final output = await getTemporaryDirectory();
  // final file = File("${output.path}/FormalContract.pdf");
  // await file.writeAsBytes(await pdf.save());

  // print('تم إنشاء ملف العقد الرسمي بنجاح في ${file.path}');

  // حفظ ملف PDF في جهازك
  final output = await getTemporaryDirectory();
  final file =
      File("${output.path}/${seller + DateTime.now().second.toString()}.pdf");
  await file.writeAsBytes(await pdf.save());

  print("PDF تم إنشاؤه وحفظه بنجاح في ${file.path}");

  // فتح ملف PDF باستخدام تطبيق خارجي
  await OpenFilex.open(file.path);

//   // حفظ ملف PDF على الويب
//   final bytes = await pdf.save();
//   final blob = Blob([bytes], 'application/pdf');
//   final url = Url.createObjectUrlFromBlob(blob);
//   final anchor = AnchorElement(href: url)
//     ..setAttribute("download", "example.pdf")
//     ..click();
//   Url.revokeObjectUrl(url);
}
