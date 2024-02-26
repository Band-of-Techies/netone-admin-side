import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/api/applicantdetails.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/api/applicants.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/api/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/sectionfour.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/sectionone.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/sectionthree.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/sectiontwo.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final MyTabController myTabController = MyTabController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => MyTabController(),
        child: DefaultTabController(
          length: 4, // Number of tabs (sections)
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              toolbarHeight: 90,
              title: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  'PUBLIC SERVICE MICRO FINANCE COMPANY',
                  style: GoogleFonts.poppins(
                      color: Color(0xFFff7300),
                      fontSize: 21,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'ASSET LOAN APPLICATION FORM',
                  style: GoogleFonts.poppins(
                      color: Color(0xFFff7300),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'TO BE COMPLETED FOR FULL OR PARTIAL FINANCE BY APPLICANT',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                )
              ]),
              bottom: TabBar(
                labelColor: Color(0xFFff7300), //<-- selected text color
                unselectedLabelColor: Colors.black, //<-- Unselected text color
                labelStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.red), // Font color for the selected tab
                indicatorColor: Colors.red,
                unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.amber), // Font color for unselected tabs

                controller: myTabController
                    .tabController, // remove this to make the direct tab click disabled
                onTap: null,
                isScrollable: false,
                tabs: [
                  Tab(text: 'PART 1'),
                  Tab(text: 'PART 2'),
                  Tab(text: 'PART 3'),
                  Tab(text: 'PART 4'),
                ],
              ),
            ),
            body: TabBarView(
              controller: myTabController.tabController,
              children: [
                SectionOne(myTabController, myTabController.tabController),
                SectionTwo(myTabController, myTabController.tabController),
                SectionThree(myTabController, myTabController.tabController),
                SectionFour(myTabController, myTabController.tabController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    myTabController.tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    myTabController.tabController.dispose(); // Dispose of the TabController
    super.dispose();
  }
}

class MyTabController extends ChangeNotifier {
  late TabController tabController;
  int numberOfPersons = 1; // Add other properties as needed
  List<ApplicantDetails> applicants =
      List.generate(4, (_) => ApplicantDetails());

  List<EmployemntandKlinDetails> employmentDetailsList =
      List.generate(4, (_) => EmployemntandKlinDetails());
  LoanDetails loanDetails = LoanDetails(); // Add LoanDetails property
  // void updateNumberOfPersons(int value) {
  //   numberOfPersons = value;
  //   notifyListeners();
  // }

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
      // Increase the number of persons
      applicants.addAll(List.generate(
        value - numberOfPersons,
        (_) => ApplicantDetails(),
      ));
    } else if (value < numberOfPersons) {
      // Decrease the number of persons
      applicants.removeRange(value, numberOfPersons);
    }

    numberOfPersons = value;
    notifyListeners();
  }
  // Add other methods to update other properties as needed
}
