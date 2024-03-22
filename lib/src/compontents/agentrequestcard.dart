// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentRequestItem extends StatefulWidget {
  final String requestId;

  final String gender;
  final VoidCallback updateDataCallback;
  final String customerName;
  final String date;
  final bool isChecked;
  final Function(bool?) onCheckboxChanged;
  final List<String> agents;
  final int status;
  final int applicantCount;
  final VoidCallback onConfirm;
  final VoidCallback onVerticalMenuPressed;
  final String productname;
  final String amount;
  final String functionstring;
  final String agent;
  final int loanid;
  final String history;

  AgentRequestItem({
    required this.history,
    required this.gender,
    required this.status,
    required this.updateDataCallback,
    required this.applicantCount,
    required this.loanid,
    required this.agent,
    required this.functionstring,
    required this.requestId,
    required this.customerName,
    required this.date,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.agents,
    required this.onConfirm,
    required this.onVerticalMenuPressed,
    required this.amount,
    required this.productname,
  });

  @override
  _AgentRequestItemState createState() => _AgentRequestItemState();
}

class _AgentRequestItemState extends State<AgentRequestItem> {
  String? seletedagent;
  List<Uint8List> selectedFiles = [];
  List<String> selectedFilesnames = [];

  List<Uint8List> purchaseorderfiles = [];
  List<String> purchaseorderfilename = [];

  List<Uint8List> deliveryrecipetFile = [];
  List<String> deliveryrecipetFilename = [];

  List<Uint8List> warrentyfiles = [];
  List<String> warrentyfilename = [];

  List<Uint8List> antifraudfiles = [];
  List<String> antifraudfilesname = [];

  List<Uint8List> authorizationfiles = [];
  List<String> authorizationfilename = [];

  List<Uint8List> taxfiles = [];
  List<String> taxfilename = [];

  List<Uint8List> swapFiles = [];
  List<String> swapFilesNames = [];

