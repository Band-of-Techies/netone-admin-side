// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/res/textfield.dart';

class AgentRequestItem extends StatefulWidget {
  final String requestId;
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

  AgentRequestItem({
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
  TextEditingController rejectionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.sidebarbackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsets.all(8),
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
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
                                        borderRadius: BorderRadius.circular(4),
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
                                            EdgeInsets.fromLTRB(20, 5, 20, 5)),
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
                PopupMenuButton<String>(
                  color: AppColors.sidebarbackground,
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.neutral,
                  ),
                  onSelected: (value) {
                    // Handle the selected option
                    if (value == 'edit') {
                      // Handle edit action
                    } else if (value == 'delete') {
                      // Handle delete action
                    } else if (value == 'view') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewApplication(
                                  loanRequestId: widget.loanid,
                                )),
                      );
                      // Handle view action
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        textStyle: GoogleFonts.dmSans(color: AppColors.neutral),
                        value: 'view',
                        child: CustomText(
                          fontSize: 13,
                          text: 'View',
                        ),
                      ),
                      PopupMenuItem<String>(
                          textStyle:
                              GoogleFonts.dmSans(color: AppColors.neutral),
                          value: 'edit',
                          child: CustomText(
                            fontSize: 13,
                            text: 'Edit',
                          )),
                      PopupMenuItem<String>(
                        textStyle: GoogleFonts.dmSans(color: AppColors.neutral),
                        value: 'delete',
                        child: CustomText(
                          fontSize: 13,
                          text: 'Delete',
                        ),
                      ),
                    ];
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submitAssignment(
      int id, String seletedagent, String reason) async {
    if (seletedagent != null) {
      print(seletedagent);
      // Replace with your actual API endpoint
      String apiUrl = "https://loan-managment.onrender.com/loan_requests/$id";
      // Replace 'yourAccessToken' with the actual token
      print(apiUrl);
      String accessToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzMjY3NDQ4fQ.l7Hd1TdjcUTHdUmpRYhHVQQzVaDMb17dTNb566XlF3E';

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
      try {
        Response response = await dio.patch(apiUrl, data: requestBody);
        if (response.statusCode == 200) {
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
}
