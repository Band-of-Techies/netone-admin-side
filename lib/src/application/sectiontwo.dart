// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:netone_loanmanagement_admin/src/application/datas/applicationdetails.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:provider/provider.dart';

class SectionTwo extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionTwo(this.myTabController, this._tabController);

  @override
  State<SectionTwo> createState() => _SectionTwoState();
}

class _SectionTwoState extends State<SectionTwo> {
  final _formKey = GlobalKey<FormState>();

  List<EmployemntandKlinDetails> applicantDetailsList =
      List.generate(4, (_) => EmployemntandKlinDetails());

  List<String> employemnttypelist = ['Permanent', 'Temporary'];
  @override
  Widget build(BuildContext context) {
    final numberOfPersons = widget.myTabController.numberOfPersons;
    final myTabController = Provider.of<MyTabController>(context);
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomText(
                text: 'Employment Details',
                color: AppColors.neutral,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              employmentDetails('Applicant 1', 0),
              if (numberOfPersons > 1) employmentDetails('Applicant 2', 1),
              if (numberOfPersons > 2) employmentDetails('Applicant 3', 2),
              if (numberOfPersons > 3) employmentDetails('Applicant 4', 3),
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
              kinInformation('Applicant 1', 0),
              if (numberOfPersons > 1) kinInformation('Applicant 2', 1),
              if (numberOfPersons > 2) kinInformation('Applicant 3', 2),
              if (numberOfPersons > 3) kinInformation('Applicant 4', 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.sidebarbackground),
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
                          color: AppColors.neutral,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.mainColor),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
                        onPressed: () {
                          myTabController.employmentDetailsList =
                              applicantDetailsList;
                          // printApplicantDetails();
                          if (widget._tabController.index <
                              widget._tabController.length - 1) {
                            widget._tabController
                                .animateTo(widget._tabController.index + 1);
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
                          text: 'Next',
                          color: AppColors.neutral,
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
    for (int i = 0; i < applicantDetailsList.length; i++) {
      print('Applicant ${i + 1} Details:');

      // Kin Information
      print('Name: ${applicantDetailsList[i].nameController.text}');
      print(
          'Other Names: ${applicantDetailsList[i].otherNamesController.text}');
      print(
          'Physical Address: ${applicantDetailsList[i].physicalAddressControlleremployment.text}');
      print(
          'Postal Address: ${applicantDetailsList[i].postalAddressControllerEmployment.text}');
      print(
          'Cell Number: ${applicantDetailsList[i].cellNumberController.text}');
      print(
          'Email Address: ${applicantDetailsList[i].emailAddressController.text}');
      print(
          'Additional Field 1: ${applicantDetailsList[i].physicalAddressControllernextofkin.text}');
      print(
          'Additional Field 2: ${applicantDetailsList[i].postalAddressControllerforKline.text}');

      // Employment Details
      print('Job Title: ${applicantDetailsList[i].jobTitleController.text}');
      print('Ministry: ${applicantDetailsList[i].ministryController.text}');

      print('Town: ${applicantDetailsList[i].townController.text}');
      print('Province: ${applicantDetailsList[i].provinceController.text}');

      // Additional Fields for employmentDetails
      print(
          'Gross Salary: ${applicantDetailsList[i].grossSalaryController.text}');
      print(
          'Current Net Salary: ${applicantDetailsList[i].currentNetSalaryController.text}');
      print(
          'Salary Scale: ${applicantDetailsList[i].salaryScaleController.text}');
      print(
          'Preferred Year of Retirement: ${applicantDetailsList[i].preferredYearOfRetirementController.text}');
      print(
          'Employee Number: ${applicantDetailsList[i].employeeNumberController.text}');
      print(
          'Years in Employment: ${applicantDetailsList[i].yearsInEmploymentController.text}');

      // Employment Type
      print('Employment Type: ${applicantDetailsList[i].employmentType}');
      print('Employment Exp: ${applicantDetailsList[i].expiryDateController}');
      // Additional Fields as needed

      print('\n');
    }
  }

  Container kinInformation(String message, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 35, 42, 51),
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
                controller: applicantDetailsList[index].nameController,
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
                controller: applicantDetailsList[index].otherNamesController,
                labelText: 'Other Names',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter other names';
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
                  controller: applicantDetailsList[index]
                      .physicalAddressControllernextofkin,
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
                  controller: applicantDetailsList[index]
                      .postalAddressControllerforKline,
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
                  controller: applicantDetailsList[index].cellNumberController,
                  labelText: 'Cell Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter cell number';
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
                      applicantDetailsList[index].emailAddressController,
                  labelText: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container employmentDetails(String message, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 35, 42, 51),
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
                controller: applicantDetailsList[index].jobTitleController,
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
                controller: applicantDetailsList[index].ministryController,
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
                controller: applicantDetailsList[index]
                    .physicalAddressControlleremployment,
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
                controller: applicantDetailsList[index]
                    .postalAddressControllerEmployment,
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
                  child: FormTextField(
                controller: applicantDetailsList[index].townController,
                labelText: 'Town',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter town';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList[index].provinceController,
                labelText: 'Province',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter province';
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
                controller: applicantDetailsList[index].grossSalaryController,
                labelText: 'Gross Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gross salary';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller:
                    applicantDetailsList[index].currentNetSalaryController,
                labelText: 'Current Net Salary',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current net salary';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicantDetailsList[index].salaryScaleController,
                labelText: 'Salary Scale',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter salary scale';
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
                controller: applicantDetailsList[index]
                    .preferredYearOfRetirementController,
                labelText: 'Preferred Year of Retirement',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter retirement year';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller:
                    applicantDetailsList[index].employeeNumberController,
                labelText: 'Employee Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee number';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller:
                    applicantDetailsList[index].yearsInEmploymentController,
                labelText: 'Years in Employment',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter year';
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
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: AppColors
                                  .neutral, // Set your desired border color
                            ),
                            child: Radio(
                              activeColor: AppColors.mainColor,
                              value: value,
                              groupValue:
                                  applicantDetailsList[index].employmentType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  applicantDetailsList[index].employmentType =
                                      newValue!;
                                });
                              },
                            ),
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
                  if (applicantDetailsList[index].employmentType == 'Temporary')
                    SizedBox(
                        width: 300,
                        child: GestureDetector(
                          onTap: () async {
                            await _selectJobExpiryDate(
                                context, applicantDetailsList[index]);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              readOnly: true,
                              controller: applicantDetailsList[index]
                                  .expiryDateController,
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
                                      color: AppColors.mainColor, width: 1.0),
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
}
