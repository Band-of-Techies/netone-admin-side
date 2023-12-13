// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/dashboard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

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
  List<String>? applicantKeys;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditApplication()),
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: AppColors.neutral,
                        )),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Form ID: NR 20231157',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            text: 'Customer Name',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Current Status: Bank Approval',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            text: 'Assigned to: Agent Name',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Date: 12 Auguest 2023',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            text: 'Time: 05:49PM',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
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
                  for (int i = 0; i < applicantKeys!.length; i++)
                    applicantDetails(applicantKeys![i], i),

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
                  for (int i = 0; i < applicantKeys!.length; i++)
                    employmentDetals(applicantKeys![i], i),

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

  Container applicantDetails(String applicantkey, int i) {
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
            text: 'Applicant ${i + 1}',
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: [
              CustomText(
                fontSize: 15,
                text:
                    'Surname: ${loanDetail.applicants[applicantkey]!.surname}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Middle Name: ${loanDetail.applicants[applicantkey]!.middleName}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'First Name: First Name ${loanDetail.applicants[applicantkey]!.firstName}',
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
                text:
                    'Gender: ${loanDetail.applicants[applicantkey]!.residentialAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Date of Birth: ${loanDetail.applicants[applicantkey]!.dob}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'NRC Number: ${loanDetail.applicants[applicantkey]!.nrc}',
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
                    'Telephone: ${loanDetail.applicants[applicantkey]!.telephone}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Mobile: ${loanDetail.applicants[applicantkey]!.mobile}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Email: ${loanDetail.applicants[applicantkey]!.email}',
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
                    'Driving Licnese Number: ${loanDetail.applicants[applicantkey]!.licenseNumber}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Licnese Exp Date: ${loanDetail.applicants[applicantkey]!.licenseExpiry}',
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
                    'Resedential Address: ${loanDetail.applicants[applicantkey]!.residentialAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Ownership:  ${loanDetail.applicants[applicantkey]!.residentialAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'How long this place:  ${loanDetail.applicants[applicantkey]!.residentialAddress}',
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
                    'Postal Address:  ${loanDetail.applicants[applicantkey]!.postalAddress}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Town:  ${loanDetail.applicants[applicantkey]!.town}',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text:
                    'Province:  ${loanDetail.applicants[applicantkey]!.province}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container employmentDetals(String applicantkey, int i) {
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
                      'Job Title: ${loanDetail.applicants[applicantkey]!.occupation.jobTitle}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Ministry: ${loanDetail.applicants[applicantkey]!.occupation.ministry}',
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
                      'Physical Address: ${loanDetail.applicants[applicantkey]!.occupation.physicalAddress}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Postal Address: ${loanDetail.applicants[applicantkey]!.occupation.postalAddress}',
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
                      'Town: ${loanDetail.applicants[applicantkey]!.occupation.town}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Province: ${loanDetail.applicants[applicantkey]!.occupation.province}',
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
                      'Gross Salary: ${loanDetail.applicants[applicantkey]!.occupation.grossSalary}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Current Net Salary: ${loanDetail.applicants[applicantkey]!.occupation.netSalary}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Salary Scale: ${loanDetail.applicants[applicantkey]!.occupation.salaryScale}',
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
                      'Preferred Year of Retirement: ${loanDetail.applicants[applicantkey]!.occupation.preferredRetirementYear}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Employee Number: ${loanDetail.applicants[applicantkey]!.occupation.employerNumber}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Years in Employemnt: ${loanDetail.applicants[applicantkey]!.occupation.yearsOfService}',
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
                      'Employemnt Type: ${loanDetail.applicants[applicantkey]!.occupation.employmentType}',
                ),
                SizedBox(
                  width: 50,
                ),
                CustomText(
                  fontSize: 15,
                  text:
                      'Expiry Date: ${loanDetail.applicants[applicantkey]!.occupation.tempExpiryDate}',
                ),
              ],
            ),
          ]),
    );
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
            text: 'Loan Product Applied for: ${loanDetail.product}',
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
                text: 'First Applicant: ',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'First Applicant Loan Propotion: Propotion Here',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Second Applicant: Second Name Here',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Second Applicant Loan Propotion: Loadn ',
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
                text: 'Third Applicant: Third Applicant',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Third Applicant Loan Propotion: Third Loan Propotion',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Fourth Applicant: Fourth Applicant',
              ),
              SizedBox(
                width: 30,
              ),
              CustomText(
                fontSize: 15,
                text: 'Fourth Applicant Loan Propotion: Loan Propotion',
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
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAyNjYwNzk3fQ.aNgcnhSk31oF3CP_72Aiy38hKiNYIuhrNrxcGk6jp7Y';

      final response = await dio.get(
        'https://loan-managment.onrender.com/loan_requests/20',
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
          for (String key in loanDetail.applicants.keys) {
            applicantKeys = loanDetail.applicants.keys.toList();
          }
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
}
