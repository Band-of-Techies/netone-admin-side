// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, sort_child_properties_last

import 'dart:io';
import 'dart:js' as js;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/products.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:provider/provider.dart';

class SectionThree extends StatefulWidget {
  final MyTabController myTabController;
  late TabController _tabController;

  int? id;
  SectionThree(this.myTabController, this._tabController, this.id);

  @override
  State<SectionThree> createState() => _SectionThreeState();
}

class _SectionThreeState extends State<SectionThree>
    with SingleTickerProviderStateMixin {
  LoanDetails loadndetails = LoanDetails();
  final _formKey = GlobalKey<FormState>();
  late LoanRequestDetails loanDetail;
  XFile? pickedImageOne;
  XFile? pickedImageTwo;
  XFile? pickedImageThree;
  XFile? pickedImageFour;
  List<ProductList> products = [];
  String? productapplied;
  final ImagePicker _imagePicker = ImagePicker();
  List<String> tenureOptions = [
    '3 months',
    '6 months',
    '12 months',
    '18 months',
    '24 months',
    '36 months',
    '48 months',
    '60 months',
    '72 months',
  ];
  List<String>? applicantKeys;
  @override
  Widget build(BuildContext context) {
    final myTabController = Provider.of<MyTabController>(context);
    loadndetails = myTabController.loanDetails;
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: products.isEmpty || products == null
          ? Center(
              child: CircularProgressIndicator(color: AppColors.mainColor),
            )
          : Padding(
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
                          affirmationsection(0, 0),
                          if (widget.myTabController.numberOfPersons > 1)
                            affirmationsection(1, 1),
                          if (widget.myTabController.numberOfPersons > 2)
                            affirmationsection(2, 2),
                          if (widget.myTabController.numberOfPersons > 3)
                            affirmationsection(3, 3),
                          SizedBox(height: 40),
                          /*  Text(
                  'Supporting Documentation Submitted, loadndetails are advised to attach the following documents',
                  style: GoogleFonts.dmSans(
                      color: AppColors.neutral,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),*/
                          // DocumentTable(),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.mainColor),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(15))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              myTabController.loanDetails = loadndetails;
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
    );
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchData(widget.id);
  }

  void fetchProducts() async {
    final String apiUrl = 'https://loan-managment.onrender.com/products';

    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        setState(() {
          products =
              responseData.map((data) => ProductList.fromJson(data)).toList();
        });
        ;
      } else {
        // Handle error, show a message, or perform other actions on failure
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error during API call: $error');
    }
  }

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

        //print(response.data);

        setState(() {
          // Move this block here
          this.loanDetail = loanDetail;

          for (int i = 0; i < loanDetail.applicantCount; i++) {
            loadndetails.costofasset.text = loanDetail.costOfAsset;
            loadndetails.insurancecost.text = loanDetail.insuranceCost;
            loadndetails.advancepayment.text = loanDetail.advancePayment;
            loadndetails.loanamaountapplied.text = loanDetail.loanAmount;
            loadndetails.tenure = loanDetail.loanTenure;
            loadndetails.descriptionController.text = loanDetail.description;
            productapplied = response.data['product']['name'];
          }
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

  Column affirmationsection(int applicantkey, int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (loanDetail.applicants.length > applicantkey &&
            loanDetail.applicants[applicantkey].documents.isNotEmpty)
          applicantDocuments(applicantkey, i),
        SizedBox(
          height: 10,
        ),
        if (widget.myTabController.applicants[i].selectedFiles.isNotEmpty)
          Container(
              width: MediaQuery.of(context).size.width * .7,
              height: 120,
              child: Row(
                children: List.generate(
                  widget.myTabController.applicants[i].selectedFiles.length,
                  (index) {
                    var fileBytes = widget
                        .myTabController.applicants[i].selectedFiles[index];
                    var fileName = widget.myTabController.applicants[i]
                        .selectedFilesnames[index];
                    String fileExtension =
                        fileName.split('.').last.toLowerCase();

                    return Container(
                      margin: EdgeInsets.all(10),
                      width: 300,
                      height: 80,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display Image for image files

                              (fileExtension != 'pdf')
                                  ? GestureDetector(
                                      onTap: () {
                                        // Open image in a new tab
                                        final blob =
                                            html.Blob([fileBytes], 'image/*');
                                        final url =
                                            html.Url.createObjectUrlFromBlob(
                                                blob);
                                        html.window.open(url, '_blank');
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.neutral),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.neutral,
                                        ),
                                        child: Image.memory(
                                          fileBytes,
                                          width:
                                              300, // Set the width of the image as per your requirement
                                          height:
                                              50, // Set the height of the image as per your requirement
                                          fit: BoxFit
                                              .cover, // Adjust this based on your image requirements
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        // Open PDF in a new tab
                                        final blob = html.Blob(
                                            [Uint8List.fromList(fileBytes)],
                                            'application/pdf');
                                        final url =
                                            html.Url.createObjectUrlFromBlob(
                                                blob);
                                        html.window.open(url, '_blank');
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.mainColor),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                    ),
                              SizedBox(
                                  height:
                                      8.0), // Add spacing between image and text

                              // Display file name with overflow handling
                              Flexible(
                                child: Text(
                                  fileName,
                                  overflow: TextOverflow.ellipsis,
                                  // Adjust the maximum lines based on your UI requirements
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: AppColors.neutral,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 12,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                // Handle the close icon tap
                                setState(() {
                                  widget.myTabController.applicants[i]
                                      .selectedFiles
                                      .removeAt(index);
                                  widget.myTabController.applicants[i]
                                      .selectedFilesnames
                                      .removeAt(index);
                                });
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: AppColors.mainColor,
                                child: Icon(
                                  Icons.close,
                                  size: 15,
                                  color: AppColors.neutral,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Add Files More Applicant ${i + 1}',
              style: GoogleFonts.dmSans(
                  color: AppColors.neutral,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 30),
            if (widget.myTabController.applicants[i].selectedFiles.length < 3)
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainColor),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                      );

                      if (result != null) {
                        if (result.files.first.size > 1024 * 1024) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('The file size exceeds limit'),
                            ),
                          );
                        } else {
                          setState(() {
                            widget.myTabController.applicants[i].selectedFiles
                                .addAll(
                                    result.files.map((file) => file.bytes!));
                            widget.myTabController.applicants[i]
                                .selectedFilesnames
                                .addAll(result.files.map((file) => file.name));
                          });
                        }
                      }
                    },
                    child: Text(
                      'Pick Files',
                      style: GoogleFonts.dmSans(
                          color: AppColors.neutral,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '** Supported format: PDF or JPEG/PNG, (Max Size: 1MB per File)',
                    style: GoogleFonts.dmSans(
                        color: AppColors.neutral,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(
          height: 30,
        )
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
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Loan Tenure',
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
                  loadndetails.tenure == null
                      ? 'Loan Tenure'
                      : loadndetails.tenure.toString(),
                  style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: AppColors.neutral,
                      fontWeight: FontWeight.w500),
                ),
                items: tenureOptions.map((letter) {
                  return DropdownMenuItem(
                    value: letter,
                    child: Text(
                      letter,
                      style: GoogleFonts.dmSans(color: AppColors.neutral),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    loadndetails.tenure = value.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, color: AppColors.neutral),
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
              if (widget.myTabController.numberOfPersons > 2)
                FormTextField(
                  controller: loadndetails.thirdapplicant,
                  labelText: 'Third Applicant (Agric Asset ONLY)',
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.myTabController.numberOfPersons > 2) {
                      return 'Please enter third applicant';
                    }
                    return null;
                  },
                ),
              if (widget.myTabController.numberOfPersons > 2)
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
              if (widget.myTabController.numberOfPersons > 2)
                FormTextField(
                  controller: loadndetails.thirdapplicantpropotion,
                  labelText: 'Third Applicant Proportion of loan (%))',
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.myTabController.numberOfPersons > 2) {
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
              if (widget.myTabController.numberOfPersons > 1)
                FormTextField(
                  controller: loadndetails.secondapplicant,
                  labelText: 'Second Applicant',
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.myTabController.numberOfPersons > 1) {
                      return 'Second Applicant';
                    }
                    return null;
                  },
                ),
              if (widget.myTabController.numberOfPersons > 1)
                SizedBox(
                  height: 30,
                ),
              if (widget.myTabController.numberOfPersons > 3)
                FormTextField(
                  controller: loadndetails.fourthapplicant,
                  labelText: 'Fourth Applicant (Agric Asset ONLY)',
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.myTabController.numberOfPersons > 3) {
                      return 'Fourth Applicant (Agric Asset ONLY)';
                    }
                    return null;
                  },
                ),
              if (widget.myTabController.numberOfPersons > 3)
                SizedBox(
                  height: 30,
                ),
              if (widget.myTabController.numberOfPersons > 1)
                FormTextField(
                  controller: loadndetails.secondapplicantpropotion,
                  labelText: 'Second Applicant Proportion of loan (%)',
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.myTabController.numberOfPersons > 1) {
                      return 'Second Applicant Proportion of loan (%)';
                    }
                    return null;
                  },
                ),
              if (widget.myTabController.numberOfPersons > 1)
                SizedBox(
                  height: 30,
                ),
              if (widget.myTabController.numberOfPersons > 3)
                FormTextField(
                  controller: loadndetails.fourthapplicantpropotion,
                  labelText: 'Fourth Applicant Proportion of loan (%)',
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.myTabController.numberOfPersons > 3) {
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

  bool isImage(String contentType) {
    return contentType.contains('jpeg') ||
        contentType.contains('jpg') ||
        contentType.contains('webp') ||
        contentType.contains('png');
  }

  Container applicantDocuments(int applicantkey, int i) {
    return Container(
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

  Column section3A() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Loan Product Apllied for :',
              style: GoogleFonts.dmSans(
                  color: AppColors.neutral,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 30,
            ),
            if (productapplied != null)
              Text(
                productapplied!,
                style: GoogleFonts.dmSans(
                    color: AppColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 8.0, // Adjust the spacing between items
          runSpacing: 8.0, // Adjust the spacing between lines
          children: [
            for (int i = 0; i < products.length; i++)
              buildCheckBox(products[i].id, products[i].name, i),
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
              borderSide: BorderSide(color: AppColors.mainColor, width: 1.0),
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

  Widget buildCheckBox(int id, String title, int i) {
    return InkWell(
      onTap: () {
        setState(() {
          loadndetails.selectedLoanOption = id;
          loadndetails.costofasset.text = products[i].price.toString();
        });
      },
      child: Chip(
        padding: EdgeInsets.all(12),
        label: Text(
          title,
          style: GoogleFonts.dmSans(
              color: loadndetails.selectedLoanOption == id
                  ? AppColors.neutral
                  : AppColors.neutral,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: loadndetails.selectedLoanOption == id
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
