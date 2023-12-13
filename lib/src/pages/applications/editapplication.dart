import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicant.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/applicationdetails.dart';
import 'package:netone_loanmanagement_admin/src/application/datas/loandetails.dart';
import 'package:netone_loanmanagement_admin/src/application/sectionfour.dart';
import 'package:netone_loanmanagement_admin/src/application/sectionone.dart';
import 'package:netone_loanmanagement_admin/src/application/sectionthree.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:provider/provider.dart';

import '../../application/sectiontwo.dart';

class EditApplication extends StatefulWidget {
  const EditApplication({super.key});

  @override
  State<EditApplication> createState() => _EditApplicationState();
}

class _EditApplicationState extends State<EditApplication>
    with TickerProviderStateMixin {
  final MyTabController myTabController = MyTabController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyTabController(),
      child: DefaultTabController(
        length: 4, // Number of tabs (sections)
        child: Scaffold(
          backgroundColor: AppColors.mainbackground,
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
                            loanRequestId: 11,
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
                  color:
                      AppColors.mainColor), // Font color for the selected tab
              indicatorColor: AppColors.mainColor,
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
    );
  }

  @override
  void initState() {
    super.initState();
    myTabController.tabController = TabController(length: 4, vsync: this);
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
