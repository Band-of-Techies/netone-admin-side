// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class RequestItem extends StatefulWidget {
  final String gender;
  final String requestId;
  final VoidCallback updateDataCallback;
  final String customerName;
  final String date;
  final bool isChecked;
  final Function(bool?) onCheckboxChanged;
  final List<Map<String, dynamic>> agents;
  final String selectedAgent;
  final int applicantCount;
  final VoidCallback onConfirm;
  final VoidCallback onVerticalMenuPressed;
  final String productname;
  final String amount;
  final String functionstring;
  final String agent;
  final int loanid;
  final String history;

  RequestItem({
    required this.history,
    required this.gender,
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
    required this.selectedAgent,
    required this.onConfirm,
    required this.onVerticalMenuPressed,
    required this.amount,
    required this.productname,
  });

  @override
  _RequestItemState createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  String? seletedagent;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                      ? Color.fromARGB(255, 250, 197, 138)
                      : widget.history == "rejected"
                          ? Color.fromARGB(255, 251, 149, 149)
                          : widget.history == "closed"
                              ? Color.fromARGB(255, 153, 244, 152)
                              : AppColors
                                  .sidebarbackground, // Change these colors as per your preference
              widget.history == "new"
                  ? AppColors.sidebarbackground
                  : widget.history == "existing"
                      ? AppColors.sidebarbackground
                      : widget.history == "rejected"
                          ? Colors.red
                          : widget.history == "closed"
                              ? Colors.yellow
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
                          value: agent['id'].toString(),
                          child: CustomText(
                            fontSize: 14,
                            color: AppColors.neutral,
                            text: agent['name'].toString(),
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
                        _submitAssignment(widget.loanid, seletedagent!);
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

  Future<void> _submitAssignment(int id, String seletedagent) async {
    if (seletedagent != null) {
      // Replace with your actual API endpoint
      String apiUrl =
          "https://loan-managment.onrender.com/loan_requests/$id/assign_to_agent";
      // Replace 'yourAccessToken' with the actual token
      String accessToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzA0MDIwNzQ3fQ.mr7ZVonDmM7i3am7EipAsHhTV21epUJtpXK5sbPCM2Y';

      Dio dio = Dio();
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Create the request body
      Map<String, dynamic> requestBody = {
        'user_id': seletedagent,
      };
      print(seletedagent);
      print(id);
      try {
        Response response = await dio.post(apiUrl, data: requestBody);
        if (response.statusCode == 201 || response.statusCode == 200) {
          // Successfully created assignment (status code 201 for POST)
          print('Assignment created successfully');
          widget.updateDataCallback();
        } else {
          // Handle error
          print(
              'Failed to create assignment. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle error
        print('Error during POST request: $error');
      }
    }
  }
}
