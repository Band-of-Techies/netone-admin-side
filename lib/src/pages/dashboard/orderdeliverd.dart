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

class OrderDeliverdStatus extends StatefulWidget {
  const OrderDeliverdStatus({super.key});

  @override
  State<OrderDeliverdStatus> createState() => _OrderDeliverdStatusState();
}

class _OrderDeliverdStatusState extends State<OrderDeliverdStatus> {
  // Mock data for demonstration purposes
  List<String> orderdeliverstatus = ['closed'];
  TextEditingController search = TextEditingController();
  final Dio dio = Dio();
  ScrollController _scrollController = ScrollController();
  String? searchValue;
  List<LoanRequest>? loanRequests;
  String? errorMessage;
  String? email;
  String? token;
  bool isloading = true;
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
                          return AgentRequestItem(
                            status: 4,
                            history: loanRequests![index].history,
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
                            isChecked:
                                false, // Set your own logic for isChecked
                            onCheckboxChanged: (value) {
                              // Handle checkbox change, if needed
                            },
                            agents:
                                orderdeliverstatus, // Replace with actual agent list from API if available
                            // Replace with actual selected agent from API if available

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
                : const Center(
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
    try {
      setState(() {
        isloading = true;
        token = prefs.getString('token');
        email = prefs.getString('email');
      });
      String apiEndpoint =
          'https://loan-managment.onrender.com/loan_requests?filter=delivered_orders';
      if (search.text.isNotEmpty) {
        apiEndpoint =
            'https://loan-managment.onrender.com/loan_requests?filter=delivered_orders&search=${search.text}';
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
        errorMessage = 'Error: 404';
      });
      print('Error: $error');
    }
  }
}
