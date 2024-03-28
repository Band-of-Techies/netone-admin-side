// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/api/applicantdetails.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/constants/colors.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/constants/text.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/constants/textfield.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/createapp.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';

import 'package:provider/provider.dart';

class SectionTwo extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionTwo(this.myTabController, this._tabController);

  @override
  State<SectionTwo> createState() => _SectionTwoState();
}

class _SectionTwoState extends State<SectionTwo>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  List<String> prefyearsList =
      List.generate(61, (index) => (DateTime.now().year + index).toString());
  List<EmployemntandKlinDetails> applicantDetailsLists = [];
  String? selectedLetter;
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
    List<EmployemntandKlinDetails> applicantDetailsLists =
        myTabController.employmentDetailsList;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomText(
                text: 'Employment Details',
                color: blackfont,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              employmentDetails('Applicant 1', applicantDetailsLists[0]),
              if (numberOfPersons > 1)
                employmentDetails('Applicant 2', applicantDetailsLists[1]),
              if (numberOfPersons > 2)
                employmentDetails('Applicant 3', applicantDetailsLists[2]),
              if (numberOfPersons > 3)
                employmentDetails('Applicant 4', applicantDetailsLists[3]),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Next of Kin Information',
                color: blackfont,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttondarkbg),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
                        onPressed: () {
                          if (widget._tabController.index <
                              widget._tabController.length - 1) {
                            widget._tabController
                                .animateTo(widget._tabController.index - 1);
                          } else {
                            // Handle the case when the last tab is reached
                          }
                          //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                          //  DefaultTabController.of(context)?.animateTo(1);
                          // if (_formKey.currentState!.validate()) {
                          //   // Form is valid, move to the next section

                          // }
                        },
                        child: CustomText(
                          text: 'Previous',
                          color: whitefont,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(primary),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
                        onPressed: () {
                          //widget.myTabController.updateNumberOfPersons(numberOfPersons);
                          //  DefaultTabController.of(context)?.animateTo(1);
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, move to the next section
                            if (validateLocation(applicantDetailsLists) &&
                                validateRetrirement(applicantDetailsLists) &&
                                validateEmploymentType(applicantDetailsLists)) {
                              myTabController.employmentDetailsList =
                                  applicantDetailsLists;
                              myTabController.updateEMplymentandKlin(
                                  applicantDetailsLists);
                              // printApplicantDetails();
                              if (widget._tabController.index <
                                  widget._tabController.length - 1) {
                                widget._tabController
                                    .animateTo(widget._tabController.index + 1);
                              }
                            } else {
                              warning('Complete Details');
                            }
                          }
                        },
                        child: CustomText(
                          text: 'Next',
                          color: whitefont,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  bool validateLocation(List<EmployemntandKlinDetails> applicants) {
    for (int i = 0; i < widget.myTabController.numberOfPersons; i++) {
      String? town = applicants[i].townController;
      String? province = applicants[i].provinceController;
      if (province == null || town == null) {
        return false;
      }
    }

    return true;
  }

  bool validateRetrirement(List<EmployemntandKlinDetails> applicants) {
    for (int i = 0; i < widget.myTabController.numberOfPersons; i++) {
      String? year = applicants[i].preferredYearOfRetirementController;

      if (year == null) {
        return false;
      }
    }

    return true;
  }

  bool validateEmploymentType(List<EmployemntandKlinDetails> applicants) {
    for (int i = 0; i < widget.myTabController.numberOfPersons; i++) {
      String? type = applicants[i].employmentType;

      if (type == null) {
        return false;
      }
    }

    return true;
  }

  Container kinInformation(
      String message, EmployemntandKlinDetails applicantDetailsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(82, 240, 246, 156),
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
                color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
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
                  child: CustomTextFormField(
                controller: applicantDetailsList.otherNamesController,
                labelText: 'Other Names',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter other name';
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
                child: CustomTextFormField(
                  controller:
                      applicantDetailsList.physicalAddressControllernextofkin,
                  labelText: 'Physical Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller:
                      applicantDetailsList.postalAddressControllerforKline,
                  labelText: 'Postal Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
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
                child: CustomTextFormField(
                  prefix: '+260 ',
                  controller: applicantDetailsList.cellNumberController,
                  labelText: 'Cell Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Cell Number';
                    }

                    // Validate if the value starts with '+260' and contains only numeric digits afterwards
                    RegExp mobilePattern = RegExp(r'^\d{9}$');
                    if (!mobilePattern.hasMatch(value)) {
                      return 'Please enter a valid Cell Number';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Expanded(
                child: CustomTextFormField(
                    controller: applicantDetailsList.emailAddressController,
                    labelText: 'Email Address',
                    validator: (value) {
                      // You might want to add more comprehensive email validation
                      if (value!.isEmpty || value == null) {
                        return null;
                      }
                      if (value != null || value!.isNotEmpty) {
                        {
                          if (!isValidEmail(value)) {
                            return 'Please enter a valid Email Address';
                          }
                        }
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

  bool isValidEmail(String email) {
    // Regular expression for a basic email validation
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return emailRegex.hasMatch(email);
  }

  warning(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: MediaQuery.of(context).size.width * .7,
        backgroundColor: whitefont,
        duration: Duration(seconds: 3),
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: CustomText(
              text: message,
              fontSize: 13,
              color: blackfont,
              fontWeight: FontWeight.w500),
        )));
  }

  Container employmentDetails(
      String message, EmployemntandKlinDetails applicantDetailsList) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(80, 252, 227, 194),
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
                color: blackfont, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.jobTitleController,
                labelText: 'Job Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null; // Allow null values
                  }

                  // Validate if the value contains only letters, digits, and hyphens
                  RegExp jobTitlePattern = RegExp(r'^[a-zA-Z0-9\- ]+$');
                  if (!jobTitlePattern.hasMatch(value)) {
                    return 'Can only contain letters, digits, and -';
                  }

                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.ministryController,
                labelText: 'Minsitry',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null; // Allow null values
                  }

                  // Validate if the value contains only letters, digits, and hyphens
                  RegExp ministryPattern = RegExp(r'^[a-zA-Z0-9\- ]+$');
                  if (!ministryPattern.hasMatch(value)) {
                    return 'Can only contain letters, digits, hyphens, and spaces';
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
                  child: CustomTextFormField(
                controller:
                    applicantDetailsList.physicalAddressControlleremployment,
                labelText: 'Physical Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
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
                    isExpanded: true,
                    hint: Text(
                      applicantDetailsList.provinceController == null
                          ? 'Select Province'
                          : applicantDetailsList.provinceController.toString(),
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: blackfont,
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
                                    color: blackfont),
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
                    isExpanded: true,
                    hint: Text(
                      applicantDetailsList.townController != null
                          ? applicantDetailsList.townController.toString()
                          : 'Select District',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: blackfont,
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
                                      color: Colors.black,
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
                  child: CustomTextFormField(
                controller: applicantDetailsList.grossSalaryController,
                labelText: 'Gross Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gross salary';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only digits';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
                controller: applicantDetailsList.currentNetSalaryController,
                labelText: 'Current Net Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current net salary';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only digits';
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
                      color: Colors.black,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: blackfont,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blackfont,
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
                        color: blackfont,
                        fontWeight: FontWeight.w500),
                  ),
                  items: letters.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(letter),
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
                    icon: Icon(Icons.arrow_drop_down, color: blackfont),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      applicantDetailsList
                                  .preferredYearOfRetirementController !=
                              null
                          ? applicantDetailsList
                              .preferredYearOfRetirementController
                              .toString()
                          : 'Preferred Year of Retirement',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: blackfont,
                        height: .5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: List.generate(
                      61,
                      (index) {
                        final currentYear = DateTime.now().year;
                        final year = currentYear + index;
                        return DropdownMenuItem<String>(
                          value: year.toString(),
                          child: Text(
                            year.toString(),
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              height: .5,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                    value: applicantDetailsList
                        .preferredYearOfRetirementController,
                    onChanged: (String? value) {
                      setState(() {
                        applicantDetailsList
                            .preferredYearOfRetirementController = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: applicantDetailsList
                                          .preferredYearOfRetirementController ==
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
              SizedBox(width: 40.0),
              Expanded(
                  child: CustomTextFormField(
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
                      color: Colors.black,
                      height: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: blackfont,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: blackfont, width: .5)),
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blackfont,
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
                        color: blackfont,
                        fontWeight: FontWeight.w500),
                  ),
                  items: yearsList.map((letter) {
                    return DropdownMenuItem(
                      value: letter,
                      child: Text(letter),
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
                    icon: Icon(Icons.arrow_drop_down, color: blackfont),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
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
                color: blackfont,
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
                            activeColor: primary,
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
                            color: blackfont,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 40.0),
                  if (applicantDetailsList.employmentType == 'contract')
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
                                labelText: 'Contract Exp',
                                labelStyle: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  height: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                errorStyle:
                                    GoogleFonts.dmSans(color: Colors.red),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: primary, width: 1.0),
                                ),
                              ),
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please choose contract end date';
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

  Future<void> _selectJobExpiryDate(
      BuildContext context, EmployemntandKlinDetails applicant) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 60),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the calendar header color to red

            colorScheme: ColorScheme.light(primary: primary),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),

            textTheme: GoogleFonts.dmSansTextTheme(),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        applicant.expiryDateController.text = formattedDate;
      });
    }
  }
}
