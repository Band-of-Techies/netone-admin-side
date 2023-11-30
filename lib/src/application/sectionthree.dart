// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, sort_child_properties_last

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:provider/provider.dart';

class SectionThree extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  SectionThree(this.myTabController, this._tabController);

  @override
  State<SectionThree> createState() => _SectionThreeState();
}

class _SectionThreeState extends State<SectionThree> {
  LoanDetails loadndetails = LoanDetails();
  final _formKey = GlobalKey<FormState>();
  bool canAgreePersonOne = false;
  bool canAgreePersonTwo = false;
  bool canAgreePersonThree = false;
  bool canAgreePersonFour = false;
  XFile? pickedImageOne;
  XFile? pickedImageTwo;
  XFile? pickedImageThree;
  XFile? pickedImageFour;
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final myTabController = Provider.of<MyTabController>(context);
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                child: Column(
                  children: [
                    section3A(),
                    SizedBox(
                      height: 30,
                    ),
                    loandetails(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Affirmations',
                      style: GoogleFonts.dmSans(
                          color: AppColors.neutral,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20),
                    affirmationsection(canAgreePersonOne, pickedImageOne,
                        'For First Applicant'),
                    if (widget.myTabController.numberOfPersons > 1)
                      affirmationsection(canAgreePersonTwo, pickedImageTwo,
                          'For Second Applicant'),
                    if (widget.myTabController.numberOfPersons > 2)
                      affirmationsection(canAgreePersonThree, pickedImageThree,
                          'For Third Applicant'),
                    if (widget.myTabController.numberOfPersons > 3)
                      affirmationsection(canAgreePersonFour, pickedImageFour,
                          'For Fourth Applicant'),
                    SizedBox(height: 40),
                    /*  Text(
                  'Supporting Documentation Submitted, loadndetails are advised to attach the following documents',
                  style: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),*/
                    //DocumentTable(),
                  ],
                ),
              ),
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
                          myTabController.loanDetails = loadndetails;
                          //printApplicantDetails();
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
                          myTabController.loanDetails = loadndetails;
                          //printApplicantDetails();
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

