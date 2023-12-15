// // ignore_for_file: prefer_const_constructors

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:netone_loanmanagement_admin/src/application/datas/applicant.dart';
// import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
// import 'package:netone_loanmanagement_admin/src/res/colors.dart';
// import 'package:netone_loanmanagement_admin/src/res/styles.dart';
// import 'package:provider/provider.dart';

// class SectionFour extends StatefulWidget {
//   final MyTabController myTabController;
//   late TabController _tabController;

//   SectionFour(this.myTabController, this._tabController);

//   @override
//   State<SectionFour> createState() => _SectionFourState();
// }

// class _SectionFourState extends State<SectionFour>
//     with SingleTickerProviderStateMixin {
//   late TabController _controller;
//   List<PlatformFile>? selectedFiles;
//   @override
//   void initState() {
//     super.initState();
//     _controller = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     widget.myTabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final myTabController = Provider.of<MyTabController>(context);
//     final numberOfPersons = widget.myTabController.numberOfPersons;
//     List<ApplicantDetails> applicants = myTabController.applicants;
//     return Scaffold(
//       backgroundColor: AppColors.mainbackground,
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: ListView(
//           children: [
//             CustomText(
//               text: 'Part 1 ',
//               color: AppColors.neutral,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             CustomText(
//               text: 'Applicant Details',
//               color: AppColors.neutral,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             applicantDetails(myTabController, 0),
//             if (numberOfPersons > 1) applicantDetails(myTabController, 1),
//             if (numberOfPersons > 2) applicantDetails(myTabController, 2),
//             if (numberOfPersons > 3) applicantDetails(myTabController, 3),

//             // Display other details as needed

//             // Display details from Section Two
//             CustomText(
//               text: 'Part 2',
//               color: AppColors.neutral,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             CustomText(
//               text: 'Employment Details',
//               color: AppColors.neutral,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             employmentDetals(myTabController, 0),
//             if (numberOfPersons > 1) employmentDetals(myTabController, 1),
//             if (numberOfPersons > 2) employmentDetals(myTabController, 2),
//             if (numberOfPersons > 3) employmentDetals(myTabController, 3),
//             CustomText(
//               text: 'Part 3',
//               color: AppColors.neutral,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             CustomText(
//               text: 'Loan Details',
//               color: AppColors.neutral,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             loanDetails(myTabController),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   pickFiles();
//                 },
//                 child: Text('Pick file')),
//             ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(AppColors.mainColor),
//                     padding: MaterialStateProperty.all(EdgeInsets.all(15))),
//                 onPressed: () {
//                   uploadFiles();
//                 },
//                 child: CustomText(
//                   text: 'Submit',
//                   color: AppColors.neutral,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

//   Container applicantDetails(MyTabController myTabController, int i) {
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
//             text: 'Applicant ${i + 1}',
//             fontWeight: FontWeight.w700,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Surname: ${myTabController.applicants[i].surnameController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Middle Name: ${myTabController.applicants[i].middleNameController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'First Name: ${myTabController.applicants[i].firstNameController.text}',
//               )
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text: myTabController.applicants[i].gender == null
//                     ? 'Gender:'
//                     : 'Gender: ${myTabController.applicants[i].gender}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Date of Birth: ${myTabController.applicants[i].dobController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'NRC Number: ${myTabController.applicants[i].nrcController.text}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Telephone: ${myTabController.applicants[i].telephoneController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Mobile: ${myTabController.applicants[i].mobileController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Email: ${myTabController.applicants[i].emailController.text}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Driving Licnese Number: ${myTabController.applicants[i].licenseNumberController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Licnese Exp Date: ${myTabController.applicants[i].licenseExpiryController.text}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Resedential Address: ${myTabController.applicants[i].residentialAddressController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text: myTabController.applicants[i].ownership == null
//                     ? 'Ownership:'
//                     : 'Ownership: ${myTabController.applicants[i].ownership}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'How long this place: ${myTabController.applicants[i].howlongthisplaceController.text}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Postal Address: ${myTabController.applicants[i].postalAddressController.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text: myTabController.applicants[i].townController == null
//                     ? 'Town:'
//                     : 'Town: ${myTabController.applicants[i].townController}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text: myTabController.applicants[i].provinceController == null
//                     ? 'Province'
//                     : 'Province: ${myTabController.applicants[i].provinceController}',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Container employmentDetals(MyTabController myTabController, int i) {
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
//               text: 'Employment Details Applicant: ${i + 1}',
//               fontWeight: FontWeight.w700,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   text:
//                       'Job Title: ${myTabController.employmentDetailsList[i].jobTitleController.text}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text:
//                       'Ministry: ${myTabController.employmentDetailsList[i].ministryController.text}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   text:
//                       'Physical Address: ${myTabController.employmentDetailsList[i].physicalAddressControlleremployment.text}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text:
//                       'Postal Address: ${myTabController.employmentDetailsList[i].postalAddressControllerEmployment.text}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   text: myTabController
//                               .employmentDetailsList[i].townController ==
//                           null
//                       ? 'Town:'
//                       : 'Town: ${myTabController.employmentDetailsList[i].townController}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text: myTabController
//                               .employmentDetailsList[i].provinceController ==
//                           null
//                       ? 'Province:'
//                       : 'Province: ${myTabController.employmentDetailsList[i].provinceController}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   text:
//                       'Gross Salary: ${myTabController.employmentDetailsList[i].grossSalaryController.text}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text: myTabController.employmentDetailsList[i]
//                               .currentNetSalaryController.text ==
//                           null
//                       ? 'Current Net Salary:'
//                       : 'Current Net Salary: ${myTabController.employmentDetailsList[i].currentNetSalaryController.text}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text: myTabController
//                               .employmentDetailsList[i].salaryScaleController ==
//                           null
//                       ? 'Salary Scale:'
//                       : 'Salary Scale: ${myTabController.employmentDetailsList[i].salaryScaleController}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   text: myTabController.employmentDetailsList[i]
//                               .preferredYearOfRetirementController ==
//                           null
//                       ? 'Preferred Year of Retirement'
//                       : 'Preferred Year of Retirement: ${myTabController.employmentDetailsList[i].preferredYearOfRetirementController}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text:
//                       'Employee Number: ${myTabController.employmentDetailsList[i].employeeNumberController.text}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomText(
//                   text: myTabController.employmentDetailsList[i]
//                               .yearsInEmploymentController ==
//                           null
//                       ? 'Years in Employemnt'
//                       : 'Years in Employemnt: ${myTabController.employmentDetailsList[i].yearsInEmploymentController}',
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Wrap(
//               children: [
//                 CustomText(
//                   text:
//                       'Employemnt Type: ${myTabController.employmentDetailsList[i].employmentType}',
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 if (myTabController.employmentDetailsList[i].employmentType ==
//                     'Temporary')
//                   CustomText(
//                     text:
//                         'Expiry Date: ${myTabController.employmentDetailsList[i].expiryDateController.text}',
//                   ),
//               ],
//             ),
//           ]),
//     );
//   }

//   Container loanDetails(MyTabController myTabController) {
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
//             text: myTabController.loanDetails.selectedLoanOption == null
//                 ? 'Loan Product Applied for:'
//                 : 'Loan Product Applied for: ${myTabController.loanDetails.selectedLoanOption}',
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           CustomText(
//             text:
//                 'Description: ${myTabController.loanDetails.descriptionController.text}',
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Total cost of asset: ${myTabController.loanDetails.costofasset.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Total Insurance Cost: ${myTabController.loanDetails.insurancecost.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Less Advance Payment: ${myTabController.loanDetails.advancepayment.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Loan Amount Applied for: ${myTabController.loanDetails.loanamaountapplied.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text: myTabController.loanDetails.tenure == null
//                     ? 'Tenure:'
//                     : 'Tenure: ${myTabController.loanDetails.tenure}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'First Applicant: ${myTabController.loanDetails.firstapplicant.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'First Applicant Loan Propotion: ${myTabController.loanDetails.firstapplicantproportion.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Second Applicant: ${myTabController.loanDetails.secondapplicant.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Second Applicant Loan Propotion: ${myTabController.loanDetails.secondapplicantpropotion.text}',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Wrap(
//             children: [
//               CustomText(
//                 text:
//                     'Third Applicant: ${myTabController.loanDetails.thirdapplicant.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Third Applicant Loan Propotion: ${myTabController.loanDetails.thirdapplicant.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Fourth Applicant: ${myTabController.loanDetails.fourthapplicant.text}',
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               CustomText(
//                 text:
//                     'Fourth Applicant Loan Propotion: ${myTabController.loanDetails.fourthapplicantpropotion.text}',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         selectedFiles = result.files;
//       });
//     }
//   }

//   Future<void> uploadFiles() async {
//     if (selectedFiles == null || selectedFiles!.isEmpty) {
//       // No files selected
//       return;
//     }

//     Dio dio = Dio();
//     String bearerToken =
//         'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzMjY3NDQ4fQ.l7Hd1TdjcUTHdUmpRYhHVQQzVaDMb17dTNb566XlF3E';
//     dio.options.headers['Authorization'] = 'Bearer $bearerToken';

//     List<MultipartFile> files = [];

//     for (PlatformFile file in selectedFiles!) {
//       List<int> bytes = file.bytes!; // Get file bytes

//       files.add(MultipartFile.fromBytes(
//         bytes,
//         filename: file.name,
//       ));
//     }

//     FormData formData = FormData();

//     // Assign the documents list to formData
//     formData.files.addAll(
//         files.map((file) => MapEntry('loan_request[documents][]', file)));

//     try {
//       Response response = await dio.patch(
//         'https://loan-managment.onrender.com/loan_requests/19', // Replace with your API endpoint
//         data: formData,
//       );

//       // Handle the response as needed
//       print('Response: ${response.statusCode}');
//       print('Body: ${response.data}');
//     } catch (e) {
//       print('Error uploading files: $e');
//     }
//   }
// }
