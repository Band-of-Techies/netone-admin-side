// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssigntoMeCard extends StatefulWidget {
  final String gender;
  final String requestId;
  final VoidCallback updateDataCallback;
  final String customerName;
  final String date;
  final bool isChecked;
  final Function(bool?) onCheckboxChanged;
  final int applicantCount;
  final VoidCallback onConfirm;
  final VoidCallback onVerticalMenuPressed;
  final String productname;
  final String amount;
  final String functionstring;
  final int loanid;
  final String history;

  AssigntoMeCard({
    required this.history,
    required this.gender,
    required this.updateDataCallback,
    required this.applicantCount,
    required this.loanid,
    required this.functionstring,
    required this.requestId,
    required this.customerName,
    required this.date,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onConfirm,
    required this.onVerticalMenuPressed,
    required this.amount,
    required this.productname,
  });

  @override
  _AssigntoMeCardState createState() => _AssigntoMeCardState();
}

class _AssigntoMeCardState extends State<AssigntoMeCard> {
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
                        _submitAssignment(widget.loanid);
                      },
                      child: CustomText(
                        fontSize: 14,
                        color: AppColors.neutral,
                        text: 'Assign to me',
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

  Future<void> _submitAssignment(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    if (accessToken != null) {
      // Replace with your actual API endpoint
      String apiUrl =
          "https://loan-managment.onrender.com/loan_requests/$id/assign_to_me";

      Dio dio = Dio();
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      // Optionally, you can create the request body here if needed
      Map<String, dynamic> requestBody = {
        // Include any parameters you need to send in the request body
      };

      try {
        Response response = await dio.post(apiUrl, data: requestBody);
        if (response.statusCode == 201 || response.statusCode == 200) {
          // Successfully created assignment (status code 201 for POST)
          print('Assignment created successfully');
          // Assuming `updateDataCallback` is a function passed as a widget parameter
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
    } else {
      print('Access token not found. Make sure to login first.');
    }
  }
}
