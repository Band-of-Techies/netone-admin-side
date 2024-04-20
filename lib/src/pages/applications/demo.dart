// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ?
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:dio/dio.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:netone_loanmanagement_admin/src/createapplication/constants/colors.dart';
// import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
// import 'package:netone_loanmanagement_admin/src/pages/dashboard/dashboard.dart';
// import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
// import 'package:netone_loanmanagement_admin/src/res/colors.dart';
// import 'package:netone_loanmanagement_admin/src/res/styles.dart';
// import 'package:netone_loanmanagement_admin/src/res/timeline.dart';
// import 'dart:js' as js;
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui' as ui;

// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class ViewApplication extends StatefulWidget {
//   final int loanRequestId;

//   const ViewApplication({required this.loanRequestId});

//   @override
//   State<ViewApplication> createState() => _ViewApplicationState();
// }

// class _ViewApplicationState extends State<ViewApplication> {
//   late LoanRequestDetails loanDetail;
//   List<String> currentstatusList = ['Approve', 'Reject'];
//   String? currentstatus;
//   GlobalKey globalKey = GlobalKey();
//   Uint8List? _pdfBytes;
//   List<Uint8List> selectedFiles = [];
//   List<String> selectedFilesnames = [];
//   bool isloadiing = true;
//   String? email;
//   String? token;
//   String? role;
//   List<Map<String, dynamic>>? agents = [];
//   @override
//   Widget build(BuildContext context) {
//     return isloadiing == false
//         ? Scaffold(
//             appBar: AppBar(
//               backgroundColor: AppColors.mainbackground,
//               centerTitle: false,
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 color: AppColors.neutral,
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => DashboardScreen()),
//                   );
//                 },
//               ),
//               title: Text(
//                 loanDetail.requestnumber,
//                 style:
//                     GoogleFonts.dmSans(fontSize: 14, color: AppColors.neutral),
//               ),
//               actions: [
//                 Row(
//                   children: [
//                     /*  SizedBox(
//                       height: 40,
//                       width: 350,
//                       child: DropdownButtonFormField2<String>(
//                         isExpanded: true,
//                         decoration: InputDecoration(
//                           focusColor: AppColors.neutral,
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: AppColors.neutral, width: .5)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: AppColors.neutral, width: .5)),
//                           // Add Horizontal padding using menuItemStyleData.padding so it matches
//                           // the menu padding when button's width is not specified.
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 16),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: AppColors.neutral),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           // Add more decoration..
//                         ),
//                         hint: Text(
//                           'Choose Status',
//                           style: GoogleFonts.dmSans(
//                               fontSize: 14, color: AppColors.neutral),
//                         ),
//                         items: currentstatusList
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: CustomText(
//                                     fontSize: 14,
//                                     color: AppColors.neutral,
//                                     text: item,
//                                   ),
//                                 ))
//                             .toList(),
//                         onChanged: (value) {
//                           //Do something when selected item is changed.
//                         },
//                         onSaved: (value) {
//                           selectedstatus = value.toString();
//                         },
//                         buttonStyleData: const ButtonStyleData(
//                           padding: EdgeInsets.only(right: 8),
//                         ),
//                         iconStyleData: const IconStyleData(
//                           icon: Icon(
//                             Icons.arrow_drop_down,
//                             color: AppColors.neutral,
//                           ),
//                           iconSize: 24,
//                         ),
//                         dropdownStyleData: DropdownStyleData(
//                           decoration: BoxDecoration(
//                             color: AppColors.sidebarbackground,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         menuItemStyleData: const MenuItemStyleData(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(AppColors.mainColor),
//                             padding:
//                                 MaterialStateProperty.all(EdgeInsets.all(15))),
//                         onPressed: () {},
//                         child: CustomText(
//                           text: 'Update',
//                           color: AppColors.neutral,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                         )),*/
//                     SizedBox(
//                       width: 20,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               title: CustomText(
//                                 text: 'Print PDF',
//                                 color: primary,
//                               ),
//                               content: Container(
//                                 constraints: BoxConstraints(maxHeight: 200),
//                                 child: Center(
//                                   child: SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * .2,
//                                     child: ListView(
//                                       children: [
//                                         RepaintBoundary(
//                                           key: globalKey,
//                                           child: Stack(
//                                             children: [
//                                               Image.asset(
//                                                 'assets/form1.jpg',
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => AlertDialog(
//                                         content: Container(
//                                           constraints:
//                                               BoxConstraints(maxHeight: 200),
//                                           child: Center(
//                                             child: SizedBox(
//                                                 width: 50,
//                                                 height: 50,
//                                                 child:
//                                                     CircularProgressIndicator()),
//                                           ),
//                                         ),
//                                       ),
//                                     );

//                                     await _generatePdf();
//                                     _downloadPdf();
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('Print'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         icon: Icon(
//                           Icons.print,
//                           size: 20,
//                           color: AppColors.neutral,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           _addFiles(context);
//                         },
//                         icon: Icon(
//                           Icons.add,
//                           size: 20,
//                           color: AppColors.neutral,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           _showPopup(context);
//                         },
//                         icon: Icon(
//                           Icons.track_changes,
//                           size: 20,
//                           color: AppColors.neutral,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     if (loanDetail.requestSystemStatus == 'pending')
//                       IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => EditApplication(
//                                         requestid: widget.loanRequestId,
//                                       )),
//                             );
//                           },
//                           icon: Icon(
//                             Icons.edit,
//                             size: 20,
//                             color: AppColors.neutral,
//                           )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     if (role == 'Admin' && role != 'Agent')
//                       IconButton(
//                           onPressed: () {
//                             showDeleteConfirmationDialog(context);
//                           },
//                           icon: Icon(
//                             Icons.delete,
//                             size: 20,
//                             color: AppColors.neutral,
//                           )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             backgroundColor: AppColors.mainbackground,
//             body: Padding(
//               padding: EdgeInsets.all(20),
//               child: RawScrollbar(
//                 thumbVisibility: true,
//                 thumbColor: AppColors.mainColor,
//                 radius: Radius.circular(20),
//                 thickness: 5,
//                 child: ListView(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * .3,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               CustomText(
//                                 text: 'Form ID: ${loanDetail.id}',
//                                 color: AppColors.neutral,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Row(
//                                 children: [
//                                   CustomText(
//                                     text:''
//                                      //   'Assigned to: ${loanDetail.agent.name}',
//                                     color: AppColors.neutral,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   if (role == 'Adminsss')
//                                     TextButton(
//                                         onPressed: () {
//                                           fetchUsers();
//                                         },
//                                         child: CustomText(
//                                           text: 'Change',
//                                           color: AppColors.primary,
//                                         ))
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * .3,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CustomText(
//                                 text:
//                                     'Applicant: ${loanDetail.applicants[0].surname}',
//                                 color: AppColors.neutral,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               CustomText(
//                                 text:
//                                     'Joint Application: ${loanDetail.applicantCount > 1 ? 'Yes : ${loanDetail.applicantCount}' : 'No'}',
//                                 color: AppColors.neutral,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * .3,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               CustomText(
//                                 text:
//                                     'Date: ${formatDate(loanDetail.createdAt)}',
//                                 color: AppColors.neutral,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               CustomText(
//                                 text:
//                                     'Last Updated: ${formatDate(loanDetail.updatedAt)}',
//                                 color: AppColors.neutral,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     CustomText(
//                       text: 'Part 1',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     CustomText(
//                       text: 'Applicant Details',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     for (int i = 0; i < loanDetail.applicants.length; i++)
//                       applicantDetails(i, i),

//                     // Display other details as needed

//                     // Display details from Section Two
//                     CustomText(
//                       text: 'Part 2',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     CustomText(
//                       text: 'Employment Details',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     for (int i = 0; i < loanDetail.applicants.length; i++)
//                       employmentDetals(i, i),
//                     for (int i = 0; i < loanDetail.applicants.length; i++)
//                       employmentKinDetals(i, i),
//                     CustomText(
//                       text: 'Part 3',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     CustomText(
//                       text: 'Loan Details',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     loanDetails(),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomText(
//                       text: 'Bank Details',
//                       color: AppColors.neutral,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     bankdetails(),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     for (int i = 0; i < loanDetail.applicants.length; i++)
//                       applicantDocuments(i, i),
//                     if (loanDetail.documents.isNotEmpty) additonalDocumnets(),
//                     if (loanDetail.psmpc_purchase_order.isNotEmpty)
//                       orderDocumnets(loanDetail.psmpc_purchase_order,
//                           'PSMPC Purchase Order'),
//                     if (loanDetail.delivery_report.isNotEmpty)
//                       orderDocumnets(
//                           loanDetail.delivery_report, 'DELIVERY RECEIPT'),
//                     if (loanDetail.warranty_form.isNotEmpty)
//                       orderDocumnets(
//                           loanDetail.warranty_form, 'WARRANTY DISCLAIMER FORM'),
//                     if (loanDetail.anti_fraud_form.isNotEmpty)
//                       orderDocumnets(
//                           loanDetail.anti_fraud_form, 'ANTI-FRAUD DECLARATION'),
//                     if (loanDetail.authorize_letter.isNotEmpty)
//                       orderDocumnets(
//                           loanDetail.authorize_letter, 'AUTHORIZATION LETTER'),
//                     if (loanDetail.invoice.isNotEmpty)
//                       orderDocumnets(loanDetail.invoice, 'TAX INVOICE'),
//                     if (loanDetail.swap_agreement.isNotEmpty)
//                       orderDocumnets(
//                           loanDetail.swap_agreement, 'SWAP AGREEMENT'),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         : Scaffold(
//             backgroundColor: AppColors.mainbackground,
//             body: Center(
//                 child: CircularProgressIndicator(
//               color: AppColors.mainColor,
//             )),
//           );
//   }

//   Future<void> _generatePdf() async {
//     final image1 = await _captureWidgetAsImage(globalKey);

//     final image2 = await loadImage('assets/form2.jpg');
//     final image3 = await loadImage('assets/form3.jpg');

//     final image4 = await loadImage('assets/form4.jpg');
//     final image5 = await loadImage('assets/form5.jpg');
//     final image6 = await loadImage('assets/form6.jpg');
//     final image7 = await loadImage('assets/form7.jpg');
//     final image8 = await loadImage('assets/form8.jpg');
//     final image9 = await loadImage('assets/form9.jpg');

//     final image10 = await loadImage('assets/form10.jpg');
//     final image11 = await loadImage('assets/form11.jpg');
//     final image12 = await loadImage('assets/form12.jpg');
//     final image13 = await loadImage('assets/form13.jpg');
//     final image14 = await loadImage('assets/form14.jpg');
//     final image15 = await loadImage('assets/form15.jpg');
//     final image16 = await loadImage('assets/quote.jpg');

//     final sign = await loadImage('assets/sign.png');

//     final tick = await loadImage('assets/tick.png');
//     final pdf = pw.Document();

//     final page1 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image1),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),

//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].surname,
//                 left: 165,
//                 top: 248,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].middleName,
//                 left: 340,
//                 top: 248,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].firstName,
//                 left: 487,
//                 top: 254,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].dob,
//                 left: 340,
//                 top: 275,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].nrc,
//                 left: 490,
//                 top: 275,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].gender == 'Male')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 161,
//                 top: 273,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].gender == 'Female')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 161,
//                 top: 283,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].telephone,
//                 left: 163,
//                 top: 305,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].mobile,
//                 left: 487,
//                 top: 303,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].email,
//                 left: 165,
//                 top: 330,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].licenseNumber,
//                 left: 165,
//                 top: 355,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].licenseExpiry,
//                 left: 430,
//                 top: 355,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].residentialAddress,
//                 left: 165,
//                 top: 380,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].ownership == 'owned')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 154,
//                 top: 397,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].ownership == 'leased')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 216,
//                 top: 397,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].howlongthisplace,
//                 left: 450,
//                 top: 400,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].postalAddress,
//                 left: 165,
//                 top: 420,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].town,
//                 left: 165,
//                 top: 440,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].province,
//                 left: 430,
//                 top: 440,
//               ),

//             //second applicant
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].surname,
//                 left: 165,
//                 top: 535,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].middleName,
//                 left: 350,
//                 top: 534,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].firstName,
//                 left: 490,
//                 top: 530,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].dob,
//                 left: 355,
//                 top: 560,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].nrc,
//                 left: 495,
//                 top: 560,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].gender == 'Male')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 187,
//                 top: 558,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].gender == 'Female')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 187,
//                 top: 568,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].telephone,
//                 left: 165,
//                 top: 590,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].mobile,
//                 left: 490,
//                 top: 588,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].email,
//                 left: 165,
//                 top: 620,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].licenseNumber,
//                 left: 165,
//                 top: 645,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].licenseExpiry,
//                 left: 430,
//                 top: 645,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].residentialAddress,
//                 left: 165,
//                 top: 675,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].ownership == 'owned')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 179,
//                 top: 690,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].ownership == 'leased')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 238,
//                 top: 690,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].howlongthisplace,
//                 left: 450,
//                 top: 691,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].postalAddress,
//                 left: 165,
//                 top: 710,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].town,
//                 left: 165,
//                 top: 735,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].province,
//                 left: 425,
//                 top: 735,
//               ),
//           ],
//         );
//       },
//     );

//     final page2 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image2),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].surname,
//                 left: 165,
//                 top: 80,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].middleName,
//                 left: 355,
//                 top: 78,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].firstName,
//                 left: 490,
//                 top: 78,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].gender == 'Male')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 187,
//                 top: 103,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].gender == 'Female')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 187,
//                 top: 113,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].dob,
//                 left: 355,
//                 top: 105,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].nrc,
//                 left: 495,
//                 top: 105,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].telephone,
//                 left: 140,
//                 top: 135,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].mobile,
//                 left: 480,
//                 top: 135,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].email,
//                 left: 140,
//                 top: 165,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].licenseNumber,
//                 left: 160,
//                 top: 190,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].licenseExpiry,
//                 left: 440,
//                 top: 188,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].residentialAddress,
//                 left: 133,
//                 top: 218,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].ownership == 'owned')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 179,
//                 top: 236,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].ownership == 'leased')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 237,
//                 top: 236,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].howlongthisplace,
//                 left: 450,
//                 top: 240,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].postalAddress,
//                 left: 130,
//                 top: 260,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].town,
//                 left: 130,
//                 top: 285,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].province,
//                 left: 430,
//                 top: 285,
//               ),

//             //fourth applicant
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].surname,
//                 left: 160,
//                 top: 370,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].middleName,
//                 left: 355,
//                 top: 370,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].firstName,
//                 left: 490,
//                 top: 370,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].gender == 'Male')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 187,
//                 top: 394,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].gender == 'Female')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 187,
//                 top: 404,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].dob,
//                 left: 355,
//                 top: 395,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].nrc,
//                 left: 490,
//                 top: 400,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].telephone,
//                 left: 135,
//                 top: 425,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].mobile,
//                 left: 470,
//                 top: 425,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].email,
//                 left: 135,
//                 top: 455,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].licenseNumber,
//                 left: 160,
//                 top: 480,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].licenseExpiry,
//                 left: 445,
//                 top: 480,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].residentialAddress,
//                 left: 160,
//                 top: 510,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].ownership == 'owned')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 180,
//                 top: 527,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].ownership == 'leased')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 237,
//                 top: 527,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].howlongthisplace,
//                 left: 455,
//                 top: 530,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].postalAddress,
//                 left: 125,
//                 top: 550,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].town,
//                 left: 125,
//                 top: 570,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].province,
//                 left: 425,
//                 top: 572,
//               ),
//           ],
//         );
//       },
//     );

//     final page3 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image3),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.jobTitle,
//                 left: 165,
//                 top: 122,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.ministry,
//                 left: 165,
//                 top: 142,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.physicalAddress,
//                 left: 165,
//                 top: 162,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.postalAddress,
//                 left: 165,
//                 top: 182,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.town,
//                 left: 165,
//                 top: 202,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.province,
//                 left: 428,
//                 top: 202,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.grossSalary,
//                 left: 165,
//                 top: 222,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.currentNetSalary,
//                 left: 360,
//                 top: 222,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.salaryScale,
//                 left: 535,
//                 top: 220,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text:
//                     loanDetail.applicants[0].occupation.preferredRetirementYear,
//                 left: 165,
//                 top: 245,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.employerNumber,
//                 left: 360,
//                 top: 250,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.yearsOfService,
//                 left: 558,
//                 top: 246,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].occupation.employmentType ==
//                     'permanent')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 150,
//                 top: 276,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].occupation.employmentType ==
//                     'contract')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 287,
//                 top: 276,
//               ),
//             if (loanDetail.applicantCount > 0 &&
//                 loanDetail.applicants[0].occupation.employmentType ==
//                     'contract')
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].occupation.tempExpiryDate,
//                 left: 470,
//                 top: 275,
//               ),
//             //secondjob
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.jobTitle,
//                 left: 165,
//                 top: 325,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.ministry,
//                 left: 165,
//                 top: 345,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.physicalAddress,
//                 left: 165,
//                 top: 365,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.postalAddress,
//                 left: 165,
//                 top: 385,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.town,
//                 left: 165,
//                 top: 405,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.province,
//                 left: 430,
//                 top: 405,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.grossSalary,
//                 left: 165,
//                 top: 425,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.netSalary,
//                 left: 360,
//                 top: 425,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.salaryScale,
//                 left: 540,
//                 top: 422,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text:
//                     loanDetail.applicants[1].occupation.preferredRetirementYear,
//                 left: 165,
//                 top: 447,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.employerNumber,
//                 left: 360,
//                 top: 448,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.yearsOfService,
//                 left: 560,
//                 top: 450,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].occupation.employmentType ==
//                     'permanent')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 145,
//                 top: 480,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].occupation.employmentType ==
//                     'contract')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 281,
//                 top: 480,
//               ),
//             if (loanDetail.applicantCount > 1 &&
//                 loanDetail.applicants[1].occupation.employmentType ==
//                     'contract')
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].occupation.tempExpiryDate,
//                 left: 450,
//                 top: 480,
//               ),
//             //third applicant
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.jobTitle,
//                 left: 165,
//                 top: 520,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.ministry,
//                 left: 165,
//                 top: 545,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.physicalAddress,
//                 left: 165,
//                 top: 570,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.postalAddress,
//                 left: 165,
//                 top: 590,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.town,
//                 left: 165,
//                 top: 610,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.province,
//                 left: 420,
//                 top: 611,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.grossSalary,
//                 left: 105,
//                 top: 634,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.currentNetSalary,
//                 left: 358,
//                 top: 632,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.salaryScale,
//                 left: 538,
//                 top: 635,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text:
//                     loanDetail.applicants[2].occupation.preferredRetirementYear,
//                 left: 168,
//                 top: 655,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.employerNumber,
//                 left: 360,
//                 top: 660,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.yearsOfService,
//                 left: 555,
//                 top: 660,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].occupation.employmentType ==
//                     'permanent')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 146,
//                 top: 688,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].occupation.employmentType ==
//                     'contract')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 286,
//                 top: 688,
//               ),
//             if (loanDetail.applicantCount > 2 &&
//                 loanDetail.applicants[2].occupation.employmentType ==
//                     'contract')
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].occupation.tempExpiryDate,
//                 left: 450,
//                 top: 685,
//               ),
//           ],
//         );
//       },
//     );
//     final page4 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image4),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.jobTitle,
//                 left: 165,
//                 top: 80,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.ministry,
//                 left: 165,
//                 top: 105,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.physicalAddress,
//                 left: 165,
//                 top: 125,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.postalAddress,
//                 left: 165,
//                 top: 147,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.town,
//                 left: 129,
//                 top: 165,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.province,
//                 left: 420,
//                 top: 168,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.grossSalary,
//                 left: 120,
//                 top: 187,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.currentNetSalary,
//                 left: 360,
//                 top: 186,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.salaryScale,
//                 left: 540,
//                 top: 187,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text:
//                     loanDetail.applicants[3].occupation.preferredRetirementYear,
//                 left: 170,
//                 top: 210,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.employerNumber,
//                 left: 360,
//                 top: 215,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.yearsOfService,
//                 left: 560,
//                 top: 213,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].occupation.employmentType ==
//                     'permanent')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 148,
//                 top: 239,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].occupation.employmentType ==
//                     'contract')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 280,
//                 top: 240,
//               ),
//             if (loanDetail.applicantCount > 3 &&
//                 loanDetail.applicants[3].occupation.employmentType ==
//                     'contract')
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].occupation.tempExpiryDate,
//                 left: 450,
//                 top: 240,
//               ),
//             //kin 1st applicant
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].kin.name,
//                 left: 160,
//                 top: 290,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].kin.otherNames,
//                 left: 375,
//                 top: 290,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].kin.physicalAddress,
//                 left: 160,
//                 top: 310,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].kin.postalAddress,
//                 left: 160,
//                 top: 365,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].kin.phoneNumber,
//                 left: 160,
//                 top: 400,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].kin.email,
//                 left: 160,
//                 top: 420,
//               ),

