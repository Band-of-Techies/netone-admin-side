import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  List<String> agentList = ['Agent 1', 'Agent 2', 'Agent 3'];
  final Dio dio = Dio();
  late List<LoanRequest> loanRequests;
  bool isloading = true;
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
      body: loanRequests != null && isloading != true
          ? ListView.builder(
              itemCount: loanRequests.length,
              itemBuilder: (context, index) {
                return RequestItem(
                  agent:
                      '', // Replace with actual agent information from API if available
                  functionstring: 'Select Agent',
                  productname:
                      'Mobile Phone', // Replace with actual product name from API if available
                  amount: loanRequests[index].loanAmount,
                  requestId:
                      '${loanRequests[index].id}', // Assuming 'id' is unique for each request
                  customerName:
                      '${loanRequests[index].applicants['${index + 1}']['first_name']}',
                  date: loanRequests[index]
                      .createdAt, // Replace with actual date from API if available
                  isChecked: false, // Set your own logic for isChecked
                  onCheckboxChanged: (value) {
                    // Handle checkbox change, if needed
                  },
                  agents:
                      agentList, // Replace with actual agent list from API if available
                  selectedAgent:
                      'Agent 1', // Replace with actual selected agent from API if available
                  onAgentSelected: (agent) {
                    // Handle agent selection, if needed
                  },
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
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=new';
      final String bearerToken =
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAxNjc0NjE5fQ.6vC4yaryRm4Q3mwfzAPvP-JxbqqF-3YmS6qQW_00bbk';

      var response = await dio.get(
        apiEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $bearerToken'},
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          // Convert each item in the array to a LoanRequest object
          loanRequests =
              (response.data['loan_requests']['array'] as List<dynamic>)
                  .map((json) => LoanRequest.fromJson(json))
                  .toList();
          isloading = false;
        });
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
