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
    final image3 = await loadImage('assets/form3.jpg');
    final image4 = await loadImage('assets/form4.jpg');
    final image5 = await loadImage('assets/form5.jpg');
    final image6 = await loadImage('assets/form6.jpg');
    final image7 = await loadImage('assets/form7.jpg');
    final image8 = await loadImage('assets/form8.jpg');
    final image9 = await loadImage('assets/form9.jpg');
    final image10 = await loadImage('assets/form10.jpg');
    final image11 = await loadImage('assets/form11.jpg');
    final image12 = await loadImage('assets/form12.jpg');
    final image13 = await loadImage('assets/form13.jpg');
    final image14 = await loadImage('assets/form14.jpg');
    final sign = await loadImage('assets/sign.png');
    final tick = await loadImage('assets/tick.png');
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
            CustomPositionedCheck(
              tick: tick,
              left: 161,
              top: 273,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 161,
              top: 283,
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
            CustomPositionedCheck(
              tick: tick,
              left: 154,
              top: 397,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 216,
              top: 397,
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
            CustomPositionedCheck(
              tick: tick,
              left: 187,
              top: 558,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 187,
              top: 568,
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
            CustomPositionedCheck(
              tick: tick,
              left: 179,
              top: 690,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 238,
              top: 690,
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
            CustomPositionedCheck(
              tick: tick,
              left: 187,
              top: 103,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 187,
              top: 113,
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

            CustomPositionedCheck(
              tick: tick,
              left: 179,
              top: 236,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 237,
              top: 236,
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
            CustomPositionedCheck(
              tick: tick,
              left: 187,
              top: 394,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 187,
              top: 404,
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
            CustomPositionedCheck(
              tick: tick,
              left: 180,
              top: 527,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 237,
              top: 527,
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
                pw.MemoryImage(image3),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedText(
              text: 'JOBTITLE',
              left: 165,
              top: 122,
            ),
            CustomPositionedText(
              text: 'MINISTRY',
              left: 165,
              top: 142,
            ),
            CustomPositionedText(
              text: 'PADDRESS',
              left: 165,
              top: 162,
            ),
            CustomPositionedText(
              text: 'POSTAL',
              left: 165,
              top: 182,
            ),
            CustomPositionedText(
              text: 'TOWN',
              left: 165,
              top: 202,
            ),
            CustomPositionedText(
              text: 'PROVINCE',
              left: 428,
              top: 202,
            ),
            CustomPositionedText(
              text: 'GROSS',
              left: 165,
              top: 222,
            ),
            CustomPositionedText(
              text: 'PROVINCE',
              left: 360,
              top: 222,
            ),
            CustomPositionedText(
              text: 'SS',
              left: 535,
              top: 220,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 165,
              top: 245,
            ),
            CustomPositionedText(
              text: 'EN123123',
              left: 360,
              top: 250,
            ),
            CustomPositionedText(
              text: '12',
              left: 558,
              top: 246,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 150,
              top: 276,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 287,
              top: 276,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 470,
              top: 275,
            ),
            //secondjob
            CustomPositionedText(
              text: 'SEOCNDJOB',
              left: 165,
              top: 325,
            ),
            CustomPositionedText(
              text: '2MINISTRY',
              left: 165,
              top: 345,
            ),
            CustomPositionedText(
              text: '2PHYADD',
              left: 165,
              top: 365,
            ),
            CustomPositionedText(
              text: '2POSTAL',
              left: 165,
              top: 385,
            ),
            CustomPositionedText(
              text: '2TOWN',
              left: 165,
              top: 405,
            ),
            CustomPositionedText(
              text: '2PROVINCE',
              left: 430,
              top: 405,
            ),
            CustomPositionedText(
              text: 'GS',
              left: 165,
              top: 425,
            ),
            CustomPositionedText(
              text: 'NS',
              left: 360,
              top: 425,
            ),
            CustomPositionedText(
              text: 'SS',
              left: 540,
              top: 422,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 165,
              top: 447,
            ),
            CustomPositionedText(
              text: '2EN',
              left: 360,
              top: 448,
            ),
            CustomPositionedText(
              text: '10',
              left: 560,
              top: 450,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 145,
              top: 480,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 281,
              top: 480,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 450,
              top: 480,
            ),
            //third applicant
            CustomPositionedText(
              text: 'THIRDJOB',
              left: 165,
              top: 520,
            ),
            CustomPositionedText(
              text: '3MIN',
              left: 165,
              top: 545,
            ),
            CustomPositionedText(
              text: '3PHY',
              left: 165,
              top: 570,
            ),
            CustomPositionedText(
              text: '3POS',
              left: 165,
              top: 590,
            ),
            CustomPositionedText(
              text: '3TOWN',
              left: 165,
              top: 610,
            ),
            CustomPositionedText(
              text: '3PROV',
              left: 420,
              top: 611,
            ),
            CustomPositionedText(
              text: '3GS',
              left: 105,
              top: 634,
            ),
            CustomPositionedText(
              text: 'CNS',
              left: 358,
              top: 632,
            ),
            CustomPositionedText(
              text: 'SS',
              left: 538,
              top: 635,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 168,
              top: 655,
            ),
            CustomPositionedText(
              text: 'EN',
              left: 360,
              top: 660,
            ),
            CustomPositionedText(
              text: 'YI',
              left: 555,
              top: 660,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 146,
              top: 688,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 286,
              top: 688,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 450,
              top: 685,
            ),
          ],
        );
      },
    );
    final page4 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image4),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedText(
              text: '4JOBTITLE',
              left: 165,
              top: 80,
            ),
            CustomPositionedText(
              text: '4MIN',
              left: 165,
              top: 105,
            ),
            CustomPositionedText(
              text: '4PHY',
              left: 165,
              top: 125,
            ),
            CustomPositionedText(
              text: '4POSTAL',
              left: 165,
              top: 147,
            ),
            CustomPositionedText(
              text: '4TOWN',
              left: 129,
              top: 165,
            ),
            CustomPositionedText(
              text: '4PROVINCE',
              left: 420,
              top: 168,
            ),
            CustomPositionedText(
              text: '4GS',
              left: 120,
              top: 187,
            ),
            CustomPositionedText(
              text: '4CNS',
              left: 360,
              top: 186,
            ),
            CustomPositionedText(
              text: 'SS',
              left: 540,
              top: 187,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 170,
              top: 210,
            ),
            CustomPositionedText(
              text: '4EN',
              left: 360,
              top: 215,
            ),
            CustomPositionedText(
              text: '12',
              left: 560,
              top: 213,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 148,
              top: 239,
            ),
            CustomPositionedCheck(
              tick: tick,
              left: 280,
              top: 240,
            ),
            CustomPositionedText(
              text: 'DD/MM/YY',
              left: 450,
              top: 240,
            ),
            //kin 1st applicant
            CustomPositionedText(
              text: 'NAME',
              left: 160,
              top: 290,
            ),
            CustomPositionedText(
              text: 'OTHER',
              left: 375,
              top: 290,
            ),
            CustomPositionedText(
              text: 'PADDRE',
              left: 160,
              top: 310,
            ),
            CustomPositionedText(
              text: 'POSTALADD',
              left: 160,
              top: 365,
            ),
            CustomPositionedText(
              text: 'CELL',
              left: 160,
              top: 400,
            ),
            CustomPositionedText(
              text: 'EMAIL',
              left: 160,
              top: 420,
            ),

            //kin second applicant
            CustomPositionedText(
              text: '2NAME',
              left: 110,
              top: 495,
            ),
            CustomPositionedText(
              text: '2OTHER',
              left: 375,
              top: 495,
            ),
            CustomPositionedText(
              text: '2PHY',
              left: 160,
              top: 520,
            ),
            CustomPositionedText(
              text: '2POSTAL',
              left: 160,
              top: 573,
            ),
            CustomPositionedText(
              text: '2CELL',
              left: 160,
              top: 610,
            ),
            CustomPositionedText(
              text: '2EMAIL',
              left: 160,
              top: 630,
            ),
          ],
        );
      },
    );

    final page5 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image5),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedText(
              text: '3NAME',
              left: 115,
              top: 70,
            ),
            CustomPositionedText(
              text: '3OTHER',
              left: 380,
              top: 70,
            ),
            CustomPositionedText(
              text: '3PHY',
              left: 160,
              top: 92,
            ),
            CustomPositionedText(
              text: '3POSTAL',
              left: 160,
              top: 145,
            ),
            CustomPositionedText(
              text: '3CELL',
              left: 160,
              top: 182,
            ),
            CustomPositionedText(
              text: '3EMAIL',
              left: 160,
              top: 205,
            ),
            //4th Kin Applicant
            CustomPositionedText(
              text: '4NAME',
              left: 115,
              top: 275,
            ),
            CustomPositionedText(
              text: '4OTHER',
              left: 370,
              top: 275,
            ),
            CustomPositionedText(
              text: '4PHY',
              left: 160,
              top: 303,
            ),
            CustomPositionedText(
              text: '4POSTAL',
              left: 160,
              top: 355,
            ),
            CustomPositionedText(
              text: '4CELL',
              left: 160,
              top: 390,
            ),
            CustomPositionedText(
              text: '4EMAIL',
              left: 160,
              top: 415,
            ),
          ],
        );
      },
    );
    final page6 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image6),
                fit: pw.BoxFit.contain,
              ),
            ),
            //motorvehicle
            CustomPositionedCheck(
              tick: tick,
              left: 165,
              top: 83,
            ),
            //agri
            CustomPositionedCheck(
              tick: tick,
              left: 310,
              top: 83,
            ),
            //furniture
            CustomPositionedCheck(
              left: 460,
              tick: tick,
              top: 83,
            ),
            //buidling
            CustomPositionedCheck(
              tick: tick,
              left: 165,
              top: 114,
            ),
            //device
            CustomPositionedCheck(
              tick: tick,
              left: 310,
              top: 114,
            ),
            CustomPositionedText(
              text: 'TOTALCOSTOFASSET',
              left: 196,
              top: 210,
            ),
            CustomPositionedText(
              text: 'TOTALINSURANCE',
              left: 196,
              top: 230,
            ),
            CustomPositionedText(
              text: 'LESSADVACNE',
              left: 196,
              top: 250,
            ),
            CustomPositionedText(
              text: 'LOANAMOUNT',
              left: 196,
              top: 270,
            ),
            CustomPositionedText(
              text: 'TENURE',
              left: 196,
              top: 292,
            ),
            CustomPositionedText(
              text: 'FIRSTAPPLICANT',
              left: 196,
              top: 350,
            ),
            CustomPositionedText(
              text: 'SECONDAPPLICANT',
              left: 490,
              top: 350,
            ),
            CustomPositionedText(
              text: 'THIRD APPLICANT',
              left: 196,
              top: 372,
            ),
            CustomPositionedText(
              text: 'FOURTH APPLICANT',
              left: 490,
              top: 372,
            ),
            CustomPositionedText(
              text: 'FIRSTPROPOTION',
              left: 197,
              top: 396,
            ),
            CustomPositionedText(
              text: 'SECONDPROPOTION',
              left: 491,
              top: 396,
            ),
            CustomPositionedText(
              text: 'THIRDPROPOTION',
              left: 198,
              top: 419,
            ),
            CustomPositionedText(
              text: 'FOURTHPROPOTION',
              left: 490,
              top: 419,
            ),

            //filldetails
            CustomPositionedText(
              text: 'FIRSTNAME',
              left: 85,
              top: 549,
            ),
            pw.Positioned(
              left: 60,
              top: 655,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 30, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'FIRSTDATE',
              left: 415,
              top: 662,
            ),
            CustomPositionedText(
              text: 'SECONDNAME',
              left: 85,
              top: 691,
            ),
          ],
        );
      },
    );

    final page7 = pw.Page(
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
              left: 60,
              top: 120,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 30, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'SECONDDATE',
              left: 420,
              top: 130,
            ),
            CustomPositionedText(
              text: 'THIRDNAME',
              left: 85,
              top: 180,
            ),
            pw.Positioned(
              left: 60,
              top: 290,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 30, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'THIRDDATE',
              left: 395,
              top: 292,
            ),
            CustomPositionedText(
              text: 'FOURTHNAME',
              left: 85,
              top: 321,
            ),
            pw.Positioned(
              left: 60,
              top: 435,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 30, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'FOURTHDATE',
              left: 420,
              top: 440,
            ),
          ],
        );
      },
    );
    final page8 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image8),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
    final page9 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image9),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
    final page10 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image10),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
    final page11 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image11),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
    final page12 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image12),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
    final page13 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image13),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
    final page14 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image14),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedText(
              text: 'FIRST NAME',
              left: 328,
              top: 221,
            ),
            pw.Positioned(
              left: 330,
              top: 260,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 70, // Adjust width as needed
                height: 40, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'FIRST DATE',
              left: 340,
              top: 307,
            ),
            CustomPositionedText(
              text: 'SECOND NAME',
              left: 328,
              top: 328,
            ),
            pw.Positioned(
              left: 330,
              top: 380,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 70, // Adjust width as needed
                height: 40, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'SECOND DATE',
              left: 340,
              top: 424,
            ),
            CustomPositionedText(
              text: 'THIRD NAME',
              left: 328,
              top: 445,
            ),
            pw.Positioned(
              left: 330,
              top: 490,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 70, // Adjust width as needed
                height: 40, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'THIRD DATE',
              left: 340,
              top: 545,
            ),
            CustomPositionedText(
              text: 'FOURTH NAME',
              left: 328,
              top: 565,
            ),
            pw.Positioned(
              left: 330,
              top: 610,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 70, // Adjust width as needed
                height: 40, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'FOURTH DATE',
              left: 340,
              top: 645,
            ),
          ],
        );
      },
    );
    pdf.addPage(page1);
    pdf.addPage(page2);
    pdf.addPage(page3);
    pdf.addPage(page4);
    pdf.addPage(page5);
    pdf.addPage(page6);
    pdf.addPage(page7);
    pdf.addPage(page8);
    pdf.addPage(page9);
    pdf.addPage(page10);
    pdf.addPage(page11);
    pdf.addPage(page12);
    pdf.addPage(page13);
    pdf.addPage(page14);

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

  pw.Widget CustomPositionedCheck(
      {required double left, required double top, required Uint8List? tick}) {
    return pw.Positioned(
      left: left,
      top: top,
      child: pw.Image(
        pw.MemoryImage(tick!), // Assuming image7 is the image you want to place
        width: 10, // Adjust width as needed
        height: 10, // Adjust height as needed
      ),
    );
  }
}
