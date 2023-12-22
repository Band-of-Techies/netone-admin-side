// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicant.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:provider/provider.dart';

class SectionOne extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;
  int? id;
  SectionOne(this.myTabController, this._tabController, this.id);
  @override
  _SectionOneState createState() => _SectionOneState();
}

class _SectionOneState extends State<SectionOne>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  List<String>? applicantKeys;
  late LoanRequestDetails loanDetail;
  // Controllers for text fields
  List<ApplicantDetails> applicants = [];
  List<String> ownedorlease = ['owned', 'rented'];
  List<String> genders = ['Male', 'Female'];

  int numberOfPersons = 1;
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

  @override
  Widget build(BuildContext context) {
    final myTabController = Provider.of<MyTabController>(context);
    // Access data from myTabController to pre-fill form fields
    numberOfPersons = myTabController.numberOfPersons;
    applicants = myTabController.applicants;

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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.mainColor),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, move to the next section

                      sendPatchRequest(widget.id!);
                    }
                  },
                  child: CustomText(
                    text: 'Update',
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
          color: AppColors.sidebarbackground,
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
                      Radio(
                        activeColor: AppColors.mainColor,
                        value: value,
                        groupValue: applicant.gender,
                        onChanged: (String? newValue) {
                          setState(() {
                            applicant.gender = newValue!;
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

                  // Define a regex pattern for NRC validation
                  RegExp nrcPattern = RegExp(r'^[0-9/ ]+$');

                  if (!nrcPattern.hasMatch(value)) {
                    return 'NRC Number can only contain numbers, space, and "/"';
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
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only numeric digits';
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
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only numeric digits';
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
              // Basic email validation using a regular expression

              if (!value.contains('@') || !value.contains('.com')) {
                return 'Please enter a valid Email Address';
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
                      Radio(
                        activeColor: AppColors.mainColor,
                        value: value,
                        groupValue: applicant.ownership,
                        onChanged: (String? newValue) {
                          setState(() {
                            applicant.ownership = newValue!;
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
              SizedBox(width: 20),
              Expanded(
                  child: FormTextField(
                controller: applicant.howlongthisplaceController,
                labelText: 'How Long at this Place',
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
                      applicant.provinceController == null
                          ? 'Select Province'
                          : applicant.provinceController.toString(),
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
                                    color: AppColors.neutral),
                              ),
                            ))
                        .toList(),
                    value: applicant.provinceController,
                    onChanged: (String? value) {
                      setState(() {
                        applicant.provinceController = value;
                        applicant.townController = null;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: applicant.provinceController == null
                                  ? Colors.red
                                  : Colors.grey,
                              width: 1),
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
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
                      applicant.townController != null
                          ? applicant.townController.toString()
                          : 'Select Town',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: AppColors.neutral,
                        height: .5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: applicant.provinceController != null
                        ? townsByProvince[applicant.provinceController!]!
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
                    value: applicant.townController,
                    onChanged: (String? value) {
                      setState(() {
                        applicant.townController = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: applicant.townController == null &&
                                      applicant.townController == null
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
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    fetchData(widget.id);
  }

  Future<void> _selectDate(
      BuildContext context, ApplicantDetails applicant) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastAllowedDate =
        currentDate.subtract(Duration(days: 18 * 365));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastAllowedDate,
      firstDate: DateTime(1900),
      lastDate: lastAllowedDate,
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked!);
        applicant.dobController.text = formattedDate;
      });
    } else {
      // Handle the case where the selected date is not within the allowed range
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a date within the last 18 years.'),
        ),
      );
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
      print('Town: ${applicants[i].townController}');
      print('Province: ${applicants[i].provinceController}');
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

  bool validateOwnership(List<ApplicantDetails> applicants) {
    for (int i = 0; i < numberOfPersons; i++) {
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
    for (int i = 0; i < numberOfPersons; i++) {
      String? gender = applicants[i].gender;

      if (gender == null || (gender != 'Male' && gender != 'Female')) {
        // Gender is either null or not a valid value (neither "Male" nor "Female")
        return false;
      }
    }

    // All genders are either "Male" or "Female"
    return true;
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

  // Function to fetch data from the API using dio with Bearer token
  Future<void> fetchData(int? requestId) async {
    try {
      Dio dio = Dio();

      // Replace 'YOUR_BEARER_TOKEN' with the actual Bearer token
      String bearertoken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzODcyMzMwfQ.iPcNkG8k85wfMowp1cleF4VmzcdP-ftuBHhZbliDcik';
      dio.options.headers['Authorization'] = 'Bearer $bearertoken';

      final response = await dio.get(
        'https://loan-managment.onrender.com/loan_requests/$requestId',
        // Add headers or parameters as needed
      );

      if (response.statusCode == 200) {
        final loanDetail = LoanRequestDetails.fromJson(response.data);
        // print(response.data);

        setState(() {
          // Move this block here
          this.loanDetail = loanDetail;

          for (int i = 0; i < loanDetail.applicantCount; i++) {
            applicants[i].surnameController.text =
                loanDetail.applicants[i].surname;
            applicants[i].middleNameController.text =
                loanDetail.applicants[i].middleName;
            applicants[i].firstNameController.text =
                loanDetail.applicants[i].firstName;
            applicants[i].dobController.text = loanDetail.applicants[i].dob;
            applicants[i].nrcController.text = loanDetail.applicants[i].nrc;
            applicants[i].telephoneController.text =
                loanDetail.applicants[i].telephone;
            applicants[i].mobileController.text =
                loanDetail.applicants[i].mobile;
            applicants[i].emailController.text = loanDetail.applicants[i].email;
            applicants[i].licenseNumberController.text =
                loanDetail.applicants[i].licenseNumber;
            applicants[i].licenseExpiryController.text =
                loanDetail.applicants[i].licenseExpiry;
            applicants[i].residentialAddressController.text =
                loanDetail.applicants[i].residentialAddress;
            applicants[i].postalAddressController.text =
                loanDetail.applicants[i].postalAddress;
            applicants[i].howlongthisplaceController.text =
                loanDetail.applicants[i].howlongthisplace;

            applicants[i].provinceController =
                loanDetail.applicants[i].province;
            applicants[i].townController = loanDetail.applicants[i].town;

            applicants[i].gender = loanDetail.applicants[i].gender;
            applicants[i].ownership = loanDetail.applicants[i].ownership;
          }
        });
        widget.myTabController.updateApplicants(applicants);
        widget.myTabController.notifyListeners();
      } else {
        // Handle error response
        print('eeee: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Errrrror: $error');
    }
  }

  void sendPatchRequest(int id) async {
    // Replace 'your_api_endpoint' with the actual endpoint you want to patch
    var apiUrl = 'https://loan-managment.onrender.com/loan_requests/$id';

    // Replace 'your_bearer_token' with the actual Bearer token you need
    var bearerToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzODcyMzMwfQ.iPcNkG8k85wfMowp1cleF4VmzcdP-ftuBHhZbliDcik';

    // Replace the following map with the data you want to send in the patch request

    var patchData = <String, dynamic>{};

    for (int i = 1; i <= loanDetail.applicantCount; i++) {
      patchData['applicants_attributes'] = {
        'surname': applicants[i].surnameController.text,
        'middleName': applicants[i].middleNameController.text,
        'firstName': applicants[i].firstNameController.text,
        'dob': applicants[i].dobController.text,
        'nrc': applicants[i].nrcController.text,
        'telephone': applicants[i].telephoneController.text,
        'mobile': applicants[i].mobileController.text,
        'email': applicants[i].emailController.text,
        'licenseNumber': applicants[i].licenseNumberController.text,
        'licenseExpiry': applicants[i].licenseExpiryController.text,
        'residentialAddress': applicants[i].residentialAddressController.text,
        'postalAddress': applicants[i].postalAddressController.text,
        'howLongThisPlace': applicants[i].howlongthisplaceController.text,
        'town': applicants[i].selectedtown,
        'province': applicants[i].selectedprovince,
        'gender': applicants[i].gender,
        'ownership': applicants[i].ownership,
      };
    }
    print(patchData);
    try {
      var dio = Dio();

      var response = await dio.patch(
        apiUrl,
        data: patchData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('PATCH request successful');
        print('Response: ${response.data}');
      } else {
        print(
            'Failed to send PATCH request. Status code: ${response.statusCode}');
        print('Response: ${response.data}');
      }
    } catch (error) {
      print('Error sending PATCH request: $error');
    }
  }
}
