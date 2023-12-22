// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/dashboard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/timeline.dart';
import 'dart:js' as js;

class ViewApplication extends StatefulWidget {
  final int loanRequestId;

  const ViewApplication({required this.loanRequestId});

  @override
  State<ViewApplication> createState() => _ViewApplicationState();
}

class _ViewApplicationState extends State<ViewApplication> {
  late LoanRequestDetails loanDetail;
  List<String> currentstatusList = ['Approve', 'Reject'];
  String selectedstatus = '';
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return isloading == false
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
                    SizedBox(
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
                        )),
                    SizedBox(
                      width: 20,
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
                    IconButton(
                        onPressed: () {},
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
                              text: 'Date: ${formatDate(loanDetail.createdAt)}',
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

                  for (int i = 0; i < loanDetail.applicants.length; i++)
                    applicantDocuments(i, i),
                ],
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
            text: 'Loan Product Applied for: ${loanDetail.product.name}',
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

  @override
  void initState() {
    super.initState();
    // Fetch and load the loan request details when the page is opened
    fetchLoanRequestDetails(widget.loanRequestId);
  }

  Future<void> fetchLoanRequestDetails(int loanRequestId) async {
    try {
      Dio dio = Dio();

      // Replace 'YOUR_BEARER_TOKEN' with the actual Bearer token
      String bearerToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzODcyMzMwfQ.iPcNkG8k85wfMowp1cleF4VmzcdP-ftuBHhZbliDcik';

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

          isloading = false;
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
}