//             //kin second applicant
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].kin.name,
//                 left: 110,
//                 top: 495,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].kin.otherNames,
//                 left: 375,
//                 top: 495,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].kin.physicalAddress,
//                 left: 160,
//                 top: 520,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].kin.postalAddress,
//                 left: 160,
//                 top: 573,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].kin.phoneNumber,
//                 left: 160,
//                 top: 610,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].kin.email,
//                 left: 160,
//                 top: 630,
//               ),
//           ],
//         );
//       },
//     );

//     final page5 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image5),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].kin.name,
//                 left: 115,
//                 top: 70,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].kin.otherNames,
//                 left: 380,
//                 top: 70,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].kin.physicalAddress,
//                 left: 160,
//                 top: 92,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].kin.postalAddress,
//                 left: 160,
//                 top: 145,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].kin.phoneNumber,
//                 left: 160,
//                 top: 182,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].kin.email,
//                 left: 160,
//                 top: 205,
//               ),
//             //4th Kin Applicant
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].kin.name,
//                 left: 115,
//                 top: 275,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].kin.otherNames,
//                 left: 370,
//                 top: 275,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].kin.physicalAddress,
//                 left: 160,
//                 top: 303,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].kin.postalAddress,
//                 left: 160,
//                 top: 355,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].kin.phoneNumber,
//                 left: 160,
//                 top: 390,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].kin.email,
//                 left: 160,
//                 top: 415,
//               ),
//           ],
//         );
//       },
//     );
//     final page6 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image6),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             //motorvehicle
//             if (loanDetail.category.name == 'Motor Vehicle Loan')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 165,
//                 top: 83,
//               ),
//             //agri
//             if (loanDetail.category.name == 'Agricultural Asset Loan')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 310,
//                 top: 83,
//               ),
//             //furniture
//             if (loanDetail.category.name == 'Furniture Loan')
//               CustomPositionedCheck(
//                 left: 460,
//                 tick: tick,
//                 top: 83,
//               ),
//             //buidling
//             if (loanDetail.category.name == 'Building Material Loan')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 165,
//                 top: 114,
//               ),
//             //device
//             if (loanDetail.category.name == 'Bring Your Own Device')
//               CustomPositionedCheck(
//                 tick: tick,
//                 left: 310,
//                 top: 114,
//               ),
//             CustomPositionedText(
//               text: loanDetail.costOfAsset,
//               left: 196,
//               top: 210,
//             ),
//             CustomPositionedText(
//               text: loanDetail.insuranceCost,
//               left: 196,
//               top: 230,
//             ),
//             CustomPositionedText(
//               text: loanDetail.advancePayment,
//               left: 196,
//               top: 250,
//             ),
//             CustomPositionedText(
//               text: loanDetail.loanAmount,
//               left: 196,
//               top: 270,
//             ),
//             CustomPositionedText(
//               text: loanDetail.loanTenure,
//               left: 196,
//               top: 292,
//             ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].loansharename,
//                 left: 196,
//                 top: 350,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].loansharename,
//                 left: 490,
//                 top: 350,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].loansharename,
//                 left: 196,
//                 top: 372,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].loansharename,
//                 left: 490,
//                 top: 372,
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].loansharepercent,
//                 left: 197,
//                 top: 396,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].loansharepercent,
//                 left: 491,
//                 top: 396,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].loansharepercent,
//                 left: 198,
//                 top: 419,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].loansharepercent,
//                 left: 490,
//                 top: 419,
//               ),

