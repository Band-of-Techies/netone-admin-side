import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/agentrequestcard.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';

class BankStatusSection extends StatefulWidget {
  const BankStatusSection({super.key});

  @override
  State<BankStatusSection> createState() => _BankStatusSectionState();
}

class _BankStatusSectionState extends State<BankStatusSection> {
  TextEditingController search = TextEditingController();
  final Dio dio = Dio();
  List<String> bankstauslist = ['approved', 'rejected'];
  List<LoanRequest>? loanRequests;

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
                  return AgentRequestItem(
                    status: 2,
                    updateDataCallback: updateData,
                    applicantCount: loanRequests![index].applicantCount,
                    loanid: loanRequests![index].id,
                    agent: loanRequests![index]
                        .agent
                        .name, // Replace with actual agent information from API if available
                    functionstring: 'Select Status',
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
                        bankstauslist, // Replace with actual agent list from API if available
                    // Replace with actual selected agent from API if available

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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void updateData() {
    fetchData(); // Call fetchData to refresh the data
  }

  void fetchData() async {
    try {
      final String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=bank';
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
        });
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
