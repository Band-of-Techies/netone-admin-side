import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  bool _loading = true;
  Uint8List? _pdfBytes;

  Future<void> _generatePdf() async {
    final image1 = await _captureWidgetAsImage(globalKey);
    final image2 = await loadImage('assets/form2.jpg');

    final image7 = await loadImage('assets/form7.jpg');
    final sign = await loadImage('assets/sign.png');
    final pdf = pw.Document();

    final page1 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image1),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedText(
              text: 'SURNAME',
              left: 165,
              top: 248,
            ),
            CustomPositionedText(
              text: 'MIDDLE',
              left: 340,
              top: 248,
            ),
            CustomPositionedText(
              text: 'FIRST',
              left: 487,
              top: 254,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 340,
              top: 275,
            ),
            CustomPositionedText(
              text: 'NRCNO',
              left: 490,
              top: 275,
            ),
            CustomPositionedText(
              text: 'M',
              left: 163,
              top: 275,
            ),
            CustomPositionedText(
              text: 'F',
              left: 163,
              top: 285,
            ),
            CustomPositionedText(
              text: 'OFFICETELEPHONE',
              left: 163,
              top: 305,
            ),
            CustomPositionedText(
              text: 'MOBILENUMBER',
              left: 487,
              top: 303,
            ),
            CustomPositionedText(
              text: 'EMAILADDRESS',
              left: 165,
              top: 330,
            ),
            CustomPositionedText(
              text: 'DRIVERLICENSE',
              left: 165,
              top: 355,
            ),
            CustomPositionedText(
              text: 'DRIVERLICENSEEXP',
              left: 430,
              top: 355,
            ),
            CustomPositionedText(
              text: 'RESEDENTIALADDRESS',
              left: 165,
              top: 380,
            ),
            CustomPositionedText(
              text: 'O',
              left: 156,
              top: 399,
            ),
            CustomPositionedText(
              text: 'L',
              left: 218,
              top: 399,
            ),
            CustomPositionedText(
              text: 'HOWLONGTHISPLACE',
              left: 450,
              top: 400,
            ),
            CustomPositionedText(
              text: 'POSTALADDRESS',
              left: 165,
              top: 420,
            ),
            CustomPositionedText(
              text: 'TOWN',
              left: 165,
              top: 440,
            ),
            CustomPositionedText(
              text: 'PROVINCE',
              left: 430,
              top: 440,
            ),

            //second applicant
            CustomPositionedText(
              text: 'SECOND SURNAME',
              left: 165,
              top: 535,
            ),
            CustomPositionedText(
              text: 'SECOND MIDDLE',
              left: 350,
              top: 534,
            ),
            CustomPositionedText(
              text: 'SECOND FIRST',
              left: 490,
              top: 530,
            ),
            CustomPositionedText(
              text: 'SECOND DOB',
              left: 355,
              top: 560,
            ),
            CustomPositionedText(
              text: 'SECOND NRC',
              left: 495,
              top: 560,
            ),
            CustomPositionedText(
              text: 'M',
              left: 189,
              top: 560,
            ),
            CustomPositionedText(
              text: 'F',
              left: 190,
              top: 570,
            ),
            CustomPositionedText(
              text: 'SECOND TELEPHONE',
              left: 165,
              top: 590,
            ),
            CustomPositionedText(
              text: 'SECOND MOBILR',
              left: 490,
              top: 588,
            ),
            CustomPositionedText(
              text: 'SECOND EMAIL',
              left: 165,
              top: 620,
            ),
            CustomPositionedText(
              text: 'SECOND DL',
              left: 165,
              top: 645,
            ),
            CustomPositionedText(
              text: 'SECOND DLEXP',
              left: 430,
              top: 645,
            ),
            CustomPositionedText(
              text: 'SECOND RESEDENTIAL',
              left: 165,
              top: 675,
            ),
            CustomPositionedText(
              text: 'O',
              left: 181,
              top: 692,
            ),
            CustomPositionedText(
              text: 'L',
              left: 240,
              top: 691,
            ),
            CustomPositionedText(
              text: 'SECOND HOWLONG',
              left: 450,
              top: 691,
            ),
            CustomPositionedText(
              text: 'SECOND POSTAL',
              left: 165,
              top: 710,
            ),
            CustomPositionedText(
              text: 'SECOND TOWN',
              left: 165,
              top: 735,
            ),
            CustomPositionedText(
              text: 'SECOND PROVINCE',
              left: 425,
              top: 735,
            ),
          ],
        );
      },
    );

    final page2 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image2),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedText(
              text: 'THIRD SURNAME',
              left: 165,
              top: 80,
            ),
            CustomPositionedText(
              text: 'THIRD MIDDLE',
              left: 355,
              top: 78,
            ),
            CustomPositionedText(
              text: 'THIRD FIRST',
              left: 490,
              top: 78,
            ),
            CustomPositionedText(
              text: 'M',
              left: 187,
              top: 105,
            ),
            CustomPositionedText(
              text: 'F',
              left: 187,
              top: 115,
            ),
            CustomPositionedText(
              text: 'THIRD DOB',
              left: 355,
              top: 105,
            ),
            CustomPositionedText(
              text: 'THIRD NRC',
              left: 495,
              top: 105,
            ),
            CustomPositionedText(
              text: 'THIRD OFFICE TELE',
              left: 140,
              top: 135,
            ),
            CustomPositionedText(
              text: 'THIRD MOBILE',
              left: 480,
              top: 135,
            ),
            CustomPositionedText(
              text: 'THIRD EMAIL',
              left: 140,
              top: 165,
            ),
            CustomPositionedText(
              text: 'THIRD DL',
              left: 160,
              top: 190,
            ),
            CustomPositionedText(
              text: 'THIRD DLEXP',
              left: 440,
              top: 188,
            ),
            CustomPositionedText(
              text: 'THIRD RESEDENTIAL',
              left: 133,
              top: 218,
            ),

            CustomPositionedText(
              text: 'O',
              left: 181,
              top: 239,
            ),
            CustomPositionedText(
              text: 'L',
              left: 240,
              top: 239,
            ),
            CustomPositionedText(
              text: 'THIRD HOWLONG',
              left: 450,
              top: 240,
            ),
            CustomPositionedText(
              text: 'THIRD POSTAL',
              left: 130,
              top: 260,
            ),
            CustomPositionedText(
              text: 'THIRD TOWN',
              left: 130,
              top: 285,
            ),
            CustomPositionedText(
              text: 'THIRD PROVINCE',
              left: 430,
              top: 285,
            ),

            //fourth applicant
            CustomPositionedText(
              text: 'FOURTH SURNAME',
              left: 160,
              top: 370,
            ),
            CustomPositionedText(
              text: 'FOURTH MIDDLE',
              left: 355,
              top: 370,
            ),
            CustomPositionedText(
              text: 'FOURTH FIRST',
              left: 490,
              top: 370,
            ),
            CustomPositionedText(
              text: 'M',
              left: 187,
              top: 396,
            ),
            CustomPositionedText(
              text: 'F',
              left: 187,
              top: 406,
            ),
            CustomPositionedText(
              text: 'FOURTH DOB',
              left: 355,
              top: 395,
            ),
            CustomPositionedText(
              text: 'FOURTH NRC',
              left: 490,
              top: 400,
            ),
            CustomPositionedText(
              text: 'FOURTH TELEPHONE',
              left: 135,
              top: 425,
            ),
            CustomPositionedText(
              text: 'FOURTH MOBILE',
              left: 470,
              top: 425,
            ),
            CustomPositionedText(
              text: 'FOURTH EMAIL',
              left: 135,
              top: 455,
            ),
            CustomPositionedText(
              text: 'FOURTH DL',
              left: 160,
              top: 480,
            ),
            CustomPositionedText(
              text: 'FOURTH DLEXP',
              left: 445,
              top: 480,
            ),
            CustomPositionedText(
              text: 'FOURTH RESEDNETIAL',
              left: 160,
              top: 510,
            ),
            CustomPositionedText(
              text: 'O',
              left: 182,
              top: 528,
            ),
            CustomPositionedText(
              text: 'L',
              left: 240,
              top: 528,
            ),
            CustomPositionedText(
              text: 'FOURTH HOWLONG',
              left: 455,
              top: 530,
            ),
            CustomPositionedText(
              text: 'FOURTH POSTAL',
              left: 125,
              top: 550,
            ),
            CustomPositionedText(
              text: 'FOURTH TOWN',
              left: 125,
              top: 570,
            ),
            CustomPositionedText(
              text: 'FOURTH PROVINCE',
              left: 425,
              top: 572,
            ),
          ],
        );
      },
    );

    final page3 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image7),
                fit: pw.BoxFit.contain,
              ),
            ),
            pw.Positioned(
              right: 50,
              top: 500,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
              ),
            ),
          ],
        );
      },
    );

    pdf.addPage(page1);
    pdf.addPage(page2);
    pdf.addPage(page3);

    final Uint8List pdfBytes = await pdf.save();
    setState(() {
      _pdfBytes = pdfBytes;
    });
  }

  Future<Uint8List> _captureWidgetAsImage(GlobalKey key) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  void _downloadPdf() {
    html.AnchorElement(
        href:
            'data:application/octet-stream;base64,' + base64Encode(_pdfBytes!))
      ..setAttribute('download', 'generated_pdf.pdf')
      ..click();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter PDF Download'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: ListView(
            children: [
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/form1.jpg',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Image.asset(
                'assets/form2.jpg',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _generatePdf();
          _downloadPdf();
        },
        tooltip: 'Generate PDF',
        child: Icon(Icons.download),
      ),
    );
  }

  CustomPositionedText(
      {required String text, required double left, required double top}) {
    return pw.Positioned(
      left: left,
      top: top,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 6,
          color: PdfColors.black,
          fontWeight: pw.FontWeight.normal,
        ),
      ),
    );
  }
}
