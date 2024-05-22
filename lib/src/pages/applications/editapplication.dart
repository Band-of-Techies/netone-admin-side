import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicant.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicationdetails.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/application/sectionfour.dart';
import 'package:netone_loanmanagement_admin/src/application/sectionone.dart';
import 'package:netone_loanmanagement_admin/src/application/sectionthree.dart';
import 'package:netone_loanmanagement_admin/src/application/sectiontwo.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:netone_loanmanagement_admin/config/config_dev.dart';

final String endpoint = AppConfig.apiUrl;

class EditApplication extends StatefulWidget {
  int? requestid;
  EditApplication({required this.requestid});
  @override
  State<EditApplication> createState() => _EditApplication();
}

class _EditApplication extends State<EditApplication>
    with SingleTickerProviderStateMixin {
  bool isloading = true;
  late LoanRequestDetails loanDetail;
  final MyTabController myTabController = MyTabController();
  String? email;
  String? token;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isloading == false
          ? ChangeNotifierProvider(
              create: (context) => MyTabController(),
              child: DefaultTabController(
                length: 3, // Number of tabs (sections)
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.mainbackground,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: AppColors.neutral,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewApplication(
                                    loanRequestId: widget.requestid!,
                                  )),
                        );
                      },
                    ),
                    toolbarHeight: 90,
                    title: Column(children: [
                      Wrap(
                        children: [
                          Text(
                            'PUBLIC SERVICE MICRO FINANCE COMPANY',
                            style: GoogleFonts.poppins(
                                color: AppColors.mainColor,
                                fontSize: 21,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '- ASSET LOAN APPLICATION FORM',
                            style: GoogleFonts.poppins(
                                color: AppColors.mainColor,
                                fontSize: 21,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'TO BE COMPLETED FOR FULL OR PARTIAL FINANCE BY APPLICANT',
                        style: GoogleFonts.poppins(
                            color: AppColors.neutral,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ]),
                    bottom: TabBar(
                      labelColor: Color(0xFFff7300), //<-- selected text color
                      unselectedLabelColor:
                          AppColors.neutral, //<-- Unselected text color
                      labelStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors
                              .mainColor), // Font color for the selected tab
                      indicatorColor: AppColors.mainColor,
                      unselectedLabelStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color:
                              Colors.amber), // Font color for unselected tabs

                      controller: myTabController
                          .tabController, // remove this to make the direct tab click disabled
                      onTap: null,
                      isScrollable: false,
                      tabs: [
                        Tab(
                          text: 'PART 1',
                        ),
                        Tab(text: 'PART 2'),
                        Tab(text: 'PART 3'),
                        // Tab(text: 'PART 4'),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    controller: myTabController.tabController,
                    children: [
                      SectionOne(myTabController, myTabController.tabController,
                          widget.requestid),
                      SectionTwo(myTabController, myTabController.tabController,
                          widget.requestid),
                      SectionThree(myTabController,
                          myTabController.tabController, widget.requestid),
                      //  SectionFour(
                      //      myTabController, myTabController.tabController),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.requestid);
    myTabController.tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    myTabController.tabController.dispose(); // Dispose of the TabController
    super.dispose();
  }

  // Function to fetch data from the API using dio with Bearer token
  Future<void> fetchData(int? requestId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
    });
    try {
      Dio dio = Dio();

      // Replace 'YOUR_BEARER_TOKEN' with the actual Bearer token
      String bearertoken = token!;
      dio.options.headers['Authorization'] = 'Bearer $bearertoken';

      final response = await dio.get(
        '$endpoint/loan_requests/$requestId',
        // Add headers or parameters as needed
      );

      if (response.statusCode == 200) {
        loanDetail = LoanRequestDetails.fromJson(response.data);
        print(loanDetail.applicantCount);
        setState(() {
          print('one');
          myTabController.numberOfPersons = loanDetail.applicantCount;
          isloading = false;
        });
        print(loanDetail.applicantCount);
      } else {
        // Handle error response
        print('ee: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('err: $error');
    }
  }
}

class MyTabController extends ChangeNotifier {
  late TabController tabController;
  int numberOfPersons = 1;
  List<ApplicantDetails> applicants =
      List.generate(4, (_) => ApplicantDetails());
  List<EmployemntandKlinDetails> employmentDetailsList =
      List.generate(4, (_) => EmployemntandKlinDetails());
  LoanDetails loanDetails = LoanDetails();

  void updateApplicants(List<ApplicantDetails> updatedApplicants) {
    applicants = updatedApplicants;
    notifyListeners();
  }

  void updateEMplymentandKlin(
      List<EmployemntandKlinDetails> updatedEmploymentandKlin) {
    employmentDetailsList = updatedEmploymentandKlin;
    notifyListeners();
  }

  void updateLoanInfo(LoanDetails updateLoaninfo) {
    loanDetails = updateLoaninfo;
    notifyListeners();
  }

  void updateNumberOfPersons(int value) {
    if (value > numberOfPersons) {
      applicants.addAll(List.generate(
        value - numberOfPersons,
        (_) => ApplicantDetails(),
      ));
    } else if (value < numberOfPersons) {
      applicants.removeRange(value, numberOfPersons);
    }

    numberOfPersons = value;
    notifyListeners();
  }
}