//             //filldetails
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].surname,
//                 left: 85,
//                 top: 549,
//               ),
//             if (loanDetail.applicantCount > 0)
//               pw.Positioned(
//                 left: 60,
//                 top: 635,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 30, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.createdAt,
//                 left: 415,
//                 top: 662,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].surname,
//                 left: 85,
//                 top: 691,
//               ),
//           ],
//         );
//       },
//     );

//     final page7 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image7),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             if (loanDetail.applicantCount > 1)
//               pw.Positioned(
//                 left: 60,
//                 top: 100,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 30, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.createdAt,
//                 left: 420,
//                 top: 130,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].surname,
//                 left: 85,
//                 top: 180,
//               ),
//             if (loanDetail.applicantCount > 2)
//               pw.Positioned(
//                 left: 60,
//                 top: 270,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 30, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.createdAt,
//                 left: 395,
//                 top: 292,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].surname,
//                 left: 85,
//                 top: 321,
//               ),
//             if (loanDetail.applicantCount > 3)
//               pw.Positioned(
//                 left: 60,
//                 top: 420,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 30, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.createdAt,
//                 left: 420,
//                 top: 440,
//               ),
//           ],
//         );
//       },
//     );
//     final page8 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image8),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     final page9 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image9),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     final page10 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image10),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     final page11 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image11),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     final page12 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image12),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     final page13 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image13),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     final page14 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image14),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].surname,
//                 left: 328,
//                 top: 221,
//               ),
//             if (loanDetail.applicantCount > 0)
//               pw.Positioned(
//                 left: 330,
//                 top: 255,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 20, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 0)
//               CustomPositionedText(
//                 text: loanDetail.applicants[0].createdAt,
//                 left: 340,
//                 top: 307,
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].surname,
//                 left: 328,
//                 top: 328,
//               ),
//             if (loanDetail.applicantCount > 1)
//               pw.Positioned(
//                 left: 330,
//                 top: 370,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 20, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 1)
//               CustomPositionedText(
//                 text: loanDetail.applicants[1].createdAt,
//                 left: 340,
//                 top: 424,
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].surname,
//                 left: 328,
//                 top: 445,
//               ),
//             if (loanDetail.applicantCount > 2)
//               pw.Positioned(
//                 left: 330,
//                 top: 480,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 20, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 2)
//               CustomPositionedText(
//                 text: loanDetail.applicants[2].createdAt,
//                 left: 340,
//                 top: 545,
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].surname,
//                 left: 328,
//                 top: 565,
//               ),
//             if (loanDetail.applicantCount > 3)
//               pw.Positioned(
//                 left: 330,
//                 top: 600,
//                 child: pw.Image(
//                   pw.MemoryImage(
//                       sign), // Assuming image7 is the image you want to place
//                   width: 50, // Adjust width as needed
//                   height: 20, // Adjust height as needed
//                 ),
//               ),
//             if (loanDetail.applicantCount > 3)
//               CustomPositionedText(
//                 text: loanDetail.applicants[3].createdAt,
//                 left: 340,
//                 top: 645,
//               ),
//           ],
//         );
//       },
//     );
//     final page15 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image15),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             //payers details
//             CustomPositionedText(
//               text: loanDetail.applicants[0].surname,
//               left: 100,
//               top: 345,
//             ),

