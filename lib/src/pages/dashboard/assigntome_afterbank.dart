import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/assigntomecard.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/request.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignToMeAfterBank extends StatefulWidget {
  @override
  _AssignToMeAfterBankState createState() => _AssignToMeAfterBankState();
}

class _AssignToMeAfterBankState extends State<AssignToMeAfterBank> {
  TextEditingController search = TextEditingController();
  // Mock data for demonstration purposes
  List<Map<String, dynamic>> agentList = [];
  final Dio dio = Dio();
  bool isloading = true;
  List<LoanRequest>? loanRequests;
  ScrollController _scrollController = ScrollController();
  String? searchValue;
  String? errorMessage;
  String? email;
  String? token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainbackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                ? Theme(
                    data: Theme.of(context).copyWith(
                      scrollbarTheme: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(
                            AppColors.mainColor), // Set thumb color
                        trackColor: MaterialStateProperty.all(
                            Colors.grey), // Set track color
                      ),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      thickness: 5, // Adjust thickness as needed
                      // Adjust hover thickness to match the actual thickness
                      radius: Radius.circular(10), // Adj
                      child: ListView.builder(
                        itemCount: loanRequests!.length,
                        itemBuilder: (context, index) {
                          return AssigntoMeCard(
                            history: loanRequests![index].history,
                            gender: loanRequests![index].gender,
                            updateDataCallback: updateData,
                            applicantCount: loanRequests![index].applicantCount,
                            loanid: loanRequests![index].id,

                            functionstring: 'Select Agent',
                            productname: loanRequests![index]
                                .salesAgent
                                .name!, // Replace with actual product name from API if available
                            amount: loanRequests![index].loanAmount,
                            requestId: loanRequests![index]
                                .id
                                .toString(), // Assuming 'id' is unique for each request
                            customerName: loanRequests![index].firstName,
                            date: formatDate(loanRequests![index]
                                .createdAt), // Replace with actual date from API if available
                            isChecked:
                                false, // Set your own logic for isChecked
                            onCheckboxChanged: (value) {
                              // Handle checkbox change, if needed
                            },

                            onConfirm: () {
                              // Handle confirmation
                            },
                            onVerticalMenuPressed: () {
                              // Handle vertical menu press
                            },
                          );
                        },
                      ),
                    ),
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
    print(11);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    try {
      String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=confirmed_orders';
      if (search.text.isNotEmpty) {
        apiEndpoint =
            'https://loan-managment.onrender.com/loan_requests?filter=confirmed_orders&search=${search.text}';
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
          isloading = false;
        });
        print('Response');
        print('Loan $loanRequests');
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
        setState(() {
          errorMessage = 'Error';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: 404';
      });
      print('Error: $error');
    }
  }
}
