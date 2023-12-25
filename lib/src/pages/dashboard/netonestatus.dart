import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/agentrequestcard.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetoneStatusSection extends StatefulWidget {
  const NetoneStatusSection({super.key});

  @override
  State<NetoneStatusSection> createState() => _NetoneStatusSectionState();
}

class _NetoneStatusSectionState extends State<NetoneStatusSection> {
  TextEditingController search = TextEditingController();
  // Mock data for demonstration purposes
  List<String> netonestatuslist = ['approved', 'rejected'];
  final Dio dio = Dio();
  String? searchValue;
  bool isloading = true;
  List<LoanRequest>? loanRequests;
  String selectedStatus = '';
  String? errorMessage;
  String? email;
  String? token;

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
              onSubmit: () {
                setState(() {
                  searchValue = search.text;
                });
                fetchData();
              },
            )
          ],
        ),
        body: isloading == false
            ? loanRequests!.isNotEmpty
                ? ListView.builder(
                    itemCount: loanRequests!.length,
                    itemBuilder: (context, index) {
                      return AgentRequestItem(
                        history: loanRequests![index].history,
                        status: 1,
                        gender: loanRequests![index].gender,
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
                : Center(
                    child: CustomText(text: 'No Request Found'),
                  )
            : const Center(
                child: CircularProgressIndicator(
                color: AppColors.mainColor,
              )));
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    try {
      String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=netone';
      if (search.text.isNotEmpty) {
        apiEndpoint =
            'https://loan-managment.onrender.com/loan_requests?filter=netone&search=${search.text}';
      }
      final String bearerToken = token!;

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
        setState(() {
          errorMessage = 'Error';
        });
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error 404';
      });
      print('Error: $error');
    }
  }
}
