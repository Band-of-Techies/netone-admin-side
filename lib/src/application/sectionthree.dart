// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'dart:js' as js;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:netone_loanmanagement_admin/src/application/datas/applicant.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/products.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/editapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isloadiing = true;
  LoanDetails loadndetails = LoanDetails();
  List<ApplicantDetails> applicants = [];
  final _formKey = GlobalKey<FormState>();
  late LoanRequestDetails loanDetail;
  String? prodicutid;
  List<ProductList> products = [];
  String? email;
  String? token;
  List<int> quantity = [];
  List<Categories> categories = [];
  String? categoryName; // Define categoryName as a String variable
  String? categoryId; // Define categoryId as a String variable
  String? prodcutname;
  String? productid;
  List<int> chosenids = [];
  List<int> chosenProductIds = [];
  List<String> chosenProductNames = [];
  double? totalcost = 0;
  List<double> chosenProductPrice = [];
  String? loancategory;

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
    applicants = myTabController.applicants;
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: isloadiing == true
          ? Center(
              child: CircularProgressIndicator(color: AppColors.mainColor),
            )
          : Padding(
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
                            bankDetails(),
                            SizedBox(height: 20),
                            affirmationsection(0, 0, myTabController),
                            if (widget.myTabController.numberOfPersons > 1)
                              affirmationsection(1, 1, myTabController),
                            if (widget.myTabController.numberOfPersons > 2)
                              affirmationsection(2, 2, myTabController),
                            if (widget.myTabController.numberOfPersons > 3)
                              affirmationsection(3, 3, myTabController),
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
                              updateData(widget.id!, myTabController,
                                  loanDetail.applicantCount);
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
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchData(widget.id);
  }

  void fetchCategories() async {
    final String apiUrl = 'https://loan-managment.onrender.com/categories';

    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(headers: {
          // Add any custom headers if needed

          // Add CORS headers to the request
          'Access-Control-Allow-Origin': '*', // Or specify a specific origin
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;

        setState(() {
          categories =
              responseData.map((data) => Categories.fromJson(data)).toList();
        });
        ;
      } else {
        // Handle error, show a message, or perform other actions on failure
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error during API call: $error');
    }
  }

  void fetchProducts(String id) async {
    final String apiUrl =
        'https://loan-managment.onrender.com/products?category_id=$id';

    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        options: Options(headers: {
          // Add any custom headers if needed
          // Add CORS headers to the request
          'Access-Control-Allow-Origin': '*', // Or specify a specific origin
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization, X-Requested-With',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        print(response.data);

        // Parse the list of products
        List<ProductList> parsedProducts = [];

        for (var item in responseData) {
          parsedProducts.add(ProductList.fromJson(item));
        }

        setState(() {
          products = parsedProducts;
        });
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
          for (int j = 0; j < loanDetail.requestedProducts.length; j++) {
            if (!loadndetails.chosenProductIds
                .contains(loanDetail.requestedProducts[j].productId)) {
              loadndetails.chosenProductNames
                  .add(loanDetail.requestedProducts[j].productName);

              loadndetails.chosenProductIds
                  .add(loanDetail.requestedProducts[j].productId);

              loadndetails.quantity
                  .add(loanDetail.requestedProducts[j].quantity);
            }
            if (!chosenProductIds
                .contains(loanDetail.requestedProducts[j].productId)) {
              chosenProductNames
                  .add((loanDetail.requestedProducts[j].productName));
              chosenids.add(loanDetail.requestedProducts[j].id);
              chosenProductIds.add(loanDetail.requestedProducts[j].productId);
              quantity.add(loanDetail.requestedProducts[j].quantity);
            }
          }
          loadndetails.loancategory = loanDetail.category.name;
          loadndetails.totalcost = double.parse(loanDetail.original_total_cost);
          totalcost = double.parse(loanDetail.original_total_cost);
          loadndetails.costofasset.text = loanDetail.original_total_cost;
          loadndetails.insurancecost.text = loanDetail.insuranceCost;
          loadndetails.advancepayment.text = loanDetail.advancePayment;
          loadndetails.loanamaountapplied.text = loanDetail.loanAmount;
          loadndetails.tenure = loanDetail.loanTenure;
          loadndetails.descriptionController.text = loanDetail.description;
          loadndetails.bankname.text = loanDetail.bankname;

          loadndetails.branchname.text = loanDetail.branchname;
          loadndetails.sortcode.text = loanDetail.sortcode;
          loadndetails.accountnumber.text = loanDetail.accnumber;
          loadndetails.nameandbankaddress.text = loanDetail.banknameandaddress;

          for (int i = 0; i < loanDetail.applicantCount; i++) {
            applicants[i].applicantid = loanDetail.applicants[i].id;
            applicants[i].loanapplicantname.text =
                loanDetail.applicants[i].loansharename;
            applicants[i].loanapplicantpercentage.text =
                loanDetail.applicants[i].loansharepercent;
          }
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

  Wrap viewAllFiles(List<Document> allfiles, String title) {
    return Wrap(
      children: List.generate(
        allfiles.length,
        (index) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 300,
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Image for image files
                    isImage(allfiles[index].contentType)
                        ? GestureDetector(
                            onTap: () {
                              String imageUrl = allfiles[index].url;
                              js.context.callMethod('open', [imageUrl]);
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.mainbackground),
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.neutral,
                              ),
                              child: Image.network(
                                allfiles[index].url,
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
                                      border:
                                          Border.all(color: AppColors.neutral),
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
                        : allfiles[index].contentType.contains('pdf')
                            ? GestureDetector(
                                onTap: () {
                                  String pdfUrl = allfiles[index].url;
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
                                  border: Border.all(color: AppColors.neutral),
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

                    SizedBox(height: 8.0), // Add spacing between image and text

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
              ),
              Positioned(
                top: 12,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    // Handle the close icon tap

                    showDeleteConfirmationDocs(context, widget.id.toString()!,
                        allfiles[index].id.toString(), title);
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.mainbackground,
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void showDeleteConfirmationDocs(
      BuildContext context, String id, String documentId, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.mainbackground,
          title: CustomText(
            text: 'Delete File',
            color: AppColors.mainColor,
            fontSize: 18,
          ),
          content: CustomText(
            text: 'Are you sure you want to delete $title',
            fontSize: 15,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainbackground),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(15, 5, 15, 5))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: CustomText(
                      text: 'Close',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(15, 5, 15, 5))),
                    onPressed: () {
                      deleteAttachment(id, documentId);
                      Navigator.pop(context);
                    },
                    child: CustomText(
                      text: 'Delete',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
          ],
        );
      },
    );
  }

  Column affirmationsection(
      int applicantkey, int i, MyTabController myTabController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (loanDetail.applicants.length > applicantkey &&
            loanDetail.applicants[applicantkey].documents.isNotEmpty)
          applicantDocuments(applicantkey, i),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.myTabController.applicants[i].selectedFiles.isNotEmpty)
              Container(
                  child: Wrap(
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
            /*  Row(
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
                if (widget.myTabController.applicants[i].selectedFiles.length <
                    10)
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.mainColor),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15))),
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
                                widget
                                    .myTabController.applicants[i].selectedFiles
                                    .addAll(result.files
                                        .map((file) => file.bytes!));
                                widget.myTabController.applicants[i]
                                    .selectedFilesnames
                                    .addAll(
                                        result.files.map((file) => file.name));
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
                      SizedBox(
                        width: 20,
                      ),
                      /* if (widget
                      .myTabController.applicants[i].selectedFiles.isNotEmpty)
                    SizedBox(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.mainColor),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(15))),
                          onPressed: () {
                            // updateFiles(widget.id, myTabController, i);
                          },
                          child: CustomText(
                            text: 'Add Files',
                            color: AppColors.neutral,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ),*/
                    ],
                  ),
              ],
            ),*/
          ],
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //signature
            uploadtitles(
                'Signature - Only PNG/JPEG - Signature in white background'),
            SizedBox(
              height: 10,
            ),
            // viewAllFiles(loanDetail.applicants[i].signature);
            Container(
              margin: EdgeInsets.all(10),
              width: 300,
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Image for image files
                  GestureDetector(
                    onTap: () {
                      String imageUrl = loanDetail.applicants[i].signature.url;
                      js.context.callMethod('open', [imageUrl]);
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainbackground),
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.neutral,
                      ),
                      child: Image.network(
                        loanDetail.applicants[i].signature.url,
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
                              border: Border.all(color: AppColors.neutral),
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
                  ),

                  // Display file name with overflow handling
                  Flexible(
                    child: Text(
                      'Signature  ${i + 1}',

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
            ),

            Wrap(
              children: [
                if (widget.myTabController.applicants[i].signature.isNotEmpty)
                  viewFiles(widget.myTabController.applicants[i].signature,
                      widget.myTabController.applicants[i].signatureName),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            pickSignatureWidget(widget.myTabController.applicants[i].signature,
                widget.myTabController.applicants[i].signatureName, context),
            SizedBox(
              height: 20,
            ),
            //one
            uploadtitles('Payslip - 1'),
            SizedBox(
              height: 10,
            ),
            viewAllFiles(loanDetail.applicants[i].payslip1, 'Payslip 1'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].paysliponeFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].paysliponeFiles,
                      widget.myTabController.applicants[i].paysliponeFileNames),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].paysliponeFiles,
              widget.myTabController.applicants[i].paysliponeFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            //two

            uploadtitles('Payslip - 2'),
            SizedBox(
              height: 10,
            ),
            viewAllFiles(loanDetail.applicants[i].payslip2, 'Payslip 2'),
            SizedBox(
              height: 10,
            ),

            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].paysliptwoFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].paysliptwoFiles,
                      widget.myTabController.applicants[i].paysliptwoFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].paysliptwoFiles,
              widget.myTabController.applicants[i].paysliptwoFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('Payslip - 3'),
            SizedBox(
              height: 10,
            ),
            viewAllFiles(loanDetail.applicants[i].payslip3, 'Payslip 3'),
            SizedBox(
              height: 10,
            ),

            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].payslipthreeFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].payslipthreeFiles,
                      widget
                          .myTabController.applicants[i].payslipthreeFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].payslipthreeFiles,
              widget.myTabController.applicants[i].payslipthreeFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('Introductory Letter from Employer'),
            SizedBox(
              height: 10,
            ),
            viewAllFiles(
                loanDetail.applicants[i].intoletter, 'Introductory Letter'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget
                    .myTabController.applicants[i].intodletterFiles.isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].intodletterFiles,
                      widget
                          .myTabController.applicants[i].introletterFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].intodletterFiles,
              widget.myTabController.applicants[i].introletterFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('Bank Statement'),
            SizedBox(
              height: 10,
            ),
            viewAllFiles(
                loanDetail.applicants[i].bankstatemtn, 'Bank Statement'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget.myTabController.applicants[i].bankStatementFiles
                    .isNotEmpty)
                  viewFiles(
                      widget.myTabController.applicants[i].bankStatementFiles,
                      widget.myTabController.applicants[i]
                          .bankStatementFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].bankStatementFiles,
              widget.myTabController.applicants[i].bankStatementFileNames,
            ),
            SizedBox(
              height: 20,
            ),

            uploadtitles('NRC'),
            SizedBox(
              height: 10,
            ),
            viewAllFiles(loanDetail.applicants[i].nrccopy, 'NRC Copy'),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                if (widget.myTabController.applicants[i].nrcFiles.isNotEmpty)
                  viewFiles(widget.myTabController.applicants[i].nrcFiles,
                      widget.myTabController.applicants[i].nrcFileNames),
              ],
            ),
            pickFilesWidget(
              widget.myTabController.applicants[i].nrcFiles,
              widget.myTabController.applicants[i].nrcFileNames,
            ),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  ElevatedButton pickSignatureWidget(
    List<Uint8List> selectedFiles,
    List<String> selectedFilesnames,
    BuildContext context,
  ) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              AppColors.mainColor), // Use appropriate color
          padding: MaterialStateProperty.all(EdgeInsets.all(15))),
      onPressed: () async {
        if (selectedFiles.length < 1) {
          await _pickAndCropImage(selectedFiles, selectedFilesnames, context);
        } else {
          // warning('Only one file can be attached, remove to add new');
        }
      },
      child: Text(
        'Pick Signature',
        style: GoogleFonts.dmSans(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Future<void> _pickAndCropImage(
    List<Uint8List> selectedFiles,
    List<String> selectedFilesnames,
    BuildContext context,
  ) async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) async {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsDataUrl(files[0]);
        reader.onError.listen((error) => setState(() {
              // Handle error
            }));

        reader.onLoad.first.then((_) async {
          final imageBytes = reader.result as String?;
          if (imageBytes != null) {
            final croppedImage = await cropImage(imageBytes, context);
            if (croppedImage != null) {
              print('Start');

              print('End');
              if (croppedImage != null) {
                print(12);
                setState(() {
                  selectedFiles.add(croppedImage);
                  selectedFilesnames.add('Signature');
                });
                // Save the cropped image to storage
                // Implement your storage saving logic here
              }
            }
          }
        });
      }
    });
  }

  Future<Uint8List?> cropImage(String imageBytes, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageBytes,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      uiSettings: [
        WebUiSettings(
          context: context,
          enableZoom: true,
          showZoomer: true,
          mouseWheelZoom: true,
          viewPort: CroppieViewPort(height: 200, width: 500, type: 'Rectangle'),
        ),
      ],
    );
    if (croppedFile != null) {
      return croppedFile.readAsBytes();
    } else {
      return null;
    }
  }

  Container viewFiles(List<Uint8List> files, List<String> fileNames) {
    return Container(
        width: MediaQuery.of(context).size.width * .9,
        child: Wrap(
          children: List.generate(
            files.length,
            (index) {
              var fileBytes = files[index];
              var fileName = fileNames[index];
              String fileExtension = fileName.split('.').last.toLowerCase();

              return Container(
                margin: EdgeInsets.all(10),
                width: 300,
                height: 60,
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
                                      html.Url.createObjectUrlFromBlob(blob);
                                  html.window.open(url, '_blank');
                                },
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.mainbackground),
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.mainbackground,
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
                                      html.Url.createObjectUrlFromBlob(blob);
                                  html.window.open(url, '_blank');
                                },
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.mainColor),
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
                              ),
                        SizedBox(
                            height: 8.0), // Add spacing between image and text

                        // Display file name with overflow handling
                        Flexible(
                          child: Text(
                            fileName,
                            overflow: TextOverflow.ellipsis,
                            // Adjust the maximum lines based on your UI requirements
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
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
                            files.removeAt(index);
                            fileNames.removeAt(index);
                          });
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.mainbackground,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }

  ElevatedButton pickFilesWidget(
      List<Uint8List> selectedFiles, List<String> selectedFilesnames) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
          padding: MaterialStateProperty.all(EdgeInsets.all(15))),
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
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
            if (selectedFiles.length < 3) {
              setState(() {
                selectedFiles.addAll(result.files.map((file) => file.bytes!));
                selectedFilesnames
                    .addAll(result.files.map((file) => file.name));
              });
            } else {
              warning('Maximum three files, remove files to add new');
            }
          }
        }
      },
      child: Text(
        'Upload',
        style: GoogleFonts.dmSans(
            color: AppColors.neutral,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Text uploadtitles(String title) {
    return Text(
      title,
      style: GoogleFonts.dmSans(
          decoration: TextDecoration.underline,
          color: AppColors.neutral,
          fontSize: 14,
          fontWeight: FontWeight.w700),
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
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can only contain numbers';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.insurancecost,
                labelText: 'Total Insurance cost',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can contain only digits';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.advancepayment,
                labelText: 'Less advance payment',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can contain only digits';
                    }
                  }
                  return null; // Return null to indicate no error
                },
              ),
              SizedBox(
                height: 30,
              ),
              FormTextField(
                controller: loadndetails.loanamaountapplied,
                labelText: 'Loan amount applied for',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validate if the value contains only numbers
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Can contain only digits';
                    }
                  }
                  return null; // Return null to indicate no error
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
                controller: applicants[0].loanapplicantname,
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
                  controller: applicants[2].loanapplicantname,
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
                controller: applicants[0].loanapplicantpercentage,
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
                  controller: applicants[2].loanapplicantpercentage,
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
                  controller: applicants[1].loanapplicantname,
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
                  controller: applicants[3].loanapplicantname,
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
                  controller: applicants[1].loanapplicantpercentage,
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
                  controller: applicants[3].loanapplicantpercentage,
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

  Container bankDetails() {
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Bank Details - Applicant 1',
              style: GoogleFonts.dmSans(
                  color: AppColors.mainColor,
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
                    controller: loadndetails.bankname,
                    labelText: 'Bank Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Bank Name';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                        return 'Invalid Bank Name';
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
                    controller: loadndetails.branchname,
                    labelText: 'Branch Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Branch Name';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                        return 'Invalid Branch Name';
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
                    controller: loadndetails.sortcode,
                    labelText: 'Sortcode',
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                          return 'Invalid Sortcode';
                        }
                        if (value.length > 6) {
                          return 'Maximum length is 6 digits';
                        }
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
                    controller: loadndetails.accountnumber,
                    labelText: 'Bank Account Number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Bank Acc No';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                        return 'Invalid Account Number';
                      }
                      if (value.length > 13) {
                        return 'Maximum length is 13 digits';
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
            FormTextField(
              controller: loadndetails.nameandbankaddress,
              labelText: 'Bank Name and Full Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Bank Name and full address';
                }
                if (value.length < 5) {
                  return 'Bank Name and address should have at least 5 characters';
                }
                return null;
              },
            ),
          ]),
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
              'Loan Category Applied for : ${loadndetails.loancategory}',
              style: GoogleFonts.dmSans(
                  color: AppColors.neutral,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),

            //
          ],
        ),
        SizedBox(
          height: 20,
        ),
        /* for (int i = 0; i < chosenProductIds.length; i++)
          Column(
            children: [
              if (i < chosenProductNames.length)
                Row(
                  children: [
                    Text(
                      ' ${loadndetails.chosenProductNames[i]} - QTY: ${loadndetails.quantity[i]}',
                      style: GoogleFonts.dmSans(
                        color: AppColors.mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          showDeleteConfirmationDialog(context,
                              loadndetails.chosenProductIds[i], widget.id!);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.primary,
                        ))
                  ],
                ),
            ],
          ),*/
        SizedBox(
          height: 20,
        ),
        /* Row(
          children: [
            SizedBox(
              width: 400,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<Categories>(
                  isExpanded: true,
                  hint: Text(
                    categoryName ?? 'Choose Category',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: AppColors.neutral,
                      height: .5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name,
                        style: GoogleFonts.dmSans(color: AppColors.mainColor),
                      ),
                    );
                  }).toList(),
                  value: categoryName != null
                      ? categories.firstWhere(
                          (element) => element.name == categoryName,
                          orElse: () => categories.first,
                        )
                      : null,
                  onChanged: (Categories? value) {
                    setState(() {
                      loancategory = value!.name;
                      categoryName = value.name;
                      categoryId = value.id.toString();
                      fetchProducts(categoryId!);
                      chosenProductIds = [];
                      chosenProductNames = [];
                      quantity = [];
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.mainbackground,
                      border: Border.all(
                        color: categoryName == null ? Colors.red : Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            if (products.isNotEmpty)
              SizedBox(
                width: 400,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<ProductList>(
                    isExpanded: true,
                    hint: Text(
                      prodcutname ?? 'Choose Product',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: AppColors.neutral,
                        height: .5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: products.map((product) {
                      return DropdownMenuItem(
                        value: product,
                        child: Text(
                          product.name,
                          style: GoogleFonts.dmSans(color: AppColors.primary),
                        ),
                      );
                    }).toList(),
                    value: prodcutname != null
                        ? products.firstWhere(
                            (element) => element.name == prodcutname,
                            orElse: () => products.first,
                          )
                        : null,
                    onChanged: (ProductList? value) {
                      setState(() {
                        if (!chosenProductIds.contains(value!.id)) {
                          chosenProductIds.add(value.id);
                          chosenProductNames.add(value.name);
                          quantity.add(1);
                          chosenProductPrice.add(value.price);
                          totalcost = totalcost! + value.price;
                          loadndetails.costofasset.text = totalcost.toString();
                        }
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.mainbackground,
                        border: Border.all(
                          color:
                              categoryName == null ? Colors.red : Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),*/
        SizedBox(
          height: 30,
        ),
        if (chosenProductIds.isNotEmpty)
          for (int i = 0; i < chosenProductIds.length; i++)
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      chosenProductNames[i],
                      style: GoogleFonts.dmSans(
                        color: AppColors.neutral,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 50),
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity[i] > 1) {
                              quantity[i] = quantity[i] - 1;
                              print(quantity[i]);
                              //  totalcost = totalcost! - chosenProductPrice[i];
                              loadndetails.costofasset.text =
                                  totalcost.toString();
                              updateQuantity(widget.id!, quantity[i],
                                  chosenProductIds[i], chosenids[i]);
                            }
                          });
                        },
                        icon: Icon(Icons.minimize_sharp),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      quantity[i].toString(),
                      style: GoogleFonts.dmSans(
                        color: AppColors.neutral,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity[i] < 10) {
                              quantity[i] = quantity[i] + 1;

                              //   totalcost = totalcost! + chosenProductPrice[i];
                              loadndetails.costofasset.text =
                                  totalcost.toString();
                              updateQuantity(widget.id!, quantity[i],
                                  chosenProductIds[i], chosenids[i]);
                            }
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        showDeleteConfirmationDialog(
                            context, chosenids[i], widget.id!);
                        setState(() {
                          double approxcost =
                              chosenProductPrice[i] * quantity[i];

                          loadndetails.costofasset.text =
                              (totalcost! - approxcost).toString();
                          chosenProductNames.removeAt(i);
                          quantity.removeAt(i);
                          chosenProductIds.removeAt(i);
                          chosenids.removeAt(i);
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
        SizedBox(
          height: 40,
        ),
        /*  if (prodicutid != null)
          SizedBox(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.mainColor),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                onPressed: () {
                  updateProduct(prodicutid!);
                },
                child: CustomText(
                  text: 'Update',
                  color: AppColors.neutral,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
          ),
        SizedBox(
          height: 40,
        ),*/
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

  Future<void> updateData(
      int? id, MyTabController myTabController, int persons) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    final String apiUrl =
        'https://loan-managment.onrender.com/loan_requests/$id';

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
      String accessToken = token!;

      for (int i = 0; i < persons; i++) {
        // Add other applicant data to the request
        request.fields['loan_request[applicants_attributes][$i][id]'] =
            myTabController.applicants[i].applicantid.toString();
        request.fields[
                'loan_request[applicants_attributes][$i][loan_share_name]'] =
            myTabController.applicants[i].loanapplicantname.text;
        request.fields[
                'loan_request[applicants_attributes][$i][loan_share_percent]'] =
            myTabController.applicants[i].loanapplicantpercentage.text;
        if (widget.myTabController.applicants[i].paysliponeFiles.isNotEmpty) {
          for (var file
              in widget.myTabController.applicants[i].paysliponeFiles) {
            request.files.add(http.MultipartFile(
              'loan_request[applicants_attributes][$i][payslip_1][]',
              http.ByteStream.fromBytes(file),
              file.length,
              filename: 'file$i.jpg', // Provide a filename here
              contentType: MediaType('application', 'octet-stream'),
            ));
          }
        }

        //payslip2
        if (widget.myTabController.applicants[i].paysliptwoFiles.isNotEmpty) {
          for (var file
              in widget.myTabController.applicants[i].paysliptwoFiles) {
            request.files.add(http.MultipartFile(
              'loan_request[applicants_attributes][$i][payslip_2][]',
              http.ByteStream.fromBytes(file),
              file.length,
              filename: 'file$i.jpg', // Provide a filename here
              contentType: MediaType('application', 'octet-stream'),
            ));
          }
        }

        //payslip3
        if (widget.myTabController.applicants[i].payslipthreeFiles.isNotEmpty) {
          for (var file
              in widget.myTabController.applicants[i].payslipthreeFiles) {
            request.files.add(http.MultipartFile(
              'loan_request[applicants_attributes][$i][payslip_3][]',
              http.ByteStream.fromBytes(file),
              file.length,
              filename: 'file$i.jpg', // Provide a filename here
              contentType: MediaType('application', 'octet-stream'),
            ));
          }
        }
        if (widget.myTabController.applicants[i].intodletterFiles.isNotEmpty) {
          //intro_letter print(1);
          for (var file
              in widget.myTabController.applicants[i].intodletterFiles) {
            request.files.add(http.MultipartFile(
              'loan_request[applicants_attributes][$i][intro_letter][]',
              http.ByteStream.fromBytes(file),
              file.length,
              filename: 'file$i.jpg', // Provide a filename here
              contentType: MediaType('application', 'octet-stream'),
            ));
          }
        }

        //bank_statement
        if (widget
            .myTabController.applicants[i].bankStatementFiles.isNotEmpty) {
          for (var file
              in widget.myTabController.applicants[i].bankStatementFiles) {
            request.files.add(http.MultipartFile(
              'loan_request[applicants_attributes][$i][bank_statement][]',
              http.ByteStream.fromBytes(file),
              file.length,
              filename: 'file$i.jpg', // Provide a filename here
              contentType: MediaType('application', 'octet-stream'),
            ));
          }
        }

        //bank_statement
        if (widget.myTabController.applicants[i].nrcFiles.isNotEmpty) {
          for (var file in widget.myTabController.applicants[i].nrcFiles) {
            request.files.add(http.MultipartFile(
              'loan_request[applicants_attributes][$i][nrc_copy][]',
              http.ByteStream.fromBytes(file),
              file.length,
              filename: 'file$i.jpg', // Provide a filename here
              contentType: MediaType('application', 'octet-stream'),
            ));
          }
        }
        if (widget.myTabController.applicants[i].signature.isNotEmpty) {
          var file = widget.myTabController.applicants[i].signature[0];
          request.files.add(http.MultipartFile(
            'loan_request[applicants_attributes][$i][signature]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'signature.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }
      }
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['loan_request[description]'] =
          myTabController.loanDetails.descriptionController.text;
      request.fields['loan_request[cost_of_asset]'] =
          myTabController.loanDetails.costofasset.text;
      request.fields['loan_request[insurance_cost]'] =
          myTabController.loanDetails.insurancecost.text;
      request.fields['loan_request[advance_payment]'] =
          myTabController.loanDetails.advancepayment.text;
      request.fields['loan_request[loan_tenure]'] =
          myTabController.loanDetails.tenure.toString();
      request.fields['loan_request[loan_amount]'] =
          myTabController.loanDetails.loanamaountapplied.text;

      //bankdetails
      request.fields['loan_request[bank_name]'] =
          myTabController.loanDetails.bankname.text;
      request.fields['loan_request[bank_branch_name]'] =
          myTabController.loanDetails.branchname.text;
      request.fields['loan_request[bank_sort_code]'] =
          myTabController.loanDetails.sortcode.text;
      request.fields['loan_request[bank_account_number]'] =
          myTabController.loanDetails.accountnumber.text;
      request.fields['loan_request[bank_name_and_full_address]'] =
          myTabController.loanDetails.nameandbankaddress.text;
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request was successful
        print('Form updated successfully');
        setState(() {
          isloadiing = false;
          for (int i = 0; i < loanDetail.applicantCount; i++) {
            widget.myTabController.applicants[i].bankStatementFileNames.clear();
            widget.myTabController.applicants[i].bankStatementFiles.clear();

            widget.myTabController.applicants[i].nrcFileNames.clear();
            widget.myTabController.applicants[i].nrcFiles.clear();

            widget.myTabController.applicants[i].paysliponeFileNames.clear();
            widget.myTabController.applicants[i].paysliponeFiles.clear();

            widget.myTabController.applicants[i].paysliptwoFileNames.clear();
            widget.myTabController.applicants[i].paysliptwoFileNames.clear();

            widget.myTabController.applicants[i].payslipthreeFileNames.clear();
            widget.myTabController.applicants[i].payslipthreeFiles.clear();

            widget.myTabController.applicants[i].introletterFileNames.clear();
            widget.myTabController.applicants[i].intodletterFiles.clear();

            widget.myTabController.applicants[i].signature.clear();
            widget.myTabController.applicants[i].signatureName.clear();
          }
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

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, int productid, int loanid) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.sidebarbackground,
          title: CustomText(
            text: 'Confirm Deletion',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.mainColor,
          ),
          content: CustomText(
            text: 'Are you sure you want to delete this product?',
            color: AppColors.neutral,
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomText(
                text: 'Cancel',
                color: AppColors.neutral,
              ),
            ),
            // Confirm Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Call deleteData when confirmed
                productDelete(loanid, productid);
              },
              child: CustomText(
                text: 'Confirm',
                color: AppColors.neutral,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAttachment(String id, String documentId) async {
    final String apiUrl =
        'https://loan-managment.onrender.com/loan_requests/$id/remove_attachment?document_id=$documentId';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
    });

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Attachment deleted successfully');
        warning('Attachment deleted successfully');
        fetchData(widget.id);
      } else {
        // Failed to delete attachment
        print(
            'Failed to delete attachment. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception while deleting attachment: $e');
    }
  }

  Future<void> productDelete(int id, int productid) async {
    // Define the URL
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
    });
    String url = 'https://loan-managment.onrender.com/loan_requests/$id';

    // Define the request body
    Map<String, dynamic> requestBody = {
      "loan_request": {
        "loan_request_products_attributes": [
          {"id": productid, "_destroy": true}
        ]
      }
    };

    // Convert the request body to a JSON string
    String requestBodyJson = jsonEncode(requestBody);

    // Set up the headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the header
    };

    try {
      // Send the POST request
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: requestBodyJson,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('DELETE request successful!');
        print('Response body: ${response.body}');
        setState(() {
          isloadiing = false;
        });
        fetchData(widget.id);
      } else {
        print(
            'Failed to send DELETE request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          isloadiing = false;
        });
      }
    } catch (e) {
      print('Error sending DELETE request: $e');
    }
  }

  Future<void> updateQuantity(
      int id, int quantity, int productId, int listId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloadiing = true;
      token = prefs.getString('token');
    });

    String url = 'https://loan-managment.onrender.com/loan_requests/$id';

    Map<String, dynamic> requestBody = {
      "loan_request": {
        "loan_request_products_attributes": [
          {"id": listId, "quantity": quantity, "product_id": productId}
        ]
      }
    };

    String requestBodyJson = jsonEncode(requestBody);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: requestBodyJson,
      );

      if (response.statusCode == 200) {
        print('Quantity update successful!');
        print('Response body: ${response.body}');
        setState(() {
          isloadiing = false;
        });
        fetchData(widget.id);
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          isloadiing = false;
        });
      }
    } catch (e) {
      print('Error sending update quantity request: $e');
    }
  }
}
