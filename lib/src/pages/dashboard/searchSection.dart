// ignore_for_file: prefer_const_constructors, prefer_const_declarations, deprecated_member_use, unnecessary_string_interpolations, avoid_print

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netone_loanmanagement_admin/src/compontents/agentrequestcard.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class SearchStatus extends StatefulWidget {
  const SearchStatus({super.key});

  @override
  State<SearchStatus> createState() => _SearchStatusState();
}

class _SearchStatusState extends State<SearchStatus> {
  TextEditingController requestid = TextEditingController();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  List<String> productslist = ['Mobile', 'Laptop', 'Tv', 'Fridge'];
  String selectedProduct = '';
  DateTime? startselecteddate;
  List<dynamic> searchResults = [];
  List<LoanRequest> loanRequests = [];
  bool isloading = false;
  final Dio dio = Dio();
  String? searchValue;
  String? searchdates;
  DateTime? endselecteddate;
  List<Map<String, dynamic>> agentList = [];
  List<String> netonestatuslist = ['approved', 'rejected'];
  List<String> bankstauslist = ['approved', 'rejected'];
  List<String> orderstatus = ['delivered'];
  List<String> orderdeliverstatus = ['closed'];
  String seletedagent = 'Select Agent';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainbackground,
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .795,
                      child: SearchTextFormField(
                        labeltext: 'Search',
                        controller: requestid,
                        onsubmit: () async {
                          setState(() {
                            searchValue = requestid.text;
                          });
                          await searchData();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(fontSize: 12, text: 'OR'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 350,
                        child: GestureDetector(
                          onTap: () async {
                            await _selectDate(context);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              readOnly: true,
                              controller: startdate,
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                labelStyle: GoogleFonts.dmSans(
                                  color: AppColors.neutral,
                                  height: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: AppColors.neutral, width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: AppColors.neutral, width: 0.5),
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
                    SizedBox(
                        width: 350,
                        child: GestureDetector(
                          onTap: () async {
                            if (startdate.text != null &&
                                startdate.text != 'null' &&
                                startdate.text != '') {
                              await _enddate(context);
                            } else {
                              warning('Choose Start Date');
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              readOnly: true,
                              controller: enddate,
                              decoration: InputDecoration(
                                labelText: 'End Date',
                                labelStyle: GoogleFonts.dmSans(
                                  color: AppColors.neutral,
                                  height: 0.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: AppColors.neutral, width: .5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: AppColors.neutral, width: .5),
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
                    SizedBox(
                      width: 350,
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          focusColor: AppColors.neutral,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.neutral, width: .5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.neutral, width: .5)),
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.neutral),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // Add more decoration..
                        ),
                        hint: Text(
                          'Choose Product',
                          style: GoogleFonts.dmSans(
                              fontSize: 14, color: AppColors.neutral),
                        ),
                        items: productslist
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: CustomText(
                                    fontSize: 14,
                                    color: AppColors.neutral,
                                    text: item,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          //Do something when selected item is changed.
                        },
                        onSaved: (value) {
                          selectedProduct = value.toString();
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.neutral,
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
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                if (isloading == true)
                  Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainColor),
                  ),
                if (isloading == false && loanRequests.isNotEmpty)
                  for (int index = 0; index < loanRequests.length; index++)
                    (loanRequests[index].agent.id == "NA")
                        ? RequestItem(
                            history: loanRequests[index].history,
                            gender: loanRequests[index].gender,
                            updateDataCallback: updateData,
                            applicantCount: loanRequests[index].applicantCount,
                            loanid: loanRequests[index].id,
                            agent:
                                'Not Assigned', // Replace with actual agent information from API if available
                            functionstring: 'Select Agent',
                            productname: loanRequests[index]
                                .product
                                .name, // Replace with actual product name from API if available
                            amount: loanRequests[index].loanAmount,
                            requestId: loanRequests[index]
                                .id
                                .toString(), // Assuming 'id' is unique for each request
                            customerName: loanRequests[index].firstName,
                            date: formatDate(loanRequests[index]
                                .createdAt), // Replace with actual date from API if available
                            isChecked:
                                false, // Set your own logic for isChecked
                            onCheckboxChanged: (value) {
                              // Handle checkbox change, if needed
                            },
                            agents:
                                agentList, // Replace with actual agent list from API if available
                            selectedAgent:
                                seletedagent, // Replace with actual selected agent from API if available

                            onConfirm: () {
                              // Handle confirmation
                            },
                            onVerticalMenuPressed: () {
                              // Handle vertical menu press
                            },
                          )
                        : AgentRequestItem(
                            history: loanRequests[index].history,
                            status: 2,
                            gender: loanRequests[index].gender,
                            updateDataCallback: updateData,
                            applicantCount: loanRequests[index].applicantCount,
                            loanid: loanRequests[index].id,
                            agent: loanRequests[index]
                                .agent
                                .name, // Replace with actual agent information from API if available
                            functionstring: 'Select Status',
                            productname: loanRequests[index]
                                .product
                                .name, // Replace with actual product name from API if available
                            amount: loanRequests[index].loanAmount,
                            requestId: loanRequests[index]
                                .id
                                .toString(), // Assuming 'id' is unique for each request
                            customerName: loanRequests[index].firstName,
                            date: formatDate(loanRequests[index]
                                .createdAt), // Replace with actual date from API if available
                            isChecked:
                                false, // Set your own logic for isChecked
                            onCheckboxChanged: (value) {
                              // Handle checkbox change, if needed
                            },
                            agents: loanRequests[index].requestSystemStatus ==
                                    'pending'
                                ? netonestatuslist
                                : loanRequests[index].requestBankStatus ==
                                        'pending'
                                    ? bankstauslist
                                    : loanRequests[index].requestOrderStatus ==
                                            "pending"
                                        ? orderstatus
                                        : loanRequests[index]
                                                    .requestOrderStatus ==
                                                "delivered"
                                            ? orderdeliverstatus
                                            : [], // Replace with actual agent list from API if available
                            // Replace with actual selected agent from API if available

                            onConfirm: () {
                              // Handle confirmation
                            },
                            onVerticalMenuPressed: () {
                              // Handle vertical menu press
                            },
                          )
              ],
            ),
          ],
        ));
  }