  Column affirmationsection(bool canagree, XFile? pickedImage, String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Text(
          '''I (full name) hereby confirm that the information provided by me in this loan application, including my source of funds put forward for partial/full finance of asset is true and correct and I have the capacity to repay the loan. I understand that this Loan Application may be declined at any stage should any information contained herein be found to be incorrect or misleading in any material way. I consent to PSMFC making enquiries regarding my credit history with any Credit Reference Bureau or Credit Rating Agency and for PSMFC to share my payment behaviour with any Credit Reference Bureau or Credit Reference Agency and any other institution that it may require to do so in order to assess my application or by applicable laws or regulation. I consent to PSMFC reporting the conclusion of any credit agreement in compliance with the Zambian legislation.''',
          style: GoogleFonts.dmSans(
              color: AppColors.neutral,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Upload Image',
              style: GoogleFonts.dmSans(
                  color: AppColors.neutral,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 30),
            pickedImage == null
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainColor),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    onPressed: () async {
                      final XFile? image = await _imagePicker.pickImage(
                          source: ImageSource.gallery);

                      if (image != null) {
                        setState(() {
                          pickedImage = image;
                        });
                      }
                    },
                    child: Text(
                      'Pick Image',
                      style: GoogleFonts.dmSans(
                          color: AppColors.neutral,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Image.file(File(pickedImage!.path)),
          ],
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                    AppColors.neutral, // Set your desired border color
              ),
              child: Checkbox(
                value: canagree,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      canagree = value;
                    });
                  }
                },
              ),
            ),
            Text(
              'I agree to all the information provided',
              style: GoogleFonts.dmSans(
                  color: AppColors.neutral,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Row loandetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount applied',
                style: GoogleFonts.dmSans(
                    color: AppColors.neutral,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              FormTextField(
                controller: loadndetails.costofasset,
                labelText: 'Total cost of asset',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total cost of asset';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.insurancecost,
                labelText: 'Total Insurance cost',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total insurance cost';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.advancepayment,
                labelText: 'Less advance payment',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter less advance payment';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.loanamaountapplied,
                labelText: 'Loan amount applied for',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan amount applied for';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.tenure,
                labelText: 'Tenure',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tenure';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share of loadn applied (only asset and agriclute loan',
                style: GoogleFonts.dmSans(
                    color: AppColors.neutral,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              FormTextField(
                controller: loadndetails.firstapplicant,
                labelText: 'First Applicant',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first Applicant';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.thirdapplicant,
                labelText: 'Third Applicant (Agric Asset ONLY)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter third applicant';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.firstapplicantproportion,
                labelText: 'First Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.thirdapplicantpropotion,
                labelText: 'Third Applicant Proportion of loan (%))',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Third Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount applied',
                style: GoogleFonts.dmSans(
                    color: AppColors.neutral,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              FormTextField(
                controller: loadndetails.secondapplicant,
                labelText: 'Second Applicant',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Second Applicant';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.fourthapplicant,
                labelText: 'Fourth Applicant (Agric Asset ONLY)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fourth Applicant (Agric Asset ONLY)';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.secondapplicantpropotion,
                labelText: 'Second Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Second Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.fourthapplicantpropotion,
                labelText: 'SFourth Applicant Proportion of loan (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fourth Applicant Proportion of loan (%)';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column section3A() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Product Apllied for (Tick only one)',
          style: GoogleFonts.dmSans(
              color: AppColors.neutral,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 8.0, // Adjust the spacing between items
          runSpacing: 8.0, // Adjust the spacing between lines
          children: [
            buildCheckBox('Motor Vehicle Loan'),
            buildCheckBox('Agricultural Asset Loan'),
            buildCheckBox('Furniture Loan'),
            buildCheckBox('Building Materials Loan'),
            buildCheckBox('Bring your Own Device Loan'),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        TextFormField(
          controller: loadndetails.descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
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
                  BorderSide(color: AppColors.mainbackground, width: 1.0),
            ),
          ),
          style: GoogleFonts.dmSans(
            color: AppColors.neutral,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 3,
          validator: (value) {},
        )
      ],
    );
  }

  Widget buildCheckBox(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          loadndetails.selectedLoanOption = option;
        });
      },
      child: Chip(
        padding: EdgeInsets.all(12),
        label: Text(
          option,
          style: GoogleFonts.dmSans(
              color: loadndetails.selectedLoanOption == option
                  ? AppColors.neutral
                  : AppColors.neutral,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: loadndetails.selectedLoanOption == option
            ? AppColors.mainColor // Change the color when selected
            : AppColors.sidebarbackground,
      ),
    );
  }
}

class DocumentTable extends StatelessWidget {
  final double rowHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 16,
          columns: [
            DataColumn(label: Text('SN')),
            DataColumn(label: Text('Document')),
            DataColumn(label: Text('First Applicant')),
            DataColumn(label: Text('Second Applicant')),
            DataColumn(label: Text('Third Applicant')),
            DataColumn(label: Text('Fourth Applicant')),
          ],
          rows: List.generate(8, (index) => buildDataRow(index)),
        ),
      ),
    );
  }

  DataRow buildDataRow(int index) {
    return DataRow(cells: [
      DataCell(Container(
        width: 50,
        child: Center(
          child: Text((index + 1).toString()),
        ),
      )),
      DataCell(Container(
        width: 200,
        child: Text(getDocumentName(index)),
      )),
      DataCell(Container(width: 150, child: AttachmentCell())),
      DataCell(Container(width: 150, child: AttachmentCell())),
      DataCell(Container(width: 150, child: AttachmentCell())),
      DataCell(Container(width: 150, child: AttachmentCell())),
    ]);
  }

  static String getDocumentName(int index) {
    switch (index) {
      case 0:
        return "Introduction letter from employer";
      case 1:
        return "Certified Copies of three latest payslips";
      case 2:
        return "Certified Copy of National Registration Card (NRC)";
      case 3:
        return "Certified copy of valid driver's license (if any)";
      case 4:
        return "Valid quotation from the asset dealer";
      case 5:
        return "Stamped copy of previous month's bank statement";
      case 6:
        return "Pre-signed and undated 'STOP ORDER' instruction to your bank where you hold the salaries account";
      case 7:
        return "Proof of marriage (Motor Vehicle Joint Application ONLY))";
      default:
        return "";
    }
  }
}

class AttachmentCell extends StatefulWidget {
  @override
  _AttachmentCellState createState() => _AttachmentCellState();
}

class _AttachmentCellState extends State<AttachmentCell> {
  String fileName = '';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize
            .min, // Use min to allow the column to occupy minimum height
        children: [
          fileName.isEmpty
              ? ElevatedButton(
                  onPressed: _pickFile,
                  child: Text('Pick File'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(90, 30), // Adjust button height as needed
                  ),
                )
              : GestureDetector(
                  onTap: _pickFile,
                  child: Text(fileName),
                ),
        ],
      ),
    );
  }
}