  TextEditingController rejectionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.sidebarbackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.history == "new"
                  ? AppColors.sidebarbackground
                  : widget.history == "existing"
                      ? Color.fromARGB(255, 254, 170, 73)
                      : widget.history == "rejected"
                          ? Color(0xFFFF4242)
                          : widget.history == "closed"
                              ? Color.fromARGB(255, 85, 175, 83)
                              : AppColors
                                  .sidebarbackground, // Change these colors as per your preference
              widget.history == "new"
                  ? AppColors.sidebarbackground
                  : widget.history == "existing"
                      ? AppColors.sidebarbackground
                      : widget.history == "rejected"
                          ? AppColors.sidebarbackground
                          : widget.history == "closed"
                              ? AppColors.sidebarbackground
                              : AppColors.sidebarbackground,
            ],
            stops: [0.01, 0.1],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 12),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                          child:
                              CustomText(fontSize: 14, text: widget.requestId)),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .06,
                        child: CustomText(
                          fontSize: 13,
                          text: widget.agent,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .15,
                    child: Row(
                      children: [
                        //check male or female here, so can check and show iamges accoridngly

                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(widget.applicantCount > 1
                              ? '../../assets/png/joint.png'
                              : widget.gender == 'Female'
                                  ? '../../assets/png/avatar-5.png'
                                  : '../../assets/png/avatar-4.png'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomText(
                          fontSize: 15,
                          text: widget.customerName,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .1,
                child: CustomText(
                  fontSize: 14,
                  text: widget.date,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .05,
                child: CustomText(
                  fontSize: 14,
                  text: widget.amount,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .06,
                child: CustomText(
                  fontSize: 14,
                  text: widget.productname,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Add more decoration..
                      ),
                      hint: Text(
                        widget.functionstring,
                        style: GoogleFonts.dmSans(
                            fontSize: 14, color: AppColors.neutral),
                      ),
                      items: widget.agents.map((agent) {
                        return DropdownMenuItem<String>(
                          value: agent.toString(),
                          child: CustomText(
                            fontSize: 14,
                            color: AppColors.neutral,
                            text: agent.toString(),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return widget.functionstring;
                        }
                        return null;
                      },
                      onChanged: (agent) {
                        setState(() {
                          seletedagent = agent!;
                          print(agent);
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
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
                    width: 25,
                  ),
                  TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(20, 5, 20, 5)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust the border radius as needed
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.mainColor)),
                      onPressed: () {
                        if ((widget.status == 1 || widget.status == 2) &&
                            seletedagent == 'rejected') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppColors.sidebarbackground,
                                title: SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: CustomText(
                                    text: 'Request Rejection',
                                    fontSize: 20,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      maxLines: 5,
                                      controller: rejectionController,
                                      decoration: InputDecoration(
                                        labelText: 'Rejection Reason',
                                        labelStyle: GoogleFonts.dmSans(
                                          color: AppColors.neutral,
                                          height: 0.5,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color: AppColors.neutral,
                                              width: 1.0),
                                        ),
                                      ),
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.neutral,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.fromLTRB(
                                                  20, 5, 20, 5)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  8.0), // Adjust the border radius as needed
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.mainColor)),
                                      onPressed: () {
                                        // Handle rejection button click
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                        _submitAssignment(
                                            widget.loanid,
                                            seletedagent!,
                                            rejectionController.text);
                                      },
                                      child: CustomText(
                                        text: 'Submit Rejection',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if ((widget.status == 3) &&
                            seletedagent == 'delivered') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  backgroundColor: AppColors.sidebarbackground,
                                  title: CustomText(
                                    text: 'Attatch Proof',
                                    fontSize: 20,
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (purchaseorderfilename.isNotEmpty)
                                          viewfiles(
                                              context,
                                              setState,
                                              purchaseorderfiles,
                                              purchaseorderfilename),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: purchaseorderfiles,
                                            newfilesname: purchaseorderfilename,
                                            buttonText: 'Purchase Order'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (deliveryrecipetFile.isNotEmpty)
                                          viewfiles(
                                              context,
                                              setState,
                                              deliveryrecipetFile,
                                              deliveryrecipetFilename),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: deliveryrecipetFile,
                                            newfilesname:
                                                deliveryrecipetFilename,
                                            buttonText: 'Delivery Receipt'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (warrentyfiles.isNotEmpty)
                                          viewfiles(context, setState,
                                              warrentyfiles, warrentyfilename),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: warrentyfiles,
                                            newfilesname: warrentyfilename,
                                            buttonText: 'Warrenty Form'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (antifraudfiles.isNotEmpty)
                                          viewfiles(
                                              context,
                                              setState,
                                              antifraudfiles,
                                              antifraudfilesname),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: antifraudfiles,
                                            newfilesname: antifraudfilesname,
                                            buttonText: 'Anti-Fraud'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (authorizationfiles.isNotEmpty)
                                          viewfiles(
                                              context,
                                              setState,
                                              authorizationfiles,
                                              authorizationfilename),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: authorizationfiles,
                                            newfilesname: authorizationfilename,
                                            buttonText: 'Authorization'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (taxfiles.isNotEmpty)
                                          viewfiles(context, setState, taxfiles,
                                              taxfilename),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: taxfiles,
                                            newfilesname: taxfilename,
                                            buttonText: 'Tax Invoice'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (swapFiles.isNotEmpty)
                                          viewfiles(context, setState,
                                              swapFiles, swapFilesNames),
                                        uploadButton(
                                            context: context,
                                            setState: setState,
                                            newfiles: swapFiles,
                                            newfilesname: swapFilesNames,
                                            buttonText: 'Swap Agreement'),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: CustomText(
                                          text: 'Cancel',
                                        )),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.fromLTRB(
                                                  20, 5, 20, 5)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  8.0), // Adjust the border radius as needed
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.mainColor)),
                                      onPressed: () {
                                        // Handle rejection button click
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                        if (purchaseorderfiles.isNotEmpty &&
                                            deliveryrecipetFile.isNotEmpty &&
                                            warrentyfiles.isNotEmpty &&
                                            antifraudfiles.isNotEmpty &&
                                            taxfiles.isNotEmpty) {
                                          updateWithDoc(
                                            widget.loanid,
                                            seletedagent!,
                                          );
                                        } else {
                                          warning('Add delivery proof');
                                        }
                                      },
                                      child: CustomText(
                                        text: 'Submit and Approve',
                                      ),
                                    ),
                                  ],
                                );
                              });
                            },
                          );
                        } else {
                          _submitAssignment(widget.loanid, seletedagent!, '');
                        }
                      },
                      child: CustomText(
                        fontSize: 14,
                        color: AppColors.neutral,
                        text: 'Submit',
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewApplication(
                                    loanRequestId: widget.loanid,
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.neutral,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container viewfiles(BuildContext context, StateSetter setState,
      List<Uint8List>? newfiles, List<String> newfilenames) {
    return Container(
        width: MediaQuery.of(context).size.width * .7,
        margin: EdgeInsets.only(bottom: 10),
        child: Wrap(
          children: List.generate(
            newfiles!.length,
            (index) {
              var fileBytes = newfiles[index];
              var fileName = newfilenames[index];
              String fileExtension = fileName.split('.').last.toLowerCase();

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
                                      html.Url.createObjectUrlFromBlob(blob);
                                  html.window.open(url, '_blank');
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
                                    children: const [
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
                            newfiles.removeAt(index);
                            newfilenames.removeAt(index);
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
        ));
  }

  TextButton uploadButton({
    required BuildContext context,
    required Function setState,
    List<Uint8List>? newfiles,
    List<String>? newfilesname,
    required String buttonText,
  }) {
    return TextButton.icon(
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
            setState(() {
              newfiles!.addAll(result.files.map((file) => file.bytes!));
              newfilesname!.addAll(result.files.map((file) => file.name));
            });
          }
          print(newfiles);
        }
      },
      icon: Icon(
        Icons.add,
        color: AppColors.neutral,
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
            Size(200, 40)), // Define minimum size
        maximumSize: MaterialStateProperty.all<Size>(Size(200, 40)),
        // Change background color as needed
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust border radius as needed
            side: BorderSide(
                color: AppColors.neutral), // Change border color as needed
          ),
        ),
      ),
      label: CustomText(
        text: buttonText,
        color: AppColors.neutral,
      ),
    );
  }

  Future<void> _submitAssignment(
      int id, String seletedagent, String reason) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (seletedagent != null) {
      print(seletedagent);
      // Replace with your actual API endpoint
      String apiUrl = "https://loan-managment.onrender.com/loan_requests/$id";
      // Replace 'yourAccessToken' with the actual token
      print(apiUrl);
      String accessToken = prefs.getString('token')!;

      Dio dio = Dio();
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
      Map<String, dynamic> requestBody = {};
      // Create the request body
      if (widget.status == 1) {
        requestBody = {
          "loan_request": {
            "request_system_status": seletedagent,
            "system_rejection_reason": reason
          }
        };
      }
      if (widget.status == 2) {
        requestBody = {
          "loan_request": {
            "request_bank_status": seletedagent,
            "bank_rejection_reason": reason
          }
        };
      }
      if (widget.status == 3) {
        requestBody = {
          "loan_request": {
            "request_order_status": seletedagent,
          }
        };
      }

      if (widget.status == 4) {
        requestBody = {
          "loan_request": {
            "request_order_status": seletedagent,
          }
        };
      }
      print(requestBody);
      try {
        Response response = await dio.patch(apiUrl, data: requestBody);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Successfully updated the request system status (status code 200 for PATCH)
          print('Request bank status updated successfully');
          widget.updateDataCallback();
        } else {
          // Handle error
          print(
              'Failed to update request bank status. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle error
        print('Error during PATCH request: $error');
      }
    }
  }

  Future<void> updateWithDoc(int id, String seletedagent) async {
    final String apiUrl =
        'https://loan-managment.onrender.com/loan_requests/$id';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
      String accessToken = prefs.getString('token')!;
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['loan_request[request_order_status]'] = seletedagent;
      if (selectedFiles.isNotEmpty) {
        for (var file in selectedFiles) {
          request.files.add(http.MultipartFile(
            'loan_request[order_documents][]',
            http.ByteStream.fromBytes(file),
            file.length,
            filename: 'file.jpg', // Provide a filename here
            contentType: MediaType('application', 'octet-stream'),
          ));
        }
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Request was successful
        print('Files Submitted successfully');
        warning('Status updated, and files added');
        widget.updateDataCallback();
        //  clearAllFields();
      } else {
        // Request failed
      }
    } catch (e) {
      print("Error: $e");
      warning('Error');
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