  void updateData() {
    searchData(); // Call fetchData to refresh the data
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
    return formattedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: TextTheme(
              subtitle1: GoogleFonts.dmSans(color: AppColors.neutral),
              button: GoogleFonts.dmSans(color: AppColors.neutral),
            ),
            colorScheme: ColorScheme.light(
                primary: AppColors.mainColor,
                surface: AppColors.sidebarbackground,
                onSurface: AppColors.neutral,
                secondary: AppColors.neutral),
            dialogBackgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // if backend requires time and date in another format use staring in applicant details and assign here, controller in textfield
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        startdate.text = formattedDate;
        startselecteddate = picked;
      });
    }
    if (startselecteddate != null && endselecteddate != null) {
      searchData();
    }
  }

  Future<void> _enddate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(startselecteddate!.year),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: TextTheme(
              subtitle1: GoogleFonts.dmSans(color: AppColors.neutral),
              button: GoogleFonts.dmSans(color: AppColors.neutral),
            ),
            colorScheme: ColorScheme.light(
                primary: AppColors.mainColor,
                surface: AppColors.sidebarbackground,
                onSurface: AppColors.neutral,
                secondary: AppColors.neutral),
            dialogBackgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // if backend requires time and date in another format use staring in applicant details and assign here, controller in textfield
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        enddate.text = formattedDate;
        endselecteddate = picked;
      });
    }
    if (startselecteddate != null && endselecteddate != null) {
      searchData();
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

  Future<void> searchData() async {
    setState(() {
      isloading = true;
    });

    final String apiEndpoint;
    if (startselecteddate != null && endselecteddate != null) {
      searchdates =
          'apply_date_from=$startselecteddate&apply_date_to=$endselecteddate';
    }
    if (searchValue != null && searchdates != null) {
      apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?search=$searchValue&$searchdates';
    } else if (searchValue != null) {
      apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?search=$searchValue';
    } else if (searchdates != null) {
      apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?$searchdates';
    } else {
      apiEndpoint = 'https://loan-managment.onrender.com/loan_requests';
    }

    final String bearerToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzA0MDIwNzQ3fQ.mr7ZVonDmM7i3am7EipAsHhTV21epUJtpXK5sbPCM2Y';

    try {
      print(apiEndpoint);
      var response = await dio.get(
        '$apiEndpoint',
        options: Options(
          headers: {'Authorization': 'Bearer $bearerToken'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          // Convert each item in the array to a LoanRequest object
          loanRequests = (response.data['loan_requests'] as List<dynamic>)
              .map((json) => LoanRequest.fromJson(json))
              .toList();
          isloading = false;
        });
        print(loanRequests[0].firstName);
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
      final String agentsApiEndpoint =
          'https://loan-managment.onrender.com/users';
      var agentsResponse = await dio.get(
        agentsApiEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $bearerToken'},
        ),
      );

      if (agentsResponse.statusCode == 200 ||
          agentsResponse.statusCode == 201) {
        setState(() {
          // Extract agent names from the response and update the agentList
          agentList = (agentsResponse.data['users'] as List<dynamic>)
              .map((agent) => {
                    'id': agent['id'],
                    'name': agent['name'],
                  })
              .toList();
        });
      } else {
        print(
            'Error: ${agentsResponse.statusCode} - ${agentsResponse.statusMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
