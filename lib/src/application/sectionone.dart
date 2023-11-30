// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicant.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:provider/provider.dart';

class SectionOne extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionOne(this.myTabController, this._tabController);
  @override
  _SectionOneState createState() => _SectionOneState();
}

class _SectionOneState extends State<SectionOne> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  List<ApplicantDetails> applicants = [];
  List<String> ownedorlease = ['Owned', 'Lease'];
  List<String> genders = ['Male', 'Female'];
  bool isJointApplication = false;
  int numberOfPersons = 1;

  @override
  Widget build(BuildContext context) {
    final myTabController = Provider.of<MyTabController>(context);
    // Access data from myTabController to pre-fill form fields
    numberOfPersons = myTabController.numberOfPersons;
    List<ApplicantDetails> applicants = myTabController.applicants;
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              applicantDetails(1, applicants[0]),
              if (widget.myTabController.numberOfPersons > 1)
                applicantDetails(2, applicants[1]),
              if (widget.myTabController.numberOfPersons > 2)
                applicantDetails(3, applicants[2]),
              if (widget.myTabController.numberOfPersons > 3)
                applicantDetails(4, applicants[3]),
              Row(
                children: [
                  CustomText(
                    text: 'Joint Application:',
                    color: AppColors.neutral,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                    activeColor: AppColors.mainColor,
                    value: widget.myTabController.numberOfPersons < 2
                        ? isJointApplication
                        : true,
                    onChanged: (value) {
                      setState(() {
                        isJointApplication = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  isJointApplication ||
                          widget.myTabController.numberOfPersons > 1
                      ? Expanded(
                          child: DropdownButtonFormField(
                            focusColor: AppColors.mainbackground,
                            dropdownColor: AppColors.sidebarbackground,
                            value: numberOfPersons,
                            iconEnabledColor: AppColors.mainColor,
                            items: [1, 2, 3, 4].map((int value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (int? value) {
                              setState(() {
                                int previousNumberOfPersons = numberOfPersons;
                                numberOfPersons = value!;

                                if (numberOfPersons > previousNumberOfPersons) {
                                  // Generate new applicants only for the additional persons
                                  applicants.addAll(List.generate(
                                    numberOfPersons - previousNumberOfPersons,
                                    (index) => ApplicantDetails(),
                                  ));
                                } else {
                                  // Trim the list if the number of persons is reduced
                                  applicants.removeRange(
                                      numberOfPersons, applicants.length);
                                }
                                print(numberOfPersons);
                                widget.myTabController
                                    .updateNumberOfPersons(value);
                                widget.myTabController.numberOfPersons = value;
                              });
                            },
                            style: GoogleFonts.dmSans(
                              color: AppColors.neutral,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 1.0),
                              ),
                              labelText: 'Number of Persons',
                              labelStyle: GoogleFonts.dmSans(
                                color: AppColors.neutral,
                                height: 0.5,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.mainColor),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                  onPressed: () {
                    if (validateGender(applicants) &&
                        validateOwnership(applicants)) {
                      myTabController.applicants = applicants;
                      myTabController.updateApplicants(applicants);
                      widget._tabController
                          .animateTo(widget._tabController.index + 1);
                      widget.myTabController
                          .updateNumberOfPersons(numberOfPersons);
                      DefaultTabController.of(context)?.animateTo(1);
                    }

                    if (_formKey.currentState!.validate()) {
                      // Form is valid, move to the next section

                      //printApplicantDetails();
                      if (widget._tabController.index <
                          widget._tabController.length - 1) {
                      } else {
                        // Handle the case when the last tab is reached
                      }
                    }
                  },
                  child: CustomText(
                    text: 'Next',
                    color: AppColors.neutral,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Container applicantDetails(int title, ApplicantDetails applicant) {
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
            'Applicant $title',
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
                controller: applicant.surnameController,
                labelText: 'Surname',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Surname';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicant.middleNameController,
                labelText: 'Middle Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Middle Name';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicant.firstNameController,
                labelText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your First Name';
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
                text: 'Gender',
                color: AppColors.neutral,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: genders.map((String value) {
                  return Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: AppColors
                              .neutral, // Set your desired border color
                        ),
                        child: Radio(
                          focusColor: Colors.white,
                          activeColor: AppColors.mainColor,
                          value: value,
                          groupValue: applicant.gender,
                          onChanged: (String? newValue) {
                            setState(() {
                              applicant.gender = newValue!;
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
              SizedBox(width: 20),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await _selectDate(context, applicant);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: applicant.dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      labelStyle: GoogleFonts.dmSans(
                        color: AppColors.neutral,
                        height: 0.5,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: AppColors.mainColor, width: 1.0),
                      ),
                    ),
                    style: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose DOB';
                      }
                      return null;
                    },
                  ),
                ),
              )),
              SizedBox(width: 20),
              Expanded(
                  child: FormTextField(
                controller: applicant.nrcController,
                labelText: 'NRC Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NRC Number';
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
                controller: applicant.telephoneController,
                labelText: 'Telephone',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Telephone';
                  }
                  return null;
                },
              )),
              SizedBox(width: 40.0),
              Expanded(
                  child: FormTextField(
                controller: applicant.mobileController,
                labelText: 'Mobile',
                validator: (value) {
                  // You might want to add more comprehensive mobile validation
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Mobile Number';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          FormTextField(
            controller: applicant.emailController,
            labelText: 'Email Address',
            validator: (value) {
              // You might want to add more comprehensive email validation
              if (value == null || value.isEmpty) {
                return 'Please enter your Email Address';
              }
              return null;
            },
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: FormTextField(
                controller: applicant.licenseNumberController,
                labelText: 'Driver License Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter License Number';
                  }
                  return null;
                },
              )),
              SizedBox(width: 20),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await _selectLicenseExpiryDate(context, applicant);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: applicant.licenseExpiryController,
                    decoration: InputDecoration(
                      labelText: 'License Expiry Date',
                      labelStyle: GoogleFonts.dmSans(
                        color: AppColors.neutral,
                        height: 0.5,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: AppColors.mainColor, width: 1.0),
                      ),
                    ),
                    style: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose DOB';
                      }
                      return null;
                    },
                  ),
                ),
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
                controller: applicant.residentialAddressController,
                labelText: 'Residential Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Residential Address';
                  }
                  return null;
                },
              )),
              SizedBox(width: 20),
              CustomText(
                text: 'Ownership',
                color: AppColors.neutral,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: ownedorlease.map((String value) {
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
                          groupValue: applicant.ownership,
                          onChanged: (String? newValue) {
                            setState(() {
                              applicant.ownership = newValue!;
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
              SizedBox(width: 20),
              Expanded(
                  child: FormTextField(
                controller: applicant.howlongthisplaceController,
                labelText: 'How Long at this Place',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'How long this place';
                  }
                  return null;
                },
              )),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          // Town and Province
          Row(
            children: [
              Expanded(
                  child: FormTextField(
                controller: applicant.postalAddressController,
                labelText: 'Postal Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Postal Address';
                  }
                  return null;
                },
              )),
              SizedBox(width: 20),
              Expanded(
                  child: FormTextField(
                controller: applicant.townController,
                labelText: 'Town',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Town';
                  }
                  return null;
                },
              )),
              SizedBox(width: 20),
              Expanded(
                  child: FormTextField(
                controller: applicant.provinceController,
                labelText: 'Province',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Province';
                  }
                  return null;
                },
              )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    applicants = List.generate(numberOfPersons, (index) => ApplicantDetails());
  }

  Future<void> _selectDate(
      BuildContext context, ApplicantDetails applicant) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // if backend requires time and date in another format use staring in applicant details and assign here, controller in textfield
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        applicant.dobController.text = formattedDate;
      });
    }
  }

  void printApplicantDetails() {
    for (int i = 0; i < numberOfPersons; i++) {
      print('Applicant ${i + 1} Details:');
      print('Surname: ${applicants[i].surnameController.text}');
      print('Middle Name: ${applicants[i].middleNameController.text}');
      print('First Name: ${applicants[i].firstNameController.text}');
      print('Gender: ${applicants[i].gender}');
      print('Date of Birth: ${applicants[i].dobController}');
      print('NRC Number: ${applicants[i].nrcController.text}');
      print('Telephone: ${applicants[i].telephoneController.text}');
      print('Mobile: ${applicants[i].mobileController.text}');
      print('Email Address: ${applicants[i].emailController.text}');
      print(
          'Driver License Number: ${applicants[i].licenseNumberController.text}');
      print('License Expiry Date: ${applicants[i].licenseExpiryController}');
      print(
          'Residential Address: ${applicants[i].residentialAddressController.text}');
      print('Ownership: ${applicants[i].ownership}');

      print('Postal Address: ${applicants[i].postalAddressController.text}');
      print('Town: ${applicants[i].townController.text}');
      print('Province: ${applicants[i].provinceController.text}');
      print('\n');
    }
  }

  Future<void> _selectLicenseExpiryDate(
      BuildContext context, ApplicantDetails applicant) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101), // Adjust as needed
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        applicant.licenseExpiryController.text = formattedDate;
      });
    }
  }
}

bool validateOwnership(List<ApplicantDetails> applicants) {
  for (int i = 0; i < applicants.length; i++) {
    String? ownership = applicants[i].ownership;

    if (ownership != 'Owned' && ownership != 'Lease') {
      // Ownership is not a valid value (neither "Owned" nor "Lease")
      return false;
    }
  }

  // All ownership values are either "Owned" or "Lease"
  return true;
}

bool validateGender(List<ApplicantDetails> applicants) {
  for (int i = 0; i < applicants.length; i++) {
    String? gender = applicants[i].gender;

    if (gender == null || (gender != 'Male' && gender != 'Female')) {
      // Gender is either null or not a valid value (neither "Male" nor "Female")
      return false;
    }
  }

  // All genders are either "Male" or "Female"
  return true;
}
