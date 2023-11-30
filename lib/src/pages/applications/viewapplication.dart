// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/dashboard.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class ViewApplication extends StatefulWidget {
  @override
  State<ViewApplication> createState() => _ViewApplicationState();
}

class _ViewApplicationState extends State<ViewApplication> {
  List<String> currentstatusList = ['Approve', 'Reject'];
  String selectedstatus = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        borderSide:
                            BorderSide(color: AppColors.neutral, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.neutral, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                      padding: MaterialStateProperty.all(EdgeInsets.all(15))),
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
            applicantDetails(0),

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
            employmentDetals(0),

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
    );
  }

  Container applicantDetails(int i) {
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
                text: 'Surname: Surname',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Middle Name: Middle Name',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'First Name: First Name',
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
                text: 'Gender: Male',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Date of Birth: 19 November 2023',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'NRC Number: E123435',
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
                text: 'Telephone: +91 8766 2324 23',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Mobile: +91 8766 2324 23',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Email: +91 8766 2324 23',
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
                text: 'Driving Licnese Number: +91 8766 2324 23',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Licnese Exp Date: +91 8766 2324 23',
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
                text: 'Resedential Address: Resedential Address',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Ownership: Ownership',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'How long this place: 18 Months',
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
                text: 'Postal Address: Postal Address',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Town: Town Here',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Province: Province Here',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Container employmentDetals(int i) {
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
                text: 'Job Title: Job Title Here',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Ministry: Ministry',
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
                text: 'Physical Address: Physcial Address',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Postal Address: Postal Address',
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
                text: 'Town: Town',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Province: Province',
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
                text: 'Gross Salary: Gross Salary',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Current Net Salary: Current Net Salary',
              ),
              CustomText(
                fontSize: 15,
                text: 'Salary Scale: Salary Scale',
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
                text: 'Preferred Year of Retirement: 2019',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Employee Number: Employee Number',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Years in Employemnt: 12 Years',
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
                text: 'Employemnt Type: Employment',
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                fontSize: 15,
                text: 'Expiry Date: For Temp Exp Date',
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
          text: 'Loan Product Applied for: Mobile Phone',
        ),
        SizedBox(
          height: 40,
        ),
        CustomText(
          fontSize: 15,
          text: 'Description: Description',
        ),
        SizedBox(
          height: 40,
        ),
        Wrap(
          children: [
            CustomText(
              fontSize: 15,
              text: 'Total cost of asset: Total Cost of ',
            ),
            SizedBox(
              width: 30,
            ),
            CustomText(
              fontSize: 15,
              text: 'Total Insurance Cost: Insurance Cost',
            ),
            SizedBox(
              width: 30,
            ),
            CustomText(
              fontSize: 15,
              text: 'Less Advance Payment: Less Advance Payemnt',
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
              text: 'Loan Amount Applied for: Loan Amount Applied ',
            ),
            SizedBox(
              width: 30,
            ),
            CustomText(
              fontSize: 15,
              text: 'Tenure: Tenure',
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
              text: 'First Applicant: Name Here',
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