//             CustomPositionedText(
//               text: loanDetail.applicants[0].mobile.split('         ').join(),
//               left: 100,
//               top: 370,
//             ),
//             CustomPositionedText(
//               text: loanDetail.applicants[0].email,
//               left: 340,
//               top: 370,
//             ),
//             CustomPositionedText(
//               text: loanDetail.applicants[0].residentialAddress,
//               left: 100,
//               top: 398,
//             ),
//             //payersbankdetails
//             CustomPositionedText(
//               text: 'BANKNAME',
//               left: 100,
//               top: 434,
//             ),
//             CustomPositionedText(
//               text: 'BRANCHNAME',
//               left: 100,
//               top: 464,
//             ),
//             CustomPositionedText(
//               text: '1         2         3         4         5         6',
//               left: 285,
//               top: 464,
//             ),
//             CustomPositionedText(
//               text:
//                   '2         6         0         1         2         3         4         5         6         7         8         9',
//               left: 100,
//               top: 494,
//             ),
//             CustomPositionedText(
//               text: 'NAME AND FULL POSTALL ADDRESS',
//               left: 100,
//               top: 550,
//             ),
//             pw.Positioned(
//               left: 100,
//               top: 640,
//               child: pw.Image(
//                 pw.MemoryImage(
//                     sign), // Assuming image7 is the image you want to place
//                 width: 50, // Adjust width as needed
//                 height: 30, // Adjust height as needed
//               ),
//             ),
//             CustomPositionedText(
//               text: 'DATE',
//               left: 250,
//               top: 660,
//             ),
//           ],
//         );
//       },
//     );
//     final vat = int.parse(loanDetail.original_total_cost) * .16;
//     final total = vat + int.parse(loanDetail.original_total_cost);
//     final page16 = pw.Page(
//       margin: pw.EdgeInsets.zero, // Remove default margins
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Center(
//               child: pw.Image(
//                 pw.MemoryImage(image16),
//                 fit: pw.BoxFit.contain,
//               ),
//             ),
//             CustomPositionedTextNOBold(
//               text: loanDetail.createdAt,
//               left: 500,
//               top: 146,
//             ),
//             CustomPositionedTextNOBold(
//               text: 'NB 1234',
//               left: 500,
//               top: 161,
//             ),
//             CustomPositionedTextBold(
//               text: loanDetail.applicants[0].surname,
//               left: 85,
//               top: 203,
//             ),
//             CustomPositionedTextNOBold(
//               text: '',
//               // loanDetail.agent.name != null ? loanDetail.agent.name : 'NA',
//               left: 26,
//               top: 386,
//             ),
//             CustomPositionedTextBold(
//               text: 'Payment Terms ',
//               left: 20,
//               top: 680,
//             ),
//             CustomPositionedTextBold(
//               text: 'LOAN APPROVAL THROUGH PSMFC',
//               left: 110,
//               top: 680,
//             ),
//             CustomPositionedTextBold(
//               text: 'Delivery of Device',
//               left: 20,
//               top: 695,
//             ),
//             CustomPositionedTextBold(
//               text: 'EX STOCK',
//               left: 110,
//               top: 695,
//             ),
//             CustomPositionedTextBold(
//               text: 'Quote Validity',
//               left: 20,
//               top: 710,
//             ),
//             CustomPositionedTextBold(
//               text: '21 days',
//               left: 110,
//               top: 710,
//             ),
//             CustomPositionedTextBold(
//               text: 'THANK YOU FOR YOUR BUSINESS!',
//               left: 220,
//               top: 730,
//             ),
//             CustomPositionedTextBold(
//               text: 'Website',
//               left: 20,
//               top: 750,
//             ),
//             CustomPositionedTextNOBold(
//               text: 'www.digitize.co.zm',
//               left: 90,
//               top: 750,
//             ),
//             CustomPositionedTextBold(
//               text: 'Whatsapp',
//               left: 20,
//               top: 765,
//             ),
//             CustomPositionedTextNOBold(
//               text: '962148178',
//               left: 90,
//               top: 765,
//             ),
//             CustomPositionedTextBold(
//               text: 'Phone',
//               left: 20,
//               top: 780,
//             ),
//             CustomPositionedTextNOBold(
//               text: '0211 372 600',
//               left: 90,
//               top: 780,
//             ),

//             //calculationssubtotal
//             CustomPositionedTextNOBold(
//               text: 'SUBTOTAL',
//               left: 420,
//               top: 660,
//             ),
//             CustomPositionedTextNOBold(
//               text: loanDetail.original_total_cost,
//               left: 515,
//               top: 660,
//             ),
//             //taxrate
//             CustomPositionedTextNOBold(
//               text: 'TAXRATE',
//               left: 420,
//               top: 680,
//             ),
//             CustomPositionedTextNOBold(
//               text: '0.16',
//               left: 515,
//               top: 680,
//             ),
//             //vat
//             CustomPositionedTextNOBold(
//               text: 'VAT',
//               left: 420,
//               top: 695,
//             ),
//             CustomPositionedTextNOBold(
//               text: '10,343.97',
//               left: 515,
//               top: 695,
//             ),
//             //totalprice
//             CustomPositionedTextBold(
//               text: 'TOTAL PRICE',
//               left: 420,
//               top: 710,
//             ),
//             CustomPositionedTextNOBold(
//               text: '10,343.97',
//               left: 515,
//               top: 710,
//             ),
//             for (int i = 0; i < loanDetail.requestedProducts.length; i++)
//               productContainer(
//                   price: 10343.96552,
//                   toppostion: 444 + (i * 60),
//                   quantity: loanDetail.requestedProducts[i].quantity,
//                   description: '''${loanDetail.requestedProducts[i].productName}
//                                     ${loanDetail.requestedProducts[i].productDescription}''')
//           ],
//         );
//       },
//     );
//     List<dynamic> pages = [];

//     for (int j = 0; j < loanDetail.applicantCount; j++) {
//       for (int i = 0; i < loanDetail.applicants[j].payslip1.length; i++) {
//         if (!loanDetail.applicants[j].payslip1[i].contentType.contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].payslip1[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//       for (int i = 0; i < loanDetail.applicants[j].payslip2.length; i++) {
//         if (!loanDetail.applicants[j].payslip2[i].contentType.contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].payslip2[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//       for (int i = 0; i < loanDetail.applicants[j].payslip3.length; i++) {
//         if (!loanDetail.applicants[j].payslip3[i].contentType.contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].payslip3[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//       for (int i = 0; i < loanDetail.applicants[j].intoletter.length; i++) {
//         if (!loanDetail.applicants[j].intoletter[i].contentType
//             .contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].intoletter[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//       for (int i = 0; i < loanDetail.applicants[j].nrccopy.length; i++) {
//         if (!loanDetail.applicants[j].nrccopy[i].contentType.contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].nrccopy[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//       for (int i = 0; i < loanDetail.applicants[j].bankstatemtn.length; i++) {
//         if (!loanDetail.applicants[j].bankstatemtn[i].contentType
//             .contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].bankstatemtn[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//       for (int i = 0; i < loanDetail.applicants[j].documents.length; i++) {
//         if (!loanDetail.applicants[j].documents[i].contentType
//             .contains('pdf')) {
//           final Uint8List imageBytes = await fetchAndConvertImage(
//               loanDetail.applicants[j].documents[i].url);
//           pages.add(pw.Page(
//             margin: pw.EdgeInsets.zero, // Remove default margins
//             build: (context) {
//               return pw.Stack(
//                 children: [
//                   pw.Center(
//                     child: pw.Image(
//                       pw.MemoryImage(imageBytes),
//                       fit: pw.BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ));
//         }
//       }
//     }

//     pdf.addPage(page1);
//     pdf.addPage(page2);
//     pdf.addPage(page3);
//     pdf.addPage(page4);
//     pdf.addPage(page5);
//     pdf.addPage(page6);
//     pdf.addPage(page7);
//     pdf.addPage(page8);
//     pdf.addPage(page9);
//     pdf.addPage(page10);
//     pdf.addPage(page11);
//     pdf.addPage(page12);
//     pdf.addPage(page13);
//     pdf.addPage(page14);
//     pdf.addPage(page15);
//     pdf.addPage(page16);
//     for (int i = 0; i < pages.length; i++) {
//       pdf.addPage(pages[i]);
//     }
//     final Uint8List pdfBytes = await pdf.save();
//     setState(() {
//       _pdfBytes = pdfBytes;
//     });
//   }

//   Future<Uint8List> _captureWidgetAsImage(GlobalKey key) async {
//     RenderRepaintBoundary boundary =
//         key.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData!.buffer.asUint8List();
//   }

//   Future<Uint8List> fetchAndConvertImage(String imageUrl) async {
//     final response = await http.get(Uri.parse(imageUrl));
//     if (response.statusCode == 200) {
//       return response.bodyBytes;
//     } else {
//       throw Exception('Failed to load image: $imageUrl');
//     }
//   }

//   Future<Uint8List> loadImage(String path) async {
//     final ByteData data = await rootBundle.load(path);
//     return data.buffer.asUint8List();
//   }

//   void _downloadPdf() {
//     html.AnchorElement(
//         href:
//             'data:application/octet-stream;base64,' + base64Encode(_pdfBytes!))
//       ..setAttribute('download', 'generated_pdf.pdf')
//       ..click();
//   }

//   Future<void> changeAgent(BuildContext context) async {
//     String? seletedagent;
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppColors.sidebarbackground,
//           title: CustomText(
//             text: 'Change Agent',
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             color: AppColors.mainColor,
//           ),
//           content: Column(
//             children: [
//               CustomText(
//                 text: 'Select an agent',
//                 color: AppColors.neutral,
//               ),
//               SizedBox(
//                 width: 160,
//                 child: DropdownButtonFormField2<String>(
//                   isExpanded: true,
//                   decoration: InputDecoration(
//                     // Add Horizontal padding using menuItemStyleData.padding so it matches
//                     // the menu padding when button's width is not specified.
//                     contentPadding: const EdgeInsets.symmetric(vertical: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     // Add more decoration..
//                   ),
//                   hint: Text(
//                     'Choose Agent',
//                     style: GoogleFonts.dmSans(
//                         fontSize: 14, color: AppColors.neutral),
//                   ),
//                   items: agents!.map((agent) {
//                     return DropdownMenuItem<String>(
//                       value: agent['id'].toString(),
//                       child: CustomText(
//                         fontSize: 14,
//                         color: AppColors.neutral,
//                         text: agent['name'].toString(),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (agent) {
//                     setState(() {
//                       seletedagent = agent!;
//                       print(agent);
//                     });
//                   },
//                   buttonStyleData: const ButtonStyleData(
//                     padding: EdgeInsets.only(right: 8),
//                   ),
//                   iconStyleData: const IconStyleData(
//                     icon: Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.black45,
//                     ),
//                     iconSize: 24,
//                   ),
//                   dropdownStyleData: DropdownStyleData(
//                     decoration: BoxDecoration(
//                       color: AppColors.sidebarbackground,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   menuItemStyleData: const MenuItemStyleData(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             // Cancel Button
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: CustomText(
//                 text: 'Cancel',
//                 color: AppColors.neutral,
//               ),
//             ),
//             // Confirm Button
//             TextButton(
//               onPressed: () {
//                 _submitAssignment(widget.loanRequestId, seletedagent!);
//               },
//               child: CustomText(
//                 text: 'Confirm',
//                 color: AppColors.neutral,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> fetchUsers() async {
//     final String usersApiEndpoint = 'https://loan-managment.onrender.com/users';
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       token = prefs.getString('token');
//       email = prefs.getString('email');
//     });
//     try {
//       Dio dio = Dio();
//       var usersResponse = await dio.get(
//         usersApiEndpoint,
//         options: Options(
//           headers: {'Authorization': 'Bearer $token'},
//         ),
//       );

//       if (usersResponse.statusCode == 200 || usersResponse.statusCode == 201) {
//         setState(() {
//           agents = (usersResponse.data['users'] as List<dynamic>)
//               .map((user) => {
//                     'id': user['id'],
//                     'name': user['name'],
//                   })
//               .toList();
//         });
//         // Handle the retrieved user list
//         changeAgent(context);
//       } else {
//         warning('Cannot fetch agenets');
//         print(
//             'Error: ${usersResponse.statusCode} - ${usersResponse.statusMessage}');
//         // Handle error state if necessary
//       }
//     } catch (error) {
//       warning('Cannot fetch agenets');
//       print('Error: $error');
//       // Handle error state if necessary
//     }
//   }

//   Future<void> _submitAssignment(int id, String seletedagent) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (seletedagent != null) {
//       // Replace with your actual API endpoint

//       String apiUrl = "https://loan-managment.onrender.com/loan_requests/$id";
//       // Replace 'yourAccessToken' with the actual token
//       String accessToken = prefs.getString('token')!;

//       Dio dio = Dio();
//       dio.options.headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       };

//       // Create the request body
//       Map<String, dynamic> requestBody = {
//         'assign_to': {
//           'id': seletedagent,
//         }
//       };

//       try {
//         Response response = await dio.patch(apiUrl, data: requestBody);
//         if (response.statusCode == 201 || response.statusCode == 200) {
//           // Successfully created assignment (status code 201 for POST)
//           print('Assignment created successfully');
//         } else {
//           // Handle error
//           print(
//               'Failed to create assignment. Status code: ${response.statusCode}');
//         }
//       } catch (error) {
//         // Handle error
//         print('Error during POST request: $error');
//       }
//     }
//   }

//   Future<void> showDeleteConfirmationDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppColors.sidebarbackground,
//           title: CustomText(
//             text: 'Confirm Deletion',
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             color: AppColors.mainColor,
//           ),
//           content: CustomText(
//             text: 'Are you sure you want to delete this item?',
//             color: AppColors.neutral,
//           ),
//           actions: [
//             // Cancel Button
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: CustomText(
//                 text: 'Cancel',
//                 color: AppColors.neutral,
//               ),
//             ),
//             // Confirm Button
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 // Call deleteData when confirmed
//                 deleteData(widget.loanRequestId);
//               },
//               child: CustomText(
//                 text: 'Confirm',
//                 color: AppColors.neutral,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> deleteData(int id) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isloadiing = true;
//       token = prefs.getString('token');
//       email = prefs.getString('email');
//     });
//     final String apiUrl =
//         'https://loan-managment.onrender.com/loan_requests/$id';
//     final String accessToken = token!;

//     try {
//       var response = await http.delete(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200 || response.statusCode == 204) {
//         // Request was successful
//         print('DELETE request for ID $id successful');
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DashboardScreen()),
//         );
//       } else {
//         // Request failed
//         print(
//             'DELETE request for ID $id failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error for ID $id: $e');
//     }
//   }

//   CustomPositionedText(
//       {required String text, required double left, required double top}) {
//     return pw.Positioned(
//       left: left,
//       top: top,
//       child: pw.Text(
//         text,
//         style: pw.TextStyle(
//           fontSize: 6,
//           color: PdfColors.black,
//           fontWeight: pw.FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   customText({required String text}) {
//     return pw.Text(
//       text,
//       style: pw.TextStyle(
//         fontSize: 8,
//         color: PdfColors.black,
//         fontWeight: pw.FontWeight.normal,
//       ),
//     );
//   }

//   productContainer(
//       {required double toppostion,
//       required int quantity,
//       description,
//       required double price}) {
//     return pw.Positioned(
//       left: 16,
//       top: toppostion,
//       child: pw.Container(
//           width: 565,
//           height: 60,
//           child: pw.Row(children: [
//             pw.Container(
//                 width: 89,
//                 height: 60,
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(
//                     color: PdfColors.black, // Border color
//                     width: 1, // Border width
//                   ),
//                 ),
//                 child: pw.Center(child: customText(text: quantity.toString()))),
//             pw.Container(
//                 width: 288,
//                 height: 60,
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(
//                     color: PdfColors.black, // Border color
//                     width: 1, // Border width
//                   ),
//                 ),
//                 child: pw.Center(child: customText(text: description))),
//             pw.Container(
//                 width: 100,
//                 height: 60,
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(
//                     color: PdfColors.black, // Border color
//                     width: 1, // Border width
//                   ),
//                 ),
//                 child: pw.Center(child: customText(text: price.toString()))),
//             pw.Container(
//                 width: 87,
//                 height: 60,
//                 decoration: pw.BoxDecoration(
//                   border: pw.Border.all(
//                     color: PdfColors.black, // Border color
//                     width: 1, // Border width
//                   ),
//                 ),
//                 child: pw.Center(
//                     child: customText(text: (price * quantity).toString())))
//           ])),
//     );
//   }

//   CustomPositionedTextBold(
//       {required String text, required double left, required double top}) {
//     return pw.Positioned(
//       left: left,
//       top: top,
//       child: pw.Text(
//         text,
//         style: pw.TextStyle(
//           fontSize: 8,
//           color: PdfColors.black,
//           fontWeight: pw.FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   CustomPositionedTextNOBold(
//       {required String text, required double left, required double top}) {
//     return pw.Positioned(
//       left: left,
//       top: top,
//       child: pw.Text(
//         text,
//         style: pw.TextStyle(
//           fontSize: 8,
//           color: PdfColors.black,
//           fontWeight: pw.FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   pw.Widget CustomPositionedCheck(
//       {required double left, required double top, required Uint8List? tick}) {
//     return pw.Positioned(
//       left: left,
//       top: top,
//       child: pw.Image(
//         pw.MemoryImage(tick!), // Assuming image7 is the image you want to place
//         width: 10, // Adjust width as needed
//         height: 10, // Adjust height as needed
//       ),
//     );
//   }

//   String formatDate(String dateString) {
//     DateTime dateTime = DateTime.parse(dateString);
//     String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
//     return formattedDate;
//   }

//   Container applicantDocuments(int applicantkey, int i) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: 'Applicant ${i + 1}',
//             fontWeight: FontWeight.w700,
//             fontSize: 15,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: List.generate(
//               loanDetail.applicants[applicantkey].documents.length,
//               (index) {
//                 return Container(
//                   margin: EdgeInsets.all(10),
//                   width: 300,
//                   height: 90,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display Image for image files
//                       isImage(loanDetail.applicants[applicantkey]
//                               .documents[index].contentType)
//                           ? GestureDetector(
//                               onTap: () {
//                                 String imageUrl = loanDetail
//                                     .applicants[applicantkey]
//                                     .documents[index]
//                                     .url;
//                                 js.context.callMethod('open', [imageUrl]);
//                               },
//                               child: Container(
//                                 width: 300,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: AppColors.mainbackground),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: AppColors.neutral,
//                                 ),
//                                 child: Image.network(
//                                   loanDetail.applicants[applicantkey]
//                                       .documents[index].url,
//                                   width:
//                                       300, // Set the width of the image as per your requirement
//                                   height:
//                                       50, // Set the height of the image as per your requirement
//                                   fit: BoxFit
//                                       .cover, // Adjust this based on your image requirements
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       width: 300,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: AppColors.neutral),
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: AppColors.neutral,
//                                       ),
//                                       child: Center(
//                                         child: Text('Image Not Found'),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             )
//                           : loanDetail.applicants[applicantkey].documents[index]
//                                   .contentType
//                                   .contains('pdf')
//                               ? GestureDetector(
//                                   onTap: () {
//                                     String pdfUrl = loanDetail
//                                         .applicants[applicantkey]
//                                         .documents[index]
//                                         .url;
//                                     js.context.callMethod('open', [pdfUrl]);
//                                   },
//                                   child: Container(
//                                     width: 300,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: AppColors.neutral),
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: AppColors.neutral,
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 20,
//                                         ),
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           color: Colors.red,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   width: 300,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: AppColors.neutral),
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: AppColors.neutral,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Icon(
//                                         Icons.enhanced_encryption,
//                                         color: Colors.red,
//                                       ),
//                                       CustomText(text: 'Unreadable Format')
//                                     ],
//                                   ),
//                                 ),

//                       SizedBox(
//                           height: 8.0), // Add spacing between image and text

//                       // Display file name with overflow handling
//                       Flexible(
//                         child: Text(
//                           'Document  ${index + 1}',

//                           // Adjust the maximum lines based on your UI requirements
//                           style: GoogleFonts.dmSans(
//                             color: AppColors.neutral,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           if (loanDetail.applicants[applicantkey].payslip1.length > 0)
//             loadDocFiles(applicantkey, 'Payslip 1',
//                 loanDetail.applicants[applicantkey].payslip1),
//           SizedBox(
//             height: 20,
//           ),
//           if (loanDetail.applicants[applicantkey].payslip2.length > 0)
//             loadDocFiles(applicantkey, 'Payslip 2',
//                 loanDetail.applicants[applicantkey].payslip2),
//           if (loanDetail.applicants[applicantkey].payslip3.length > 0)
//             loadDocFiles(applicantkey, 'Payslip 3',
//                 loanDetail.applicants[applicantkey].payslip3),
//           if (loanDetail.applicants[applicantkey].intoletter.length > 0)
//             loadDocFiles(applicantkey, 'Introductory Letter',
//                 loanDetail.applicants[applicantkey].intoletter),
//           if (loanDetail.applicants[applicantkey].bankstatemtn.length > 0)
//             loadDocFiles(applicantkey, 'Bank Statement',
//                 loanDetail.applicants[applicantkey].bankstatemtn),
//           if (loanDetail.applicants[applicantkey].nrccopy.length > 0)
//             loadDocFiles(applicantkey, 'NRC',
//                 loanDetail.applicants[applicantkey].nrccopy),
//         ],
//       ),
//     );
//   }

//   Row loadDocFiles(
//       int applicantkey, String text, List<Document> documentstoload) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         CustomText(text: '$text: '),
//         Wrap(
//           children: List.generate(
//             documentstoload.length,
//             (index) {
//               return Container(
//                 margin: EdgeInsets.all(10),
//                 width: 300,
//                 height: 90,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Display Image for image files
//                     isImage(documentstoload[index].contentType)
//                         ? GestureDetector(
//                             onTap: () {
//                               String imageUrl = documentstoload[index].url;
//                               js.context.callMethod('open', [imageUrl]);
//                             },
//                             child: Container(
//                               width: 300,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(color: AppColors.mainbackground),
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: AppColors.neutral,
//                               ),
//                               child: Image.network(
//                                 documentstoload[index].url,
//                                 width:
//                                     300, // Set the width of the image as per your requirement
//                                 height:
//                                     50, // Set the height of the image as per your requirement
//                                 fit: BoxFit
//                                     .cover, // Adjust this based on your image requirements
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Container(
//                                     width: 300,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: AppColors.neutral),
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: AppColors.neutral,
//                                     ),
//                                     child: Center(
//                                       child: Text('Image Not Found'),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           )
//                         : documentstoload[index].contentType.contains('pdf')
//                             ? GestureDetector(
//                                 onTap: () {
//                                   String pdfUrl = documentstoload[index].url;
//                                   js.context.callMethod('open', [pdfUrl]);
//                                 },
//                                 child: Container(
//                                   width: 300,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: AppColors.neutral),
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: AppColors.neutral,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Icon(
//                                         Icons.picture_as_pdf,
//                                         color: Colors.red,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : Container(
//                                 width: 300,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: AppColors.neutral),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: AppColors.neutral,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                     Icon(
//                                       Icons.enhanced_encryption,
//                                       color: Colors.red,
//                                     ),
//                                     CustomText(text: 'Unreadable Format')
//                                   ],
//                                 ),
//                               ),

//                     SizedBox(height: 8.0), // Add spacing between image and text

//                     // Display file name with overflow handling
//                     Flexible(
//                       child: Text(
//                         'Document  ${index + 1}',

//                         // Adjust the maximum lines based on your UI requirements
//                         style: GoogleFonts.dmSans(
//                           color: AppColors.neutral,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Container additonalDocumnets() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: 'Additional Files',
//             fontWeight: FontWeight.w700,
//             fontSize: 15,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Wrap(
//             children: List.generate(
//               loanDetail.documents.length,
//               (index) {
//                 return Container(
//                   margin: EdgeInsets.all(10),
//                   width: 300,
//                   height: 90,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display Image for image files
//                       isImage(loanDetail.documents[index].contentType)
//                           ? GestureDetector(
//                               onTap: () {
//                                 String imageUrl =
//                                     loanDetail.documents[index].url;
//                                 js.context.callMethod('open', [imageUrl]);
//                               },
//                               child: Container(
//                                 width: 300,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: AppColors.mainbackground),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: AppColors.neutral,
//                                 ),
//                                 child: Image.network(
//                                   loanDetail.documents[index].url,
//                                   width:
//                                       300, // Set the width of the image as per your requirement
//                                   height:
//                                       50, // Set the height of the image as per your requirement
//                                   fit: BoxFit
//                                       .cover, // Adjust this based on your image requirements
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       width: 300,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: AppColors.neutral),
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: AppColors.neutral,
//                                       ),
//                                       child: Center(
//                                         child: Text('Image Not Found'),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             )
//                           : loanDetail.documents[index].contentType
//                                   .contains('pdf')
//                               ? GestureDetector(
//                                   onTap: () {
//                                     String pdfUrl =
//                                         loanDetail.documents[index].url;
//                                     js.context.callMethod('open', [pdfUrl]);
//                                   },
//                                   child: Container(
//                                     width: 300,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: AppColors.neutral),
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: AppColors.neutral,
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 20,
//                                         ),
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           color: Colors.red,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   width: 300,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: AppColors.neutral),
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: AppColors.neutral,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Icon(
//                                         Icons.enhanced_encryption,
//                                         color: Colors.red,
//                                       ),
//                                       CustomText(text: 'Unreadable Format')
//                                     ],
//                                   ),
//                                 ),

//                       SizedBox(
//                           height: 8.0), // Add spacing between image and text

//                       // Display file name with overflow handling
//                       Flexible(
//                         child: Text(
//                           'Document  ${index + 1}',

//                           // Adjust the maximum lines based on your UI requirements
//                           style: GoogleFonts.dmSans(
//                             color: AppColors.neutral,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container orderDocumnets(List<Document> orderdocuments, String titles) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             text: titles,
//             fontWeight: FontWeight.w700,
//             fontSize: 15,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Wrap(
//             children: List.generate(
//               orderdocuments.length,
//               (index) {
//                 return Container(
//                   margin: EdgeInsets.all(10),
//                   width: 300,
//                   height: 90,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display Image for image files
//                       isImage(orderdocuments[index].contentType)
//                           ? GestureDetector(
//                               onTap: () {
//                                 String imageUrl = orderdocuments[index].url;
//                                 js.context.callMethod('open', [imageUrl]);
//                               },
//                               child: Container(
//                                 width: 300,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: AppColors.mainbackground),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: AppColors.neutral,
//                                 ),
//                                 child: Image.network(
//                                   orderdocuments[index].url,
//                                   width:
//                                       300, // Set the width of the image as per your requirement
//                                   height:
//                                       50, // Set the height of the image as per your requirement
//                                   fit: BoxFit
//                                       .cover, // Adjust this based on your image requirements
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       width: 300,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: AppColors.neutral),
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: AppColors.neutral,
//                                       ),
//                                       child: Center(
//                                         child: Text('Image Not Found'),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             )
//                           : orderdocuments[index].contentType.contains('pdf')
//                               ? GestureDetector(
//                                   onTap: () {
//                                     String pdfUrl = orderdocuments[index].url;
//                                     js.context.callMethod('open', [pdfUrl]);
//                                   },
//                                   child: Container(
//                                     width: 300,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       border:
//                                           Border.all(color: AppColors.neutral),
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: AppColors.neutral,
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 20,
//                                         ),
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           color: Colors.red,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   width: 300,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: AppColors.neutral),
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: AppColors.neutral,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Icon(
//                                         Icons.enhanced_encryption,
//                                         color: Colors.red,
//                                       ),
//                                       CustomText(text: 'Unreadable Format')
//                                     ],
//                                   ),
//                                 ),

//                       SizedBox(
//                           height: 8.0), // Add spacing between image and text

//                       // Display file name with overflow handling
//                       Flexible(
//                         child: Text(
//                           'Document  ${index + 1}',

//                           // Adjust the maximum lines based on your UI requirements
//                           style: GoogleFonts.dmSans(
//                             color: AppColors.neutral,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container applicantDetails(int applicantkey, int i) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomText(
//                 text: 'Applicant ${i + 1}',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 15,
//               ),
//               if (loanDetail.applicants[applicantkey].exisitngstatus == 'new')
//                 CustomText(
//                   text: 'New Customer',
//                   color: Colors.green,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                 ),
//               if (loanDetail.applicants[applicantkey].exisitngstatus ==
//                   'existing')
//                 CustomText(
//                   text: 'Other requests that are not rejected',
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                   color: Colors.orange,
//                 ),
//               if (loanDetail.applicants[applicantkey].exisitngstatus ==
//                   'rejected')
//                 CustomText(
//                   text: 'Has requests that are rejected',
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                   color: Colors.red,
//                 ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text: 'Surname: ${loanDetail.applicants[applicantkey].surname}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Middle Name: ${loanDetail.applicants[applicantkey].middleName}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'First Name: First Name ${loanDetail.applicants[applicantkey].firstName}',
//               )
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text: 'Gender: ${loanDetail.applicants[applicantkey].gender}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Date of Birth: ${loanDetail.applicants[applicantkey].dob}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'NRC Number: ${loanDetail.applicants[applicantkey].nrc}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Telephone: ${loanDetail.applicants[applicantkey].telephone}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'Mobile: ${loanDetail.applicants[applicantkey].mobile}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'Email: ${loanDetail.applicants[applicantkey].email}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Driving Licnese Number: ${loanDetail.applicants[applicantkey].licenseNumber}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Licnese Exp Date: ${loanDetail.applicants[applicantkey].licenseExpiry}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Resedential Address: ${loanDetail.applicants[applicantkey].residentialAddress}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Ownership:  ${loanDetail.applicants[applicantkey].residentialAddress}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'How long this place:  ${loanDetail.applicants[applicantkey].residentialAddress}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Postal Address:  ${loanDetail.applicants[applicantkey].postalAddress}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'Town:  ${loanDetail.applicants[applicantkey].town}',
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'Province:  ${loanDetail.applicants[applicantkey].province}',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   bool isImage(String contentType) {
//     return contentType.contains('jpeg') ||
//         contentType.contains('jpg') ||
//         contentType.contains('webp') ||
//         contentType.contains('png');
//   }

//   Container employmentDetals(int applicantkey, int i) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomText(
//               fontSize: 15,
//               text: 'Employment Details Applicant: ${i + 1}',
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Job Title: ${loanDetail.applicants[applicantkey].occupation.jobTitle}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Ministry: ${loanDetail.applicants[applicantkey].occupation.ministry}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Physical Address: ${loanDetail.applicants[applicantkey].occupation.physicalAddress}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Postal Address: ${loanDetail.applicants[applicantkey].occupation.postalAddress}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Town: ${loanDetail.applicants[applicantkey].occupation.town}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Province: ${loanDetail.applicants[applicantkey].occupation.province}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Gross Salary: ${loanDetail.applicants[applicantkey].occupation.grossSalary}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Current Net Salary: ${loanDetail.applicants[applicantkey].occupation.netSalary}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Salary Scale: ${loanDetail.applicants[applicantkey].occupation.salaryScale}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Preferred Year of Retirement: ${loanDetail.applicants[applicantkey].occupation.preferredRetirementYear}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Employee Number: ${loanDetail.applicants[applicantkey].occupation.employerNumber}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Years in Employemnt: ${loanDetail.applicants[applicantkey].occupation.yearsOfService}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Employemnt Type: ${loanDetail.applicants[applicantkey].occupation.employmentType}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Expiry Date: ${loanDetail.applicants[applicantkey].occupation.tempExpiryDate}',
//                 ),
//               ],
//             ),
//           ]),
//     );
//   }

//   Container employmentKinDetals(int applicantkey, int i) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomText(
//               fontSize: 15,
//               text: 'Kin Details Applicant: ${i + 1}',
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text: 'Name: ${loanDetail.applicants[applicantkey].kin.name}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Other Name: ${loanDetail.applicants[applicantkey].kin.otherNames}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Physical Address: ${loanDetail.applicants[applicantkey].kin.physicalAddress}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Postal Address: ${loanDetail.applicants[applicantkey].kin.postalAddress}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Phone: ${loanDetail.applicants[applicantkey].kin.phoneNumber}',
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Email: ${loanDetail.applicants[applicantkey].kin.email}',
//                 ),
//               ],
//             ),
//           ]),
//     );
//   }

//   String formatDateString(String dateString) {
//     try {
//       DateTime dateTime = DateTime.parse(dateString);
//       return DateFormat('dd MMMM yyyy').format(dateTime);
//     } catch (e) {
//       // Handle parsing errors, e.g., if the input string is not a valid date
//       print('Error formatting date: $e');
//       return 'Invalid Date';
//     }
//   }

//   Container loanDetails() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//             fontSize: 15,
//             text: 'Loan Product Applied',
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           for (int i = 0; i < loanDetail.requestedProducts.length; i++)
//             CustomText(
//               fontSize: 15,
//               text:
//                   '${loanDetail.requestedProducts[i].productName}(${loanDetail.requestedProducts[i].quantity})',
//             ),
//           SizedBox(
//             height: 40,
//           ),
//           CustomText(
//             fontSize: 15,
//             text: 'Description: ${loanDetail.description}',
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text: 'Total cost of asset: ${loanDetail.costOfAsset}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'Total Insurance Cost: ${loanDetail.insuranceCost}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'Less Advance Payment: ${loanDetail.advancePayment}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text: 'Loan Amount Applied for: ${loanDetail.loanAmount}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text: 'Tenure: ${loanDetail.loanTenure}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'First Applicant: ${loanDetail.applicants[0].loansharename}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 fontSize: 15,
//                 text:
//                     'First Applicant Loan Propotion: ${loanDetail.applicants[0].loansharepercent}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               if (loanDetail.applicantCount > 1)
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Second Applicant: ${loanDetail.applicants[1].loansharename}',
//                 ),
//               SizedBox(
//                 width: 30,
//               ),
//               if (loanDetail.applicantCount > 1)
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Second Applicant Loan Propotion: ${loanDetail.applicants[1].loansharepercent}',
//                 ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Wrap(
//             children: [
//               if (loanDetail.applicantCount > 2)
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Third Applicant: ${loanDetail.applicants[2].loansharename}',
//                 ),
//               SizedBox(
//                 width: 30,
//               ),
//               if (loanDetail.applicantCount > 2)
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Third Applicant Loan Propotion: ${loanDetail.applicants[2].loansharepercent}',
//                 ),
//               SizedBox(
//                 width: 30,
//               ),
//               if (loanDetail.applicantCount > 3)
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Fourth Applicant: ${loanDetail.applicants[3].loansharename}',
//                 ),
//               SizedBox(
//                 width: 30,
//               ),
//               if (loanDetail.applicantCount > 3)
//                 CustomText(
//                   fontSize: 15,
//                   text:
//                       'Fourth Applicant Loan Propotion: ${loanDetail.applicants[3].loansharepercent}',
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Container bankdetails() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 30),
//       padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
//       decoration: BoxDecoration(
//           color: AppColors.sidebarbackground,
//           borderRadius: BorderRadius.circular(20)),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Wrap(
//               children: [
//                 CustomText(
//                   fontSize: 15,
//                   text: 'Bank Name: Name of bank',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text: 'Branch Name: Name of Branch',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   fontSize: 15,
//                   text: 'Sort code: Sort code',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             CustomText(
//               fontSize: 15,
//               text: 'Branch Acc No: Acc No',
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             CustomText(
//               fontSize: 15,
//               text: 'Name and Full Address: Name and address',
//             ),
//           ]),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     getroles();
//     // Fetch and load the loan request details when the page is opened
//     fetchLoanRequestDetails(widget.loanRequestId);
//   }

//   void getroles() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       role = prefs.getString('role');
//     });
//   }

//   Future<void> fetchLoanRequestDetails(int loanRequestId) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isloadiing = true;
//       token = prefs.getString('token');
//       email = prefs.getString('email');
//     });
//     try {
//       Dio dio = Dio();

//       // Replace 'YOUR_BEARER_TOKEN' with the actual Bearer token
//       String bearerToken = token!;

//       final response = await dio.get(
//         'https://loan-managment.onrender.com/loan_requests/$loanRequestId',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $bearerToken',
//             // Add any other headers if needed
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           loanDetail = LoanRequestDetails.fromJson(response.data);

//           isloadiing = false;
//         });

//         // print(loanDetail.applicantCount);
//       } else {
//         // Handle error
//         print(
//             'Error fetching loan request details. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       // Handle Dio errors or network errors
//       print('Dio error: $error');
//     }
//   }

//   Future<void> _addFiles(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         // Use the AlertDialog widget for the popup
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             backgroundColor: AppColors.mainbackground,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomText(
//                   text: 'Upload Attatchments',
//                   fontSize: 20,
//                   color: AppColors.neutral,
//                 ),
//                 TextButton.icon(
//                   onPressed: () async {
//                     FilePickerResult? result =
//                         await FilePicker.platform.pickFiles(
//                       allowMultiple: false,
//                       type: FileType.custom,
//                       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
//                     );

//                     if (result != null) {
//                       if (result.files.first.size > 1024 * 1024) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('The file size exceeds limit'),
//                           ),
//                         );
//                       } else {
//                         setState(() {
//                           selectedFiles
//                               .addAll(result.files.map((file) => file.bytes!));
//                           selectedFilesnames
//                               .addAll(result.files.map((file) => file.name));
//                         });
//                       }
//                       print(selectedFiles);
//                     }
//                   },
//                   icon: Icon(
//                     Icons.add,
//                     color: AppColors.mainColor,
//                   ),
//                   label: CustomText(
//                     text: 'Add Files',
//                     color: AppColors.neutral,
//                   ),
//                 )
//               ],
//             ),
//             content: SingleChildScrollView(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * .5,
//                 height: MediaQuery.of(context).size.height * .7,
//                 child: selectedFiles.isNotEmpty
//                     ? Container(
//                         width: MediaQuery.of(context).size.width * .7,
//                         height: 120,
//                         child: Wrap(
//                           children: List.generate(
//                             selectedFiles.length,
//                             (index) {
//                               var fileBytes = selectedFiles[index];
//                               var fileName = selectedFilesnames[index];
//                               String fileExtension =
//                                   fileName.split('.').last.toLowerCase();

//                               return Container(
//                                 margin: EdgeInsets.all(10),
//                                 width: 300,
//                                 height: 80,
//                                 child: Stack(
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Display Image for image files

//                                         (fileExtension != 'pdf')
//                                             ? GestureDetector(
//                                                 onTap: () {
//                                                   // Open image in a new tab
//                                                   final blob = html.Blob(
//                                                       [fileBytes], 'image/*');
//                                                   final url = html.Url
//                                                       .createObjectUrlFromBlob(
//                                                           blob);
//                                                   html.window
//                                                       .open(url, '_blank');
//                                                 },
//                                                 child: Container(
//                                                   width: 300,
//                                                   height: 50,
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color:
//                                                             AppColors.neutral),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                     color: AppColors.neutral,
//                                                   ),
//                                                   child: Image.memory(
//                                                     fileBytes,
//                                                     width:
//                                                         300, // Set the width of the image as per your requirement
//                                                     height:
//                                                         50, // Set the height of the image as per your requirement
//                                                     fit: BoxFit
//                                                         .cover, // Adjust this based on your image requirements
//                                                   ),
//                                                 ),
//                                               )
//                                             : GestureDetector(
//                                                 onTap: () {
//                                                   // Open PDF in a new tab
//                                                   final blob = html.Blob([
//                                                     Uint8List.fromList(
//                                                         fileBytes)
//                                                   ], 'application/pdf');
//                                                   final url = html.Url
//                                                       .createObjectUrlFromBlob(
//                                                           blob);
//                                                   html.window
//                                                       .open(url, '_blank');
//                                                 },
//                                                 child: Container(
//                                                   width: 300,
//                                                   height: 50,
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: AppColors
//                                                             .mainColor),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                     color: AppColors.neutral,
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: 20,
//                                                       ),
//                                                       Icon(
//                                                         Icons.picture_as_pdf,
//                                                         color: Colors.red,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                         SizedBox(
//                                             height:
//                                                 8.0), // Add spacing between image and text

//                                         // Display file name with overflow handling
//                                         Flexible(
//                                           child: Text(
//                                             fileName,
//                                             overflow: TextOverflow.ellipsis,
//                                             // Adjust the maximum lines based on your UI requirements
//                                             style: GoogleFonts.dmSans(
//                                               fontSize: 14,
//                                               color: AppColors.neutral,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Positioned(
//                                       top: 12,
//                                       right: 5,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // Handle the close icon tap
//                                           setState(() {
//                                             selectedFiles.removeAt(index);
//                                             selectedFilesnames.removeAt(index);
//                                           });
//                                         },
//                                         child: CircleAvatar(
//                                           radius: 12,
//                                           backgroundColor: AppColors.mainColor,
//                                           child: Icon(
//                                             Icons.close,
//                                             size: 15,
//                                             color: AppColors.neutral,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ))
//                     : SizedBox(),
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                               AppColors.mainbackground),
//                           padding: MaterialStateProperty.all(
//                               EdgeInsets.fromLTRB(15, 5, 15, 5))),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: CustomText(
//                         text: 'Close',
//                         color: AppColors.neutral,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       )),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(AppColors.mainColor),
//                           padding: MaterialStateProperty.all(
//                               EdgeInsets.fromLTRB(15, 5, 15, 5))),
//                       onPressed: () {
//                         updateData();
//                         Navigator.pop(context);
//                       },
//                       child: CustomText(
//                         text: 'Upload',
//                         color: AppColors.neutral,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ))
//                 ],
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }

//   Future<void> _showPopup(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // Use the AlertDialog widget for the popup
//         return AlertDialog(
//           backgroundColor: AppColors.mainbackground,
//           title: CustomText(
//             text: 'Loan Application Tracking',
//             color: AppColors.neutral,
//           ),
//           content: SingleChildScrollView(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * .5,
//               height: MediaQuery.of(context).size.height * .7,
//               child: Timeline(
//                 indicators: List<Widget>.generate(4, (index) {
//                   return Icon(
//                     Icons.circle,
//                     color: AppColors.mainColor,
//                     size: 12,
//                   );
//                 }),
//                 children: <Widget>[
//                   timelinecontent(
//                     'Agent Status',
//                     'Assigned Agent: ${loanDetail.agent.name}',
//                     'Assigned Date: ${loanDetail.assignedAt}',
//                     '',
//                   ),
//                   timelinecontent(
//                       'Netone',
//                       'Netone Status: ${loanDetail.requestSystemStatus}',
//                       'Last Update: ${loanDetail.requestSystemUpdateDate}',
//                       loanDetail.systemRejectionReason != ''
//                           ? 'Rejection Reason: ${loanDetail.systemRejectionReason}'
//                           : ''),
//                   timelinecontent(
//                       'Bank ',
//                       'Bank Status: ${loanDetail.requestBankStatus}',
//                       'Last Update: ${loanDetail.requestBankUpdateDate}',
//                       loanDetail.bankRejectionReason != ''
//                           ? 'Rejection Reason: ${loanDetail.bankRejectionReason}'
//                           : ''),
//                   timelinecontent(
//                       'Order',
//                       'Order Status: ${loanDetail.requestOrderStatus}',
//                       'Last Update: ${loanDetail.requestOrderUpdateDate}',
//                       ''),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(AppColors.mainColor),
//                     padding: MaterialStateProperty.all(EdgeInsets.all(15))),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: CustomText(
//                   text: 'Close',
//                   color: AppColors.neutral,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 )),
//           ],
//         );
//       },
//     );
//   }

//   Container timelinecontent(
//       String title, String oneone, String onetwo, String twoone) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(
//               text: title,
//               fontSize: 15,
//               color: AppColors.neutral,
//               fontWeight: FontWeight.w500),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomText(
//                   text: oneone,
//                   fontSize: 13,
//                   color: AppColors.neutral,
//                   fontWeight: FontWeight.w300),
//               CustomText(
//                   text: onetwo,
//                   fontSize: 13,
//                   color: AppColors.neutral,
//                   fontWeight: FontWeight.w300)
//             ],
//           ),
//           if (twoone != '')
//             SizedBox(
//               height: 10,
//             ),
//           if (twoone != '')
//             CustomText(
//                 text: twoone,
//                 fontSize: 13,
//                 color: AppColors.neutral,
//                 fontWeight: FontWeight.w300),
//         ],
//       ),
//     );
//   }

//   Future<void> updateData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isloadiing = true;
//       token = prefs.getString('token');
//       email = prefs.getString('email');
//       role = prefs.getString('role');
//     });
//     final String apiUrl =
//         'https://loan-managment.onrender.com/loan_requests/${widget.loanRequestId}';

//     try {
//       var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
//       String accessToken = token!;
//       request.headers['Authorization'] = 'Bearer $accessToken';

//       if (selectedFiles.isNotEmpty) {
//         for (var file in selectedFiles) {
//           request.files.add(http.MultipartFile(
//             'loan_request[documents][]',
//             http.ByteStream.fromBytes(file),
//             file.length,
//             filename: 'file.jpg', // Provide a filename here
//             contentType: MediaType('application', 'octet-stream'),
//           ));
//         }
//       }

//       var response = await request.send();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Request was successful
//         print('Files Submitted successfully');
//         setState(() {
//           isloadiing = false;
//         });
//         warning('Files Submitted');
//         fetchLoanRequestDetails(widget.loanRequestId);
//         //  clearAllFields();
//       } else {
//         // Request failed
//         print('Form submission failed with status: ${response.statusCode}');
//         setState(() {
//           isloadiing = false;
//         });
//         warning('Error: Cannot Add Files');
//       }
//     } catch (e) {
//       print("Error: $e");
//       warning('Error');
//     }
//   }

//   warning(String message) {
//     return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         width: MediaQuery.of(context).size.width * .7,
//         backgroundColor: AppColors.neutral,
//         duration: Duration(seconds: 3),
//         shape: StadiumBorder(),
//         behavior: SnackBarBehavior.floating,
//         content: Center(
//           child: CustomText(
//               text: message,
//               fontSize: 13,
//               color: AppColors.mainColor,
//               fontWeight: FontWeight.w500),
//         )));
//   }
// }
