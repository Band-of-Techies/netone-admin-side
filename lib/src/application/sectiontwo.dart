// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicationdetails.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectionTwo extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;
  int? id;
  SectionTwo(this.myTabController, this._tabController, this.id);

  @override
  State<SectionTwo> createState() => _SectionTwoState();
}

class _SectionTwoState extends State<SectionTwo>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late LoanRequestDetails loanDetail;
  bool isloadiing = true;
  List<String> prefyearsList =
      List.generate(61, (index) => (DateTime.now().year + index).toString());
  List<EmployemntandKlinDetails> applicantDetailsLists = [];
  String? selectedLetter;
  String? email;
  String? token;
  List<String> employemnttypelist = ['permanent', 'contract'];
  List<String> letters = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<String> provinces = [
    'Central',
    'Copperbelt',
    'Eastern',
    'Luapula',
    'Lusaka',
    'Northern',
    'Muchinga',
    'North-Western',
    'Southern',
    'Western',
  ];
  Map<String, List<String>> townsByProvince = {
    'Central': [
      'Chibombo District',
      'Chisamba District',
      'Chitambo District',
      'Kabwe District',
      'Kapiri Mposhi District',
      'Luano District',
      'Mkushi District',
      'Mumbwa District',
      'Ngabwe District',
      'Serenje District',
      'Shibuyunji District',
    ],
    'Copperbelt': [
      'Chililabombwe District',
      'Chingola District',
      'Kalulushi District',
      'Kitwe District',
      'Luanshya District',
      'Lufwanyama District',
      'Masaiti District',
      'Mpongwe District',
      'Mufulira District',
      'Ndola District',
    ],
    'Eastern': [
      'Chadiza District',
      'Chama District',
      'Chasefu District',
      'Chipangali District',
      'Chipata District',
      'Kasenengwa District',
      'Katete District',
      'Lumezi District',
      'Lundazi District',
      'Lusangazi District',
      'Mambwe District',
      'Nyimba District',
      'Petauke District',
      'Sinda District',
      'Vubwi District',
    ],
    'Luapula': [
      'Chembe District',
      'Chiengi District',
      'Chifunabuli District',
      'Chipili District',
      'Kawambwa District',
      'Lunga District',
      'Mansa District',
      'Milenge District',
      'Mwansabombwe District',
      'Mwense District',
      'Nchelenge District',
      'Samfya District',
    ],
    'Lusaka': [
      'Chilanga District',
      'Chongwe District',
      'Kafue District',
      'Luangwa District',
      'Lusaka District',
      'Rufunsa District',
    ],
    'Muchinga': [
      'Chinsali District',
      'Isoka District',
      'Mafinga District',
      'Mpika District',
      'Nakonde District',
      'Shiwangandu District',
      'Kanchibiya District',
      'Lavushimanda District',
    ],
    'Northern': [
      'Kasama District',
      'Chilubi District',
      'Kaputa District',
      'Luwingu District',
      'Mbala District',
      'Mporokoso District',
      'Mpulungu District',
      'Mungwi District',
      'Nsama District',
      'Lupososhi District',
      'Lunte District',
      'Senga Hill District',
    ],
    'North-Western': [
      'Chavuma District',
      'Ikelenge District',
      'Kabompo District',
      'Kalumbila District',
      'Kasempa District',
      'Manyinga District',
      'Mufumbwe District',
      'Mushindamo District',
      'Mwinilunga District',
      'Solwezi District',
      'Zambezi District',
    ],
    'Southern': [
      'Chikankata District',
      'Chirundu District',
      'Choma District',
      'Gwembe District',
      'Itezhi-Tezhi District',
      'Kalomo District',
      'Kazungula District',
      'Livingstone District',
      'Mazabuka District',
      'Monze District',
      'Namwala District',
      'Pemba District',
      'Siavonga District',
      'Sinazongwe District',
      'Zimba District',
    ],
    'Western': [
      'Kalabo District',
      'Kaoma District',
      'Limulunga District',
      'Luampa District',
      'Lukulu District',
      'Mitete District',
      'Mongu District',
      'Mulobezi District',
      'Mwandi District',
      'Nalolo District',
      'Nkeyema District',
      'Senanga District',
      'Sesheke District',
      'Shangombo District',
      'Sikongo District',
      'Sioma District',
    ],
  };
  List<String> yearsList = List.generate(50, (index) => (index + 1).toString());
  @override
  Widget build(BuildContext context) {
    final numberOfPersons = widget.myTabController.numberOfPersons;
    final myTabController = Provider.of<MyTabController>(context);
    applicantDetailsLists = myTabController.employmentDetailsList;
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: isloadiing == false
          ? Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: RawScrollbar(
                  thumbVisibility: true,
                  thumbColor: AppColors.mainColor,
                  radius: Radius.circular(20),
                  thickness: 5,
                  child: ListView(
                    children: [
                      CustomText(
                        text: 'Employment Details',
                        color: AppColors.mainbackground,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      employmentDetails(
                          'Applicant 1', applicantDetailsLists[0]),
                      if (numberOfPersons > 1)
                        employmentDetails(
                            'Applicant 2', applicantDetailsLists[1]),
                      if (numberOfPersons > 2)
                        employmentDetails(
                            'Applicant 3', applicantDetailsLists[2]),
                      if (numberOfPersons > 3)
                        employmentDetails(
                            'Applicant 4', applicantDetailsLists[3]),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Next of Kin Information',
                        color: AppColors.neutral,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      kinInformation('Applicant 1', applicantDetailsLists[0]),
                      if (numberOfPersons > 1)
                        kinInformation('Applicant 2', applicantDetailsLists[1]),
                      if (numberOfPersons > 2)
                        kinInformation('Applicant 3', applicantDetailsLists[2]),
                      if (numberOfPersons > 3)
                        kinInformation('Applicant 4', applicantDetailsLists[3]),
                      SizedBox(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.mainColor),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(15))),
                            onPressed: () {
                              updateData(widget.id!, myTabController,
                                  loanDetail.applicantCount);
                              //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                              //  DefaultTabController.of(context)?.animateTo(1);
                              if (_formKey.currentState!.validate()) {
                                // Form is valid, move to the next section
                                myTabController.employmentDetailsList =
                                    applicantDetailsLists;
                                myTabController.updateEMplymentandKlin(
                                    applicantDetailsLists);
                                // printApplicantDetails();
                              }
                            },
                            child: CustomText(
                              text: 'Update',
                              color: AppColors.neutral,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(color: AppColors.neutral),
            ),
    );
  }

  void printApplicantDetails() {
    for (int i = 0; i < widget.myTabController.numberOfPersons; i++) {
      print('Applicant ${i + 1} Details:');

      // Kin Information
      print('Name: ${applicantDetailsLists[i].nameController.text}');
      print(
          'Other Names: ${applicantDetailsLists[i].otherNamesController.text}');
      print(
          'Physical Address: ${applicantDetailsLists[i].physicalAddressControlleremployment.text}');
      print(
          'Postal Address: ${applicantDetailsLists[i].postalAddressControllerEmployment.text}');
      print(
          'Cell Number: ${applicantDetailsLists[i].cellNumberController.text}');
      print(
          'Email Address: ${applicantDetailsLists[i].emailAddressController.text}');
      print(
          'Additional Field 1: ${applicantDetailsLists[i].physicalAddressControllernextofkin.text}');
      print(
          'Additional Field 2: ${applicantDetailsLists[i].postalAddressControllerforKline.text}');

      // Employment Details
      print('Job Title: ${applicantDetailsLists[i].jobTitleController.text}');
      print('Ministry: ${applicantDetailsLists[i].ministryController.text}');

      print('Town: ${applicantDetailsLists[i].townController}');
      print('Province: ${applicantDetailsLists[i].provinceController}');

      // Additional Fields for employmentDetails
      print(
          'Gross Salary: ${applicantDetailsLists[i].grossSalaryController.text}');
      print(
          'Current Net Salary: ${applicantDetailsLists[i].currentNetSalaryController.text}');
      print('Salary Scale: ${applicantDetailsLists[i].salaryScaleController}');
      print(
          'Preferred Year of Retirement: ${applicantDetailsLists[i].preferredYearOfRetirementController}');
      print(
          'Employee Number: ${applicantDetailsLists[i].employeeNumberController.text}');
      print(
          'Years in Employment: ${applicantDetailsLists[i].yearsInEmploymentController}');

      // Employment Type
      print('Employment Type: ${applicantDetailsLists[i].employmentType}');
      print('Employment Exp: ${applicantDetailsLists[i].expiryDateController}');
      // Additional Fields as needed

      print('\n');
    }
  }

  Container kinInformation(
      String message, EmployemntandKlinDetails applicantDetailsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: GoogleFonts.dmSans(
                color: AppColors.neutral,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.nameController,
                labelText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.otherNamesController,
                labelText: 'Other Names',
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  controller:
                      applicantDetailsList.physicalAddressControllernextofkin,
                  labelText: 'Physical Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter physical address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: FormTextField(
                  controller:
                      applicantDetailsList.postalAddressControllerforKline,
                  labelText: 'Postal Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal addres';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  controller: applicantDetailsList.cellNumberController,
                  labelText: 'Cell Number',
                  validator: (value) {
                    if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                      return 'Please enter only numeric digits';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: FormTextField(
                    controller: applicantDetailsList.emailAddressController,
                    labelText: 'Email Address',
                    validator: (value) {
                      // You might want to add more comprehensive email validation
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email Address';
                      }
                      // Basic email validation using a regular expression

                      if (!value.contains('@') || !value.contains('.com')) {
                        return 'Please enter a valid Email Address';
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container employmentDetails(
      String message, EmployemntandKlinDetails applicantDetailsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: GoogleFonts.dmSans(
                color: AppColors.neutral,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.jobTitleController,
                labelText: 'Job Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.ministryController,
                labelText: 'Minsitry',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ministy';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: FormTextField(
                controller:
                    applicantDetailsList.physicalAddressControlleremployment,
                labelText: 'Physical Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter physical address';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller:
                    applicantDetailsList.postalAddressControllerEmployment,
                labelText: 'Postal Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter postal address';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.mainbackground,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(
                      applicantDetailsList.provinceController == null
                          ? 'Select Province'
                          : applicantDetailsList.provinceController.toString(),
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: AppColors.neutral,
                        height: .5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: provinces
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  height: .5,
                                  fontSize: 15,
                                  color: AppColors.neutral,
                                ),
                              ),
                            ))
                        .toList(),
                    value: applicantDetailsList.provinceController,
                    onChanged: (String? value) {
                      setState(() {
                        applicantDetailsList.provinceController = value;
                        print(applicantDetailsList.provinceController);
                        applicantDetailsList.townController = null;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: applicantDetailsList.provinceController ==
                                      null
                                  ? Colors.red
                                  : Colors.grey,
                              width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.mainbackground,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(
                      applicantDetailsList.townController != null
                          ? applicantDetailsList.townController.toString()
                          : 'Select Town',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: AppColors.neutral,
                        height: .5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: applicantDetailsList.provinceController != null
                        ? townsByProvince[
                                applicantDetailsList.provinceController!]!
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w500,
                                      height: .5,
                                      fontSize: 15,
                                      color: AppColors.neutral,
                                    ),
                                  ),
                                ))
                            .toList()
                        : [],
                    value: applicantDetailsList.townController,
                    onChanged: (String? value) {
                      setState(() {
                        applicantDetailsList.townController = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: applicantDetailsList.townController == null
                                  ? Colors.red
                                  : Colors.grey,
                              width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.grossSalaryController,
                labelText: 'Gross Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gross salary';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only numeric digits';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.currentNetSalaryController,
                labelText: 'Current Net Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current net salary';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only numeric digits';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Salary Scale',
                    labelStyle: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
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
                      borderSide: BorderSide(
                        color: AppColors.neutral,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    applicantDetailsList.salaryScaleController == null
                        ? 'Salary Scale'
                        : applicantDetailsList.salaryScaleController.toString(),
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.neutral,
                        fontWeight: FontWeight.w500),
                  ),
                  items: letters.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(
                        letter,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          height: .5,
                          fontSize: 15,
                          color: AppColors.neutral,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      applicantDetailsList.salaryScaleController =
                          value.toString();
                      selectedLetter = value;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.neutral,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.mainbackground,
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Preferred Year of Retirement',
                    labelStyle: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
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
                      borderSide: BorderSide(
                        color: AppColors.neutral,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    applicantDetailsList.preferredYearOfRetirementController ==
                            null
                        ? 'Preferred Year of Retirement'
                        : applicantDetailsList
                            .preferredYearOfRetirementController
                            .toString(),
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.neutral,
                        fontWeight: FontWeight.w500),
                  ),
                  items: prefyearsList.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(
                        letter,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          height: .5,
                          fontSize: 15,
                          color: AppColors.neutral,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      applicantDetailsList.preferredYearOfRetirementController =
                          value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.neutral,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.mainbackground,
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList.employeeNumberController,
                labelText: 'Employee Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee number';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                    return 'Only letters and numbers are allowed';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Years in Employment',
                    labelStyle: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
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
                      borderSide: BorderSide(
                        color: AppColors.neutral,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add more decoration..
                  ),
                  hint: Text(
                    applicantDetailsList.yearsInEmploymentController == null
                        ? 'Years in Employment'
                        : applicantDetailsList.yearsInEmploymentController
                            .toString(),
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.neutral,
                        fontWeight: FontWeight.w500),
                  ),
                  items: yearsList.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(
                        letter,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          height: .5,
                          fontSize: 15,
                          color: AppColors.neutral,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      applicantDetailsList.yearsInEmploymentController =
                          value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.neutral,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.mainbackground,
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              CustomText(
                text: 'Employment Type:',
                color: AppColors.neutral,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Row(
                    children: employemnttypelist.map((String value) {
                      return Row(
                        children: [
                          Radio(
                            activeColor: AppColors.mainColor,
                            value: value,
                            groupValue: applicantDetailsList.employmentType,
                            onChanged: (String? newValue) {
                              setState(() {
                                applicantDetailsList.employmentType = newValue!;
                              });
                            },
                          ),
                          CustomText(
                            text: value,
                            color: AppColors.neutral,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 40.0),
                  if (applicantDetailsList.employmentType == 'Temporary')
                    SizedBox(
                        width: 300,
                        child: GestureDetector(
                          onTap: () async {
                            await _selectJobExpiryDate(
                                context, applicantDetailsList);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  applicantDetailsList.expiryDateController,
                              decoration: InputDecoration(
                                labelText: 'Expiry Date',
                                labelStyle: GoogleFonts.dmSans(
                                  color: AppColors.neutral,
                                  height: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: AppColors.mainbackground,
                                      width: 1.0),
                                ),
                              ),
                              style: GoogleFonts.dmSans(
                                color: AppColors.neutral,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Expiry Date';
                                }
                                return null;
                              },
                            ),
                          ),
                        )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool validateEmploymentType(List<EmployemntandKlinDetails> applicants) {
    for (int i = 0; i < applicants.length; i++) {
      String employmentType = applicants[i].employmentType;

      if (employmentType != 'Permanent' && employmentType != 'Temporary') {
        // Employment type is not a valid value (neither "Permanent" nor "Temporary")
        return false;
      }

      // Additional validation for Temporary employment type if needed
      if (employmentType == 'Temporary' &&
          applicants[i].expiryDateController.text.isEmpty) {
        // Additional field for Temporary employment is empty
        return false;
      }
    }

    // All employmentType values are either "Permanent" or "Temporary" with additional validation if needed
    return true;
  }

  Future<void> _selectJobExpiryDate(
      BuildContext context, EmployemntandKlinDetails applicant) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101), // Adjust as needed
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        applicant.expiryDateController.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchData(widget.id);
  }

  Future<void> fetchData(int? requestId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    try {
      Dio dio = Dio();

      // Replace 'YOUR_BEARER_TOKEN' with the actual Bearer token
      String bearertoken = token!;
      dio.options.headers['Authorization'] = 'Bearer $bearertoken';

      final response = await dio.get(
        'https://loan-managment.onrender.com/loan_requests/$requestId',
        // Add headers or parameters as needed
      );

      if (response.statusCode == 200) {
        final loanDetail = LoanRequestDetails.fromJson(response.data);
        //print(response.data);

        setState(() {
          // Move this block here
          this.loanDetail = loanDetail;

          for (int i = 0; i < loanDetail.applicantCount; i++) {
            applicantDetailsLists[i].applicantid = loanDetail.applicants[i].id;
            applicantDetailsLists[i].occupationid =
                loanDetail.applicants[i].occupation.id;
            applicantDetailsLists[i].kinid = loanDetail.applicants[i].kin.id;
            applicantDetailsLists[i].jobTitleController.text =
                loanDetail.applicants[i].occupation.jobTitle;
            applicantDetailsLists[i].ministryController.text =
                loanDetail.applicants[i].occupation.ministry;
            applicantDetailsLists[i].physicalAddressControlleremployment.text =
                loanDetail.applicants[i].occupation.physicalAddress;
            applicantDetailsLists[i].postalAddressControllerEmployment.text =
                loanDetail.applicants[i].occupation.postalAddress;
            applicantDetailsLists[i].provinceController =
                loanDetail.applicants[i].occupation.province;
            applicantDetailsLists[i].townController =
                loanDetail.applicants[i].occupation.town;
            applicantDetailsLists[i].grossSalaryController.text =
                loanDetail.applicants[i].occupation.grossSalary;
            applicantDetailsLists[i].currentNetSalaryController.text =
                loanDetail.applicants[i].occupation.currentNetSalary;
            applicantDetailsLists[i].salaryScaleController =
                loanDetail.applicants[i].occupation.salaryScale;
            applicantDetailsLists[i].preferredYearOfRetirementController =
                loanDetail.applicants[i].occupation.preferredRetirementYear;
            applicantDetailsLists[i].employeeNumberController.text =
                loanDetail.applicants[i].occupation.employerNumber;
            applicantDetailsLists[i].yearsInEmploymentController =
                loanDetail.applicants[i].occupation.yearsOfService;
            applicantDetailsLists[i].nameController.text =
                loanDetail.applicants[i].kin.name;
            applicantDetailsLists[i].otherNamesController.text =
                loanDetail.applicants[i].kin.otherNames;
            applicantDetailsLists[i].physicalAddressControllernextofkin.text =
                loanDetail.applicants[i].occupation.physicalAddress;
            applicantDetailsLists[i].netSalaryController.text =
                loanDetail.applicants[i].occupation.netSalary;
            applicantDetailsLists[i].employmentType =
                loanDetail.applicants[i].occupation.employmentType;

            applicantDetailsLists[i].postalAddressControllerforKline.text =
                loanDetail.applicants[i].occupation.postalAddress;
            applicantDetailsLists[i].cellNumberController.text =
                loanDetail.applicants[i].kin.phoneNumber;
            applicantDetailsLists[i].emailAddressController.text =
                loanDetail.applicants[i].kin.email;

            applicantDetailsLists[i].retirementYearController.text =
                loanDetail.applicants[i].occupation.retirementYear;

            applicantDetailsLists[i].expiryDateController.text =
                loanDetail.applicants[i].occupation.expiryDate;

            applicantDetailsLists[i].temperoryexpirydate.text =
                loanDetail.applicants[i].occupation.tempExpiryDate;

            applicantDetailsLists[i].preferredYearOfRetirementController =
                loanDetail.applicants[i].occupation.preferredRetirementYear;
          }
        });
        setState(() {
          isloadiing = false;
        });
      } else {
        // Handle error response
        print('eeee: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Errrrror: $error');
    }
  }

  Future<void> updateData(
      int? id, MyTabController myTabController, int persons) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
      isloadiing = true;
    });
    final String apiUrl =
        'https://loan-managment.onrender.com/loan_requests/$id';

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
      String accessToken = token!;
      request.headers['Authorization'] = 'Bearer $accessToken';
      for (int i = 0; i < persons; i++) {
        // Add other applicant data to the request
        request.fields['loan_request[applicants_attributes][$i][id]'] =
            myTabController.employmentDetailsList[i].applicantid.toString();
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][id]'] =
            myTabController.employmentDetailsList[i].kinid.toString();

        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][name]'] =
            myTabController.employmentDetailsList[i].nameController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][other_names]'] =
            myTabController.employmentDetailsList[i].otherNamesController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][physical_address]'] =
            myTabController.employmentDetailsList[i]
                .physicalAddressControllernextofkin.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][postal_address]'] =
            myTabController
                .employmentDetailsList[i].postalAddressControllerforKline.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][phone_number]'] =
            myTabController.employmentDetailsList[i].cellNumberController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][kin_attributes][email]'] =
            myTabController
                .employmentDetailsList[i].emailAddressController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][id]'] =
            myTabController.employmentDetailsList[i].occupationid.toString();
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][job_title]'] =
            myTabController.employmentDetailsList[i].jobTitleController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][ministry]'] =
            myTabController.employmentDetailsList[i].ministryController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][physical_address]'] =
            myTabController.employmentDetailsList[i]
                .physicalAddressControlleremployment.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][postal_address]'] =
            myTabController.employmentDetailsList[i]
                .postalAddressControllerEmployment.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][town]'] =
            myTabController.employmentDetailsList[i].townController.toString();
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][province]'] =
            myTabController.employmentDetailsList[i].provinceController
                .toString();
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][gross_salary]'] =
            myTabController.employmentDetailsList[i].grossSalaryController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][net_salary]'] =
            myTabController.employmentDetailsList[i].netSalaryController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][salary_scale]'] =
            myTabController.employmentDetailsList[i].salaryScaleController
                .toString();
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][retirement_year]'] =
            myTabController
                .employmentDetailsList[i].retirementYearController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employer_number]'] =
            myTabController
                .employmentDetailsList[i].employeeNumberController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][years_of_service]'] =
            myTabController.employmentDetailsList[i].yearsInEmploymentController
                .toString();
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][employment_type]'] =
            myTabController.employmentDetailsList[i].employmentType.toString();
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][expiry_date]'] =
            myTabController.employmentDetailsList[i].expiryDateController.text;

        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][current_net_salary]'] =
            myTabController
                .employmentDetailsList[i].currentNetSalaryController.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][temp_expiry_date]'] =
            myTabController.employmentDetailsList[i].temperoryexpirydate.text;
        request.fields[
                'loan_request[applicants_attributes][$i][occupation_attributes][preferred_retirement_year]'] =
            myTabController
                .employmentDetailsList[i].retirementYearController.text;

        // Add other applicant details as needed
      }
      print(request.fields);
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request was successful
        print('Form submitted successfully');
        setState(() {
          isloadiing = false;
        });
        warning('Form Submitted');
        fetchData(widget.id);
        //  clearAllFields();
      } else {
        // Request failed
        print('Form submission failed with status: ${response.statusCode}');
        setState(() {
          isloadiing = false;
        });
        warning('Error: Cannot Submit Form');
      }
    } catch (e) {
      print("Error: $e");
      warning('Error: Cannot Submit Form');
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
