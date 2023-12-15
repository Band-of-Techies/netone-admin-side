import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';

class RequestsSection extends StatefulWidget {
  @override
  _RequestsSectionState createState() => _RequestsSectionState();
}

class _RequestsSectionState extends State<RequestsSection> {
  TextEditingController search = TextEditingController();
  // Mock data for demonstration purposes
  List<Map<String, dynamic>> agentList = [];
  final Dio dio = Dio();
  bool isloading = true;
  List<LoanRequest>? loanRequests;
  String seletedagent = 'Select Agent';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainbackground,
        appBar: AppBar(
          backgroundColor: AppColors.mainbackground,
          actions: [
            CustomTextFormField(
              labeltext: 'Search',
              controller: search,
              onSubmit: () {},
            )
          ],
        ),
        body: loanRequests != null && loanRequests!.isNotEmpty
            ? ListView.builder(
                itemCount: loanRequests!.length,
                itemBuilder: (context, index) {
                  return RequestItem(
                    updateDataCallback: updateData,
                    applicantCount: loanRequests![index].applicantCount,
                    loanid: loanRequests![index].id,
                    agent:
                        'Not Assigned', // Replace with actual agent information from API if available
                    functionstring: 'Select Agent',
                    productname: loanRequests![index]
                        .product
                        .name, // Replace with actual product name from API if available
                    amount: loanRequests![index].loanAmount,
                    requestId: loanRequests![index]
                        .id
                        .toString(), // Assuming 'id' is unique for each request
                    customerName: loanRequests![index].firstName,
                    date: formatDate(loanRequests![index]
                        .createdAt), // Replace with actual date from API if available
                    isChecked: false, // Set your own logic for isChecked
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
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ));
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
    return formattedDate;
  }

  void updateData() {
    fetchData(); // Call fetchData to refresh the data
  }

  void fetchData() async {
    try {
      final String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=new';
      final String bearerToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAzMjY3NDQ4fQ.l7Hd1TdjcUTHdUmpRYhHVQQzVaDMb17dTNb566XlF3E';

      var response = await dio.get(
        apiEndpoint,
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
