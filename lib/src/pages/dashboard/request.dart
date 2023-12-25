import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? searchValue;
  String seletedagent = 'Select Agent';
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
                      return RequestItem(
                        history: loanRequests![index].history,
                        gender: loanRequests![index].gender,
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
                : Center(
                    child: CustomText(text: 'No Request Found'),
                  )
            : const Center(
                child: CircularProgressIndicator(
                color: AppColors.mainColor,
              )));
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    try {
      String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=new';
      if (search.text.isNotEmpty) {
        apiEndpoint =
            'https://loan-managment.onrender.com/loan_requests?filter=new&search=${search.text}';
      }
      //print(apiEndpoint);
      String bearerToken = token!;

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
        print('Loan $loanRequests');
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
        setState(() {
          errorMessage = 'Error';
        });
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
          isloading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Error';
        });
        print(
            'Error: ${agentsResponse.statusCode} - ${agentsResponse.statusMessage}');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: 404';
      });
      print('Error: $error');
    }
  }
}
