import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/agentrequestcard.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';

class NetoneStatusSection extends StatefulWidget {
  const NetoneStatusSection({super.key});

  @override
  State<NetoneStatusSection> createState() => _NetoneStatusSectionState();
}

class _NetoneStatusSectionState extends State<NetoneStatusSection> {
  TextEditingController search = TextEditingController();
  // Mock data for demonstration purposes
  List<String> netonestatuslist = ['Approve', 'Reject'];
  final Dio dio = Dio();
  bool isloading = true;
  List<LoanRequest>? loanRequests;
  String selectedStatus = '';
  List<RequestData> requestList = List.generate(
    10,
    (index) => RequestData(
      selectedStatus: '',
      functionstring: 'Netone Status',
      productname: 'Mobile Phone',
      amount: '10,000',
      requestId: 'NR23344',
      customerName: 'John Doe',
      date: '12 Nov 2023',
      isChecked: false,
      selectedAgent: 'Name Here',
    ),
  );

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
                  status: 1,
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
                      netonestatuslist, // Replace with actual agent list from API if available
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
            ),
    );
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
          'https://loan-managment.onrender.com/loan_requests?filter=netone';
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
    } catch (error) {
      print('Error: $error');
    }
  }
}

class RequestData {
  final String productname;
  final String amount;
  final String requestId;
  final String customerName;
  final String functionstring;
  final String date;
  bool isChecked;
  String selectedAgent;
  String selectedStatus;

  RequestData({
    required this.selectedStatus,
    required this.functionstring,
    required this.amount,
    required this.productname,
    required this.requestId,
    required this.customerName,
    required this.date,
    required this.isChecked,
    required this.selectedAgent,
  });
}
