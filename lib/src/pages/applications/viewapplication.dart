// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/constants/colors.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/dashboard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/timeline.dart';
import 'dart:js' as js;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ViewApplication extends StatefulWidget {
  final int loanRequestId;

  const ViewApplication({required this.loanRequestId});

  @override
  State<ViewApplication> createState() => _ViewApplicationState();
}

class _ViewApplicationState extends State<ViewApplication> {
  late LoanRequestDetails loanDetail;
  List<String> currentstatusList = ['Approve', 'Reject'];
  String? currentstatus;
  GlobalKey globalKey = GlobalKey();
  Uint8List? _pdfBytes;
  List<Uint8List> selectedFiles = [];
  List<String> selectedFilesnames = [];
  bool isloadiing = true;
  String? email;
  String? token;
  String? role;
  @override
  Widget build(BuildContext context) {
    return isloadiing == false
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainbackground,
              centerTitle: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: AppColors.neutral,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
              ),
              title: Text(
                loanDetail.requestnumber,
                style:
                    GoogleFonts.dmSans(fontSize: 14, color: AppColors.neutral),
              ),
              actions: [
                Row(
                  children: [
                    /*  SizedBox(
                      height: 40,
                      width: 350,
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          focusColor: AppColors.neutral,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.neutral, width: .5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.neutral, width: .5)),
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.neutral),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // Add more decoration..
                        ),
                        hint: Text(
                          'Choose Status',
                          style: GoogleFonts.dmSans(
                              fontSize: 14, color: AppColors.neutral),
                        ),
                        items: currentstatusList
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: CustomText(
                                    fontSize: 14,
                                    color: AppColors.neutral,
                                    text: item,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          //Do something when selected item is changed.
                        },
                        onSaved: (value) {
                          selectedstatus = value.toString();
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.neutral,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: AppColors.sidebarbackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.mainColor),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
                        onPressed: () {},
                        child: CustomText(
                          text: 'Update',
                          color: AppColors.neutral,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),*/
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: CustomText(
                                text: 'Print PDF',
                                color: primary,
                              ),
                              content: Container(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Container(
                                          constraints:
                                              BoxConstraints(maxHeight: 200),
                                          child: Center(
                                            child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child:
                                                    CircularProgressIndicator()),
                                          ),
                                        ),
                                      ),
                                    );

                                    await _generatePdf();
                                    _downloadPdf();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Print'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.print,
                          size: 20,
                          color: AppColors.neutral,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          _addFiles(context);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 20,
                          color: AppColors.neutral,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          _showPopup(context);
                        },
                        icon: Icon(
                          Icons.track_changes,
                          size: 20,
                          color: AppColors.neutral,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    if (loanDetail.requestSystemStatus == 'pending')
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditApplication(
                                        requestid: widget.loanRequestId,
                                      )),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: AppColors.neutral,
                          )),
                    SizedBox(
                      width: 10,
                    ),
                    if (role == 'Admin' && role != 'Agent')
                      IconButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(context);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: AppColors.neutral,
                          )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
            backgroundColor: AppColors.mainbackground,
            body: Padding(
              padding: EdgeInsets.all(20),
              child: RawScrollbar(
                thumbVisibility: true,
                thumbColor: AppColors.mainColor,
                radius: Radius.circular(20),
                thickness: 5,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Form ID: ${loanDetail.id}',
                                color: AppColors.neutral,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text: 'Assigned to: ${loanDetail.agent.name}',
                                color: AppColors.neutral,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text:
                                    'Applicant: ${loanDetail.applicants[0].surname}',
                                color: AppColors.neutral,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text:
                                    'Joint Application: ${loanDetail.applicantCount > 1 ? 'Yes : ${loanDetail.applicantCount}' : 'No'}',
                                color: AppColors.neutral,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text:
                                    'Date: ${formatDate(loanDetail.createdAt)}',
                                color: AppColors.neutral,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomText(
                                text:
                                    'Last Updated: ${formatDate(loanDetail.updatedAt)}',
                                color: AppColors.neutral,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      text: 'Part 1',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: 'Applicant Details',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < loanDetail.applicants.length; i++)
                      applicantDetails(i, i),

                    // Display other details as needed

                    // Display details from Section Two
                    CustomText(
                      text: 'Part 2',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: 'Employment Details',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < loanDetail.applicants.length; i++)
                      employmentDetals(i, i),
                    for (int i = 0; i < loanDetail.applicants.length; i++)
                      employmentKinDetals(i, i),
                    CustomText(
                      text: 'Part 3',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: 'Loan Details',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    loanDetails(),
                    SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      text: 'Bank Details',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    bankdetails(),
                    SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < loanDetail.applicants.length; i++)
                      applicantDocuments(i, i),
                    if (loanDetail.documents.isNotEmpty) additonalDocumnets(),
                    if (loanDetail.orderdocuments.isNotEmpty) orderDocumnets()
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.mainbackground,
            body: Center(
                child: CircularProgressIndicator(
              color: AppColors.mainColor,
            )),
          );
  }

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
    final image15 = await loadImage('assets/form15.jpg');
    final image16 = await loadImage('assets/quote.jpg');
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
              top: 635,
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
              top: 100,
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
              top: 270,
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
              top: 420,
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
              top: 255,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 20, // Adjust height as needed
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
              top: 370,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 20, // Adjust height as needed
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
              top: 480,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 20, // Adjust height as needed
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
              top: 600,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 20, // Adjust height as needed
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
    final page15 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image15),
                fit: pw.BoxFit.contain,
              ),
            ),
            //payers details
            CustomPositionedText(
              text: 'CUSTOMER NAME',
              left: 100,
              top: 345,
            ),
            CustomPositionedText(
              text:
                  '2         6         0         1         2         3         4         5         6         7         8         9',
              left: 100,
              top: 370,
            ),
            CustomPositionedText(
              text: 'EMAIL',
              left: 340,
              top: 370,
            ),
            CustomPositionedText(
              text: 'ADDRESS',
              left: 100,
              top: 398,
            ),
            //payersbankdetails
            CustomPositionedText(
              text: 'BANKNAME',
              left: 100,
              top: 434,
            ),
            CustomPositionedText(
              text: 'BRANCHNAME',
              left: 100,
              top: 464,
            ),
            CustomPositionedText(
              text: '1         2         3         4         5         6',
              left: 285,
              top: 464,
            ),
            CustomPositionedText(
              text:
                  '2         6         0         1         2         3         4         5         6         7         8         9',
              left: 100,
              top: 494,
            ),
            CustomPositionedText(
              text: 'NAME AND FULL POSTALL ADDRESS',
              left: 100,
              top: 550,
            ),
            pw.Positioned(
              left: 100,
              top: 640,
              child: pw.Image(
                pw.MemoryImage(
                    sign), // Assuming image7 is the image you want to place
                width: 50, // Adjust width as needed
                height: 30, // Adjust height as needed
              ),
            ),
            CustomPositionedText(
              text: 'DATE',
              left: 250,
              top: 660,
            ),
          ],
        );
      },
    );
    final page16 = pw.Page(
      margin: pw.EdgeInsets.zero, // Remove default margins
      build: (context) {
        return pw.Stack(
          children: [
            pw.Center(
              child: pw.Image(
                pw.MemoryImage(image16),
                fit: pw.BoxFit.contain,
              ),
            ),
            CustomPositionedTextNOBold(
              text: '21/03/2024',
              left: 500,
              top: 146,
            ),
            CustomPositionedTextNOBold(
              text: 'NB 1234',
              left: 500,
              top: 161,
            ),
            CustomPositionedTextBold(
              text: 'CUSTOMER NAME',
              left: 85,
              top: 203,
            ),
            CustomPositionedTextNOBold(
              text: 'AGENT Name',
              left: 26,
              top: 386,
            ),
            CustomPositionedTextBold(
              text: 'Payment Terms ',
              left: 20,
              top: 680,
            ),
            CustomPositionedTextBold(
              text: 'LOAN APPROVAL THROUGH PSMFC',
              left: 110,
              top: 680,
            ),
            CustomPositionedTextBold(
              text: 'Delivery of Device',
              left: 20,
              top: 695,
            ),
            CustomPositionedTextBold(
              text: 'EX STOCK',
              left: 110,
              top: 695,
            ),
            CustomPositionedTextBold(
              text: 'Quote Validity',
              left: 20,
              top: 710,
            ),
            CustomPositionedTextBold(
              text: '21 days',
              left: 110,
              top: 710,
            ),
            CustomPositionedTextBold(
              text: 'THANK YOU FOR YOUR BUSINESS!',
              left: 220,
              top: 730,
            ),
            CustomPositionedTextBold(
              text: 'Website',
              left: 20,
              top: 750,
            ),
            CustomPositionedTextNOBold(
              text: 'www.digitize.co.zm',
              left: 90,
              top: 750,
            ),
            CustomPositionedTextBold(
              text: 'Whatsapp',
              left: 20,
              top: 765,
            ),
            CustomPositionedTextNOBold(
              text: '962148178',
              left: 90,
              top: 765,
            ),
            CustomPositionedTextBold(
              text: 'Phone',
              left: 20,
              top: 780,
            ),
            CustomPositionedTextNOBold(
              text: '0211 372 600',
              left: 90,
              top: 780,
            ),

            //calculationssubtotal
            CustomPositionedTextNOBold(
              text: 'SUBTOTAL',
              left: 420,
              top: 660,
            ),
            CustomPositionedTextNOBold(
              text: '10,343.97',
              left: 515,
              top: 660,
            ),
            //taxrate
            CustomPositionedTextNOBold(
              text: 'TAXRATE',
              left: 420,
              top: 680,
            ),
            CustomPositionedTextNOBold(
              text: '0.16',
              left: 515,
              top: 680,
            ),
            //vat
            CustomPositionedTextNOBold(
              text: 'VAT',
              left: 420,
              top: 695,
            ),
            CustomPositionedTextNOBold(
              text: '10,343.97',
              left: 515,
              top: 695,
            ),
            //totalprice
            CustomPositionedTextBold(
              text: 'TOTAL PRICE',
              left: 420,
              top: 710,
            ),
            CustomPositionedTextNOBold(
              text: '10,343.97',
              left: 515,
              top: 710,
            ),
            pw.Positioned(
              left: 16,
              top: 444,
              child: pw.Container(
                  width: 565,
                  height: 60,
                  child: pw.Row(children: [
                    pw.Container(
                        width: 89,
                        height: 60,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black, // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child: pw.Center(child: customText(text: '1'))),
                    pw.Container(
                        width: 288,
                        height: 60,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black, // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child: pw.Center(
                            child: customText(
                                text:
                                    '''Neo Pro15 Intel i5-1035G7-10th GEN/8GB DDR4/512GB
SSD / 1.0MP CAMERA / Black / 15.6 inch FHD IPS 1920*1080 /
Type C port / USB 3.2 GEN*2 / AC WIFI / 4500mAH Smart battery
/ Speaker 8 1W / Standard HDMI / MIC / Earphone Jack / 1.6kg
/ Windows 11 PRO/Laptop Bag'''))),
                    pw.Container(
                        width: 100,
                        height: 60,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black, // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child:
                            pw.Center(child: customText(text: '10343.96552'))),
                    pw.Container(
                        width: 87,
                        height: 60,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black, // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child:
                            pw.Center(child: customText(text: '10343.96552')))
                  ])),
            ),
            for (int i = 0; i < 3; i++)
              productContainer(
                  price: 10343.96552,
                  toppostion: 444 + (i * 60),
                  quantity: 1,
                  description:
                      '''Neo Pro15 Intel i5-1035G7-10th GEN/8GB DDR4/512GB
SSD / 1.0MP CAMERA / Black / 15.6 inch FHD IPS 1920*1080 /
Type C port / USB 3.2 GEN*2 / AC WIFI / 4500mAH Smart battery
/ Speaker 8 1W / Standard HDMI / MIC / Earphone Jack / 1.6kg
/ Windows 11 PRO/Laptop Ba''')
          ],
        );
      },
    );
    List<dynamic> pages = [];
    for (int j = 0; j < loanDetail.applicantCount; j++) {
      for (int i = 0; i < loanDetail.applicants[0].documents!.length; i++) {
        if (!loanDetail.applicants[0].documents[i].contentType
            .contains('pdf')) {
          final Uint8List imageBytes = await fetchAndConvertImage(
              loanDetail.applicants[j].documents.first.url);
          pages.add(pw.Page(
            margin: pw.EdgeInsets.zero, // Remove default margins
            build: (context) {
              return pw.Stack(
                children: [
                  pw.Center(
                    child: pw.Image(
                      pw.MemoryImage(imageBytes),
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                ],
              );
            },
          ));
        }
      }
    }

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
    pdf.addPage(page15);
    pdf.addPage(page16);
    for (int i = 0; i < pages.length; i++) {
      pdf.addPage(pages[i]);
    }
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

  Future<Uint8List> fetchAndConvertImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image: $imageUrl');
    }
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

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.sidebarbackground,
          title: CustomText(
            text: 'Confirm Deletion',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.mainColor,
          ),
          content: CustomText(
            text: 'Are you sure you want to delete this item?',
            color: AppColors.neutral,
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomText(
                text: 'Cancel',
                color: AppColors.neutral,
              ),
            ),
            // Confirm Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Call deleteData when confirmed
                deleteData(widget.loanRequestId);
              },
              child: CustomText(
                text: 'Confirm',
                color: AppColors.neutral,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteData(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    final String apiUrl =
        'https://loan-managment.onrender.com/loan_requests/$id';
    final String accessToken = token!;

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Request was successful
        print('DELETE request for ID $id successful');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        // Request failed
        print(
            'DELETE request for ID $id failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error for ID $id: $e');
    }
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

  customText({required String text}) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 8,
        color: PdfColors.black,
        fontWeight: pw.FontWeight.normal,
      ),
    );
  }

  productContainer(
      {required double toppostion,
      required int quantity,
      description,
      required double price}) {
    return pw.Positioned(
      left: 16,
      top: toppostion,
      child: pw.Container(
          width: 565,
          height: 60,
          child: pw.Row(children: [
            pw.Container(
                width: 89,
                height: 60,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: pw.Center(child: customText(text: quantity.toString()))),
            pw.Container(
                width: 288,
                height: 60,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: pw.Center(child: customText(text: description))),
            pw.Container(
                width: 100,
                height: 60,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: pw.Center(child: customText(text: price.toString()))),
            pw.Container(
                width: 87,
                height: 60,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: pw.Center(
                    child: customText(text: (price * quantity).toString())))
          ])),
    );
  }

  CustomPositionedTextBold(
      {required String text, required double left, required double top}) {
    return pw.Positioned(
      left: left,
      top: top,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
          color: PdfColors.black,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  CustomPositionedTextNOBold(
      {required String text, required double left, required double top}) {
    return pw.Positioned(
      left: left,
      top: top,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
    return formattedDate;
  }

  Container applicantDocuments(int applicantkey, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Applicant ${i + 1}',
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: List.generate(
              loanDetail.applicants[applicantkey].documents.length,
              (index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display Image for image files
                      isImage(loanDetail.applicants[applicantkey]
                              .documents[index].contentType)
                          ? GestureDetector(
                              onTap: () {
                                String imageUrl = loanDetail
                                    .applicants[applicantkey]
                                    .documents[index]
                                    .url;
                                js.context.callMethod('open', [imageUrl]);
                              },
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainbackground),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.neutral,
                                ),
                                child: Image.network(
                                  loanDetail.applicants[applicantkey]
                                      .documents[index].url,
                                  width:
                                      300, // Set the width of the image as per your requirement
                                  height:
                                      50, // Set the height of the image as per your requirement
                                  fit: BoxFit
                                      .cover, // Adjust this based on your image requirements
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.neutral),
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.neutral,
                                      ),
                                      child: Center(
                                        child: Text('Image Not Found'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : loanDetail.applicants[applicantkey].documents[index]
                                  .contentType
                                  .contains('pdf')
                              ? GestureDetector(
                                  onTap: () {
                                    String pdfUrl = loanDetail
                                        .applicants[applicantkey]
                                        .documents[index]
                                        .url;
                                    js.context.callMethod('open', [pdfUrl]);
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.neutral),
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.neutral,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.neutral),
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.neutral,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.enhanced_encryption,
                                        color: Colors.red,
                                      ),
                                      CustomText(text: 'Unreadable Format')
                                    ],
                                  ),
                                ),

                      SizedBox(
                          height: 8.0), // Add spacing between image and text

                      // Display file name with overflow handling
                      Flexible(
                        child: Text(
                          'Document  ${index + 1}',

                          // Adjust the maximum lines based on your UI requirements
                          style: GoogleFonts.dmSans(
                            color: AppColors.neutral,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (loanDetail.applicants[applicantkey].documents.length > 0)
            loadDocFiles(applicantkey, 'Payslip 1',
                loanDetail.applicants[applicantkey].documents),
          SizedBox(
            height: 20,
          ),
          if (loanDetail.applicants[applicantkey].documents.length > 0)
            loadDocFiles(applicantkey, 'Payslip 2',
                loanDetail.applicants[applicantkey].documents),
          if (loanDetail.applicants[applicantkey].documents.length > 0)
            loadDocFiles(applicantkey, 'Payslip 3',
                loanDetail.applicants[applicantkey].documents),
          if (loanDetail.applicants[applicantkey].documents.length > 0)
            loadDocFiles(applicantkey, 'Introductory Letter',
                loanDetail.applicants[applicantkey].documents),
          if (loanDetail.applicants[applicantkey].documents.length > 0)
            loadDocFiles(applicantkey, 'Bank Statement',
                loanDetail.applicants[applicantkey].documents),
          if (loanDetail.applicants[applicantkey].documents.length > 0)
            loadDocFiles(applicantkey, 'NRC',
                loanDetail.applicants[applicantkey].documents),
        ],
      ),
    );
  }

  Row loadDocFiles(
      int applicantkey, String text, List<Document> documentstoload) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(text: '$text: '),
        Wrap(
          children: List.generate(
            documentstoload.length,
            (index) {
              return Container(
                margin: EdgeInsets.all(10),
                width: 300,
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Image for image files
                    isImage(documentstoload[index].contentType)
                        ? GestureDetector(
                            onTap: () {
                              String imageUrl = documentstoload[index].url;
                              js.context.callMethod('open', [imageUrl]);
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.mainbackground),
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.neutral,
                              ),
                              child: Image.network(
                                documentstoload[index].url,
                                width:
                                    300, // Set the width of the image as per your requirement
                                height:
                                    50, // Set the height of the image as per your requirement
                                fit: BoxFit
                                    .cover, // Adjust this based on your image requirements
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.neutral),
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.neutral,
                                    ),
                                    child: Center(
                                      child: Text('Image Not Found'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : documentstoload[index].contentType.contains('pdf')
                            ? GestureDetector(
                                onTap: () {
                                  String pdfUrl = documentstoload[index].url;
                                  js.context.callMethod('open', [pdfUrl]);
                                },
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.neutral),
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.neutral,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.neutral),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.neutral,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.enhanced_encryption,
                                      color: Colors.red,
                                    ),
                                    CustomText(text: 'Unreadable Format')
                                  ],
                                ),
                              ),

                    SizedBox(height: 8.0), // Add spacing between image and text

                    // Display file name with overflow handling
                    Flexible(
                      child: Text(
                        'Document  ${index + 1}',

                        // Adjust the maximum lines based on your UI requirements
                        style: GoogleFonts.dmSans(
                          color: AppColors.neutral,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container additonalDocumnets() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Additional Files',
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: List.generate(
              loanDetail.documents.length,
              (index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display Image for image files
                      isImage(loanDetail.documents[index].contentType)
                          ? GestureDetector(
                              onTap: () {
                                String imageUrl =
                                    loanDetail.documents[index].url;
                                js.context.callMethod('open', [imageUrl]);
                              },
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainbackground),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.neutral,
                                ),
                                child: Image.network(
                                  loanDetail.documents[index].url,
                                  width:
                                      300, // Set the width of the image as per your requirement
                                  height:
                                      50, // Set the height of the image as per your requirement
                                  fit: BoxFit
                                      .cover, // Adjust this based on your image requirements
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.neutral),
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.neutral,
                                      ),
                                      child: Center(
                                        child: Text('Image Not Found'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : loanDetail.documents[index].contentType
                                  .contains('pdf')
                              ? GestureDetector(
                                  onTap: () {
                                    String pdfUrl =
                                        loanDetail.documents[index].url;
                                    js.context.callMethod('open', [pdfUrl]);
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.neutral),
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.neutral,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.neutral),
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.neutral,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.enhanced_encryption,
                                        color: Colors.red,
                                      ),
                                      CustomText(text: 'Unreadable Format')
                                    ],
                                  ),
                                ),

                      SizedBox(
                          height: 8.0), // Add spacing between image and text

                      // Display file name with overflow handling
                      Flexible(
                        child: Text(
                          'Document  ${index + 1}',

                          // Adjust the maximum lines based on your UI requirements
                          style: GoogleFonts.dmSans(
                            color: AppColors.neutral,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container orderDocumnets() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Order Documents',
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: List.generate(
              loanDetail.orderdocuments.length,
              (index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display Image for image files
                      isImage(loanDetail.orderdocuments[index].contentType)
                          ? GestureDetector(
                              onTap: () {
                                String imageUrl =
                                    loanDetail.orderdocuments[index].url;
                                js.context.callMethod('open', [imageUrl]);
                              },
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainbackground),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.neutral,
                                ),
                                child: Image.network(
                                  loanDetail.orderdocuments[index].url,
                                  width:
                                      300, // Set the width of the image as per your requirement
                                  height:
                                      50, // Set the height of the image as per your requirement
                                  fit: BoxFit
                                      .cover, // Adjust this based on your image requirements
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.neutral),
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.neutral,
                                      ),
                                      child: Center(
                                        child: Text('Image Not Found'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : loanDetail.orderdocuments[index].contentType
                                  .contains('pdf')
                              ? GestureDetector(
                                  onTap: () {
                                    String pdfUrl =
                                        loanDetail.orderdocuments[index].url;
                                    js.context.callMethod('open', [pdfUrl]);
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.neutral),
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.neutral,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.neutral),
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.neutral,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.enhanced_encryption,
                                        color: Colors.red,
                                      ),
                                      CustomText(text: 'Unreadable Format')
                                    ],
                                  ),
                                ),

                      SizedBox(
                          height: 8.0), // Add spacing between image and text

                      // Display file name with overflow handling
                      Flexible(
                        child: Text(
                          'Document  ${index + 1}',

                          // Adjust the maximum lines based on your UI requirements
                          style: GoogleFonts.dmSans(
                            color: AppColors.neutral,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container applicantDetails(int applicantkey, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Applicant ${i + 1}',
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              if (loanDetail.applicants[applicantkey].exisitngstatus == 'new')
                CustomText(
                  text: 'New Customer',
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              if (loanDetail.applicants[applicantkey].exisitngstatus ==
                  'existing')
                CustomText(
                  text: 'Other requests that are not rejected',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.orange,
                ),
              if (loanDetail.applicants[applicantkey].exisitngstatus ==
                  'rejected')
                CustomText(
                  text: 'Has requests that are rejected',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.red,
                ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text: 'Surname: ${loanDetail.applicants[applicantkey].surname}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Middle Name: ${loanDetail.applicants[applicantkey].middleName}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'First Name: First Name ${loanDetail.applicants[applicantkey].firstName}',
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text: 'Gender: ${loanDetail.applicants[applicantkey].gender}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Date of Birth: ${loanDetail.applicants[applicantkey].dob}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'NRC Number: ${loanDetail.applicants[applicantkey].nrc}',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text:
                    'Telephone: ${loanDetail.applicants[applicantkey].telephone}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Mobile: ${loanDetail.applicants[applicantkey].mobile}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Email: ${loanDetail.applicants[applicantkey].email}',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text:
                    'Driving Licnese Number: ${loanDetail.applicants[applicantkey].licenseNumber}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Licnese Exp Date: ${loanDetail.applicants[applicantkey].licenseExpiry}',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text:
                    'Resedential Address: ${loanDetail.applicants[applicantkey].residentialAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Ownership:  ${loanDetail.applicants[applicantkey].residentialAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'How long this place:  ${loanDetail.applicants[applicantkey].residentialAddress}',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text:
                    'Postal Address:  ${loanDetail.applicants[applicantkey].postalAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Town:  ${loanDetail.applicants[applicantkey].town}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Province:  ${loanDetail.applicants[applicantkey].province}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool isImage(String contentType) {
    return contentType.contains('jpeg') ||
        contentType.contains('jpg') ||
        contentType.contains('webp') ||
        contentType.contains('png');
  }

  Container employmentDetals(int applicantkey, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              fontSize: 15,
              text: 'Employment Details Applicant: ${i + 1}',
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Job Title: ${loanDetail.applicants[applicantkey].occupation.jobTitle}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Ministry: ${loanDetail.applicants[applicantkey].occupation.ministry}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Physical Address: ${loanDetail.applicants[applicantkey].occupation.physicalAddress}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Postal Address: ${loanDetail.applicants[applicantkey].occupation.postalAddress}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Town: ${loanDetail.applicants[applicantkey].occupation.town}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Province: ${loanDetail.applicants[applicantkey].occupation.province}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Gross Salary: ${loanDetail.applicants[applicantkey].occupation.grossSalary}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Current Net Salary: ${loanDetail.applicants[applicantkey].occupation.netSalary}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Salary Scale: ${loanDetail.applicants[applicantkey].occupation.salaryScale}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Preferred Year of Retirement: ${loanDetail.applicants[applicantkey].occupation.preferredRetirementYear}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Employee Number: ${loanDetail.applicants[applicantkey].occupation.employerNumber}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Years in Employemnt: ${loanDetail.applicants[applicantkey].occupation.yearsOfService}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Employemnt Type: ${loanDetail.applicants[applicantkey].occupation.employmentType}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Expiry Date: ${loanDetail.applicants[applicantkey].occupation.tempExpiryDate}',
                ),
              ],
            ),
          ]),
    );
  }

  Container employmentKinDetals(int applicantkey, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              fontSize: 15,
              text: 'Kin Details Applicant: ${i + 1}',
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text: 'Name: ${loanDetail.applicants[applicantkey].kin.name}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Other Name: ${loanDetail.applicants[applicantkey].kin.otherNames}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Physical Address: ${loanDetail.applicants[applicantkey].kin.physicalAddress}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Postal Address: ${loanDetail.applicants[applicantkey].kin.postalAddress}',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text:
                      'Phone: ${loanDetail.applicants[applicantkey].kin.phoneNumber}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Email: ${loanDetail.applicants[applicantkey].kin.email}',
                ),
              ],
            ),
          ]),
    );
  }

  String formatDateString(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      // Handle parsing errors, e.g., if the input string is not a valid date
      print('Error formatting date: $e');
      return 'Invalid Date';
    }
  }

  Container loanDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            fontSize: 15,
            text: 'Loan Product Applied',
          ),
          SizedBox(
            height: 40,
          ),
          for (int i = 0; i < loanDetail.requestedProducts.length; i++)
            CustomText(
              fontSize: 15,
              text:
                  '${loanDetail.requestedProducts[i].productName}(${loanDetail.requestedProducts[i].quantity})',
            ),
          SizedBox(
            height: 40,
          ),
          CustomText(
            fontSize: 15,
            text: 'Description: ${loanDetail.description}',
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text: 'Total cost of asset: ${loanDetail.costOfAsset}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Total Insurance Cost: ${loanDetail.insuranceCost}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Less Advance Payment: ${loanDetail.advancePayment}',
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text: 'Loan Amount Applied for: ${loanDetail.loanAmount}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Tenure: ${loanDetail.loanTenure}',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text:
                    'First Applicant: ${loanDetail.applicants[0].loansharename}',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'First Applicant Loan Propotion: ${loanDetail.applicants[0].loansharepercent}',
              ),
              SizedBox(
                width: 30,
              ),
              if (loanDetail.applicantCount > 1)
                CustomText(
                  fontSize: 15,
                  text:
                      'Second Applicant: ${loanDetail.applicants[1].loansharename}',
                ),
              SizedBox(
                width: 30,
              ),
              if (loanDetail.applicantCount > 1)
                CustomText(
                  fontSize: 15,
                  text:
                      'Second Applicant Loan Propotion: ${loanDetail.applicants[1].loansharepercent}',
                ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              if (loanDetail.applicantCount > 2)
                CustomText(
                  fontSize: 15,
                  text:
                      'Third Applicant: ${loanDetail.applicants[2].loansharename}',
                ),
              SizedBox(
                width: 30,
              ),
              if (loanDetail.applicantCount > 2)
                CustomText(
                  fontSize: 15,
                  text:
                      'Third Applicant Loan Propotion: ${loanDetail.applicants[2].loansharepercent}',
                ),
              SizedBox(
                width: 30,
              ),
              if (loanDetail.applicantCount > 3)
                CustomText(
                  fontSize: 15,
                  text:
                      'Fourth Applicant: ${loanDetail.applicants[3].loansharename}',
                ),
              SizedBox(
                width: 30,
              ),
              if (loanDetail.applicantCount > 3)
                CustomText(
                  fontSize: 15,
                  text:
                      'Fourth Applicant Loan Propotion: ${loanDetail.applicants[3].loansharepercent}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Container bankdetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              children: [
                CustomText(
                  fontSize: 15,
                  text: 'Bank Name: Name of bank',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15,
                  text: 'Branch Name: Name of Branch',
                ),
                SizedBox(
                  width: 30,
                ),
                CustomText(
                  fontSize: 15,
                  text: 'Sort code: Sort code',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            CustomText(
              fontSize: 15,
              text: 'Branch Acc No: Acc No',
            ),
            SizedBox(
              height: 40,
            ),
            CustomText(
              fontSize: 15,
              text: 'Name and Full Address: Name and address',
            ),
          ]),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch and load the loan request details when the page is opened
    fetchLoanRequestDetails(widget.loanRequestId);
  }

  Future<void> fetchLoanRequestDetails(int loanRequestId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    try {
      Dio dio = Dio();

      // Replace 'YOUR_BEARER_TOKEN' with the actual Bearer token
      String bearerToken = token!;

      final response = await dio.get(
        'https://loan-managment.onrender.com/loan_requests/$loanRequestId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
            // Add any other headers if needed
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          loanDetail = LoanRequestDetails.fromJson(response.data);

          isloadiing = false;
        });

        // print(loanDetail.applicantCount);
      } else {
        // Handle error
        print(
            'Error fetching loan request details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors or network errors
      print('Dio error: $error');
    }
  }

  Future<void> _addFiles(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        // Use the AlertDialog widget for the popup
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.mainbackground,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Upload Attatchments',
                  fontSize: 20,
                  color: AppColors.neutral,
                ),
                TextButton.icon(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                    );

                    if (result != null) {
                      if (result.files.first.size > 1024 * 1024) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('The file size exceeds limit'),
                          ),
                        );
                      } else {
                        setState(() {
                          selectedFiles
                              .addAll(result.files.map((file) => file.bytes!));
                          selectedFilesnames
                              .addAll(result.files.map((file) => file.name));
                        });
                      }
                      print(selectedFiles);
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: AppColors.mainColor,
                  ),
                  label: CustomText(
                    text: 'Add Files',
                    color: AppColors.neutral,
                  ),
                )
              ],
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                height: MediaQuery.of(context).size.height * .7,
                child: selectedFiles.isNotEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width * .7,
                        height: 120,
                        child: Wrap(
                          children: List.generate(
                            selectedFiles.length,
                            (index) {
                              var fileBytes = selectedFiles[index];
                              var fileName = selectedFilesnames[index];
                              String fileExtension =
                                  fileName.split('.').last.toLowerCase();

                              return Container(
                                margin: EdgeInsets.all(10),
                                width: 300,
                                height: 80,
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Display Image for image files

                                        (fileExtension != 'pdf')
                                            ? GestureDetector(
                                                onTap: () {
                                                  // Open image in a new tab
                                                  final blob = html.Blob(
                                                      [fileBytes], 'image/*');
                                                  final url = html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob);
                                                  html.window
                                                      .open(url, '_blank');
                                                },
                                                child: Container(
                                                  width: 300,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            AppColors.neutral),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: AppColors.neutral,
                                                  ),
                                                  child: Image.memory(
                                                    fileBytes,
                                                    width:
                                                        300, // Set the width of the image as per your requirement
                                                    height:
                                                        50, // Set the height of the image as per your requirement
                                                    fit: BoxFit
                                                        .cover, // Adjust this based on your image requirements
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  // Open PDF in a new tab
                                                  final blob = html.Blob([
                                                    Uint8List.fromList(
                                                        fileBytes)
                                                  ], 'application/pdf');
                                                  final url = html.Url
                                                      .createObjectUrlFromBlob(
                                                          blob);
                                                  html.window
                                                      .open(url, '_blank');
                                                },
                                                child: Container(
                                                  width: 300,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .mainColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: AppColors.neutral,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Icon(
                                                        Icons.picture_as_pdf,
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                            height:
                                                8.0), // Add spacing between image and text

                                        // Display file name with overflow handling
                                        Flexible(
                                          child: Text(
                                            fileName,
                                            overflow: TextOverflow.ellipsis,
                                            // Adjust the maximum lines based on your UI requirements
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14,
                                              color: AppColors.neutral,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle the close icon tap
                                          setState(() {
                                            selectedFiles.removeAt(index);
                                            selectedFilesnames.removeAt(index);
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: AppColors.mainColor,
                                          child: Icon(
                                            Icons.close,
                                            size: 15,
                                            color: AppColors.neutral,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ))
                    : SizedBox(),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.mainbackground),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(15, 5, 15, 5))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        text: 'Close',
                        color: AppColors.neutral,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.mainColor),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(15, 5, 15, 5))),
                      onPressed: () {
                        updateData();
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        text: 'Upload',
                        color: AppColors.neutral,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _showPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use the AlertDialog widget for the popup
        return AlertDialog(
          backgroundColor: AppColors.mainbackground,
          title: CustomText(
            text: 'Loan Application Tracking',
            color: AppColors.neutral,
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .7,
              child: Timeline(
                indicators: List<Widget>.generate(4, (index) {
                  return Icon(
                    Icons.circle,
                    color: AppColors.mainColor,
                    size: 12,
                  );
                }),
                children: <Widget>[
                  timelinecontent(
                    'Agent Status',
                    'Assigned Agent: ${loanDetail.agent.name}',
                    'Assigned Date: ${loanDetail.assignedAt}',
                    '',
                  ),
                  timelinecontent(
                      'Netone',
                      'Netone Status: ${loanDetail.requestSystemStatus}',
                      'Last Update: ${loanDetail.requestSystemUpdateDate}',
                      loanDetail.systemRejectionReason != ''
                          ? 'Rejection Reason: ${loanDetail.systemRejectionReason}'
                          : ''),
                  timelinecontent(
                      'Bank ',
                      'Bank Status: ${loanDetail.requestBankStatus}',
                      'Last Update: ${loanDetail.requestBankUpdateDate}',
                      loanDetail.bankRejectionReason != ''
                          ? 'Rejection Reason: ${loanDetail.bankRejectionReason}'
                          : ''),
                  timelinecontent(
                      'Order',
                      'Order Status: ${loanDetail.requestOrderStatus}',
                      'Last Update: ${loanDetail.requestOrderUpdateDate}',
                      ''),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.mainColor),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(
                  text: 'Close',
                  color: AppColors.neutral,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
          ],
        );
      },
    );
  }

  Container timelinecontent(
      String title, String oneone, String onetwo, String twoone) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: title,
              fontSize: 15,
              color: AppColors.neutral,
              fontWeight: FontWeight.w500),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: oneone,
                  fontSize: 13,
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w300),
              CustomText(
                  text: onetwo,
                  fontSize: 13,
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w300)
            ],
          ),
          if (twoone != '')
            SizedBox(
              height: 10,
            ),
          if (twoone != '')
            CustomText(
                text: twoone,
                fontSize: 13,
                color: AppColors.neutral,
                fontWeight: FontWeight.w300),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
      role = prefs.getString('role');
    });
    final String apiUrl =
        'https://loan-managment.onrender.com/loan_requests/${widget.loanRequestId}';

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
      String accessToken = token!;
      request.headers['Authorization'] = 'Bearer $accessToken';

      if (selectedFiles.isNotEmpty) {
        for (var file in selectedFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[documents][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request was successful
        print('Files Submitted successfully');
        setState(() {
          isloadiing = false;
        });
        warning('Files Submitted');
        fetchLoanRequestDetails(widget.loanRequestId);
        //  clearAllFields();
      } else {
        // Request failed
        print('Form submission failed with status: ${response.statusCode}');
        setState(() {
          isloadiing = false;
        });
        warning('Error: Cannot Add Files');
      }
    } catch (e) {
      print("Error: $e");
      warning('Error');
    }
  }

  warning(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: MediaQuery.of(context).size.width * .7,
        backgroundColor: AppColors.neutral,
        duration: Duration(seconds: 3),
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: CustomText(
              text: message,
              fontSize: 13,
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500),
        )));
  }
}
