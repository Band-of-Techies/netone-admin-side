// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/widgets.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/constants/colors.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/createapp.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/agents.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/assigntome.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/assigntome_afterbank.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/bankapproved.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/bankstatus.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/category.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/closedorders.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/products.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/searchSection.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/netonestatus.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/orderconfirmed.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/orderdeliverd.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/rejected.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/request.dart';
import 'package:netone_loanmanagement_admin/src/pages/loginsection/login/log_in_page.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/agentinfo.dart';
import 'package:netone_loanmanagement_admin/src/res/apis/agents.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:netone_loanmanagement_admin/config/config_dev.dart';

final String endpoint = AppConfig.apiUrl;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedTab = 'dashboard';
  String datetimestart = DateTime.now().toString();
  String currentTime = '';
  String currentDate = '';
  String? email;
  String? token;
  late Timer _timer;
  String? role;
  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainbackground,
        automaticallyImplyLeading: false,
        leadingWidth: 250,
        centerTitle: false,
        leading: Container(
            width: 250,
            color: AppColors.sidebarbackground,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  '../assets/png/netone.png',
                  width: 150,
                  height: 150,
                  scale: .6,
                ),
              ),
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: currentTime,
              fontSize: 15,
            ),
            CustomText(
              text: currentDate,
              fontSize: 12,
            ),
          ],
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        AssetImage('../../assets/png/avatar-1.png'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CustomText(text: email!),
                  SizedBox(
                    width: 20,
                  )
                ],
              )),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: BoxDecoration(color: AppColors.sidebarbackground),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Session Started:',
                          style: GoogleFonts.dmSans(
                              fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datetimestart,
                          style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SidebarTab(
                    title: 'Dashboard',
                    isSelected: selectedTab == 'dashboard',
                    onTap: () => onTabSelected('dashboard'),
                  ),
                  if (role == 'Admin' && role != 'Agent')
                    SidebarTab(
                      title: 'Requests',
                      isSelected: selectedTab == 'requests',
                      onTap: () => onTabSelected('requests'),
                    ),
                  if (role == 'sales')
                    SidebarTab(
                      title: 'Assign to Me',
                      isSelected: selectedTab == 'assigntome',
                      onTap: () => onTabSelected('assigntome'),
                    ),
                  if (role == 'sales' || role == 'Admin')
                    SidebarTab(
                      title: 'Netone Status',
                      isSelected: selectedTab == 'neteon_status',
                      onTap: () => onTabSelected('neteon_status'),
                    ),
                  if (role == 'sales' || role == 'Admin')
                    SidebarTab(
                      title: 'Bank Status',
                      isSelected: selectedTab == 'bank_status',
                      onTap: () => onTabSelected('bank_status'),
                    ),
                  if (role == 'Admin')
                    SidebarTab(
                      title: 'Bank Approved',
                      isSelected: selectedTab == 'bank_approved',
                      onTap: () => onTabSelected('bank_approved'),
                    ),
                  if (role == 'delivery')
                    SidebarTab(
                      title: 'Assign to Me',
                      isSelected: selectedTab == 'assigntome_after_bank',
                      onTap: () => onTabSelected('assigntome_after_bank'),
                    ),
                  if (role == 'delivery' || role == 'Admin')
                    SidebarTab(
                      title: 'Order Confirmed',
                      isSelected: selectedTab == 'order_confirmed',
                      onTap: () => onTabSelected('order_confirmed'),
                    ),
                  if (role == 'delivery' || role == 'Admin')
                    SidebarTab(
                      title: 'Order Delivered',
                      isSelected: selectedTab == 'order_delivered',
                      onTap: () => onTabSelected('order_delivered'),
                    ),
                  if (role == 'delivery' || role == 'Admin')
                    SidebarTab(
                      title: 'Order Closed',
                      isSelected: selectedTab == 'order_closed',
                      onTap: () => onTabSelected('order_closed'),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  SidebarTab(
                    title: 'Search',
                    isSelected: selectedTab == 'search_requests',
                    onTap: () => onTabSelected('search_requests'),
                  ),
                  // SidebarTab(
                  //   title: 'All Customers',
                  //   isSelected: selectedTab == 'all_customers',
                  //   onTap: () => onTabSelected('all_customers'),
                  // ),
                  SidebarTab(
                    title: 'Rejected',
                    isSelected: selectedTab == 'order_rejected',
                    onTap: () => onTabSelected('order_rejected'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (role == 'Admin')
                    SidebarTab(
                      title: 'Category',
                      isSelected: selectedTab == 'category',
                      onTap: () => onTabSelected('category'),
                    ),
                  if (role == 'Admin')
                    SidebarTab(
                      title: 'Products',
                      isSelected: selectedTab == 'products',
                      onTap: () => onTabSelected('products'),
                    ),
                  if (role == 'Admin')
                    SidebarTab(
                      title: 'Agents',
                      isSelected: selectedTab == 'agents',
                      onTap: () => onTabSelected('agents'),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  SidebarTab(
                    title: 'Logout',
                    isSelected: selectedTab == 'logout',
                    onTap: () => onTabSelected('logout'),
                  ),
                ],
              ),
            ),
          ),
          // Content based on selected tab
          Expanded(
            child: Container(
              color: AppColors.mainbackground,
              padding: EdgeInsets.all(20),
              child: getContentBasedOnTab(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Update time and date every second
    _updateTimeAndDate();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeAndDate();
    });
    gettokens();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void _updateTimeAndDate() {
    setState(() {
      final now = DateTime.now();
      currentTime = DateFormat('hh:mm a').format(now);
      currentDate = DateFormat('d MMMM yyyy').format(now);
    });
  }

  void gettokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
      role = prefs.getString('role');
    });
  }

  Widget getContentBasedOnTab() {
    switch (selectedTab) {
      case 'dashboard':
        return DashboardContent();
      case 'requests':
        return RequestsSection();
      case 'assigntome':
        return AssignToMe();
      case 'assigntome_after_bank':
        return AssignToMeAfterBank();
      case 'neteon_status':
        return NetoneStatusSection();
      case 'bank_status':
        return BankStatusSection();
      case 'order_confirmed':
        return OrderConfirmedStatus();
      case 'order_delivered':
        return OrderDeliverdStatus();
      case 'order_closed':
        return ClosedOrderStatus();
      case 'order_rejected':
        return RejectedStatus();
      case 'bank_approved':
        return BankApproved();
      case 'agents':
        return AgentStatus();
      case 'search_requests':
        return SearchStatus();
      case 'products':
        return ProductsStatus();
      case 'category':
        return CategoryStatus();
      case 'logout':
        clearSharedPreferences();
        return SizedBox();
      default:
        return Container();
    }
  }

  void clearSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    sharedPreferences.remove('email');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) =>
          false, // This predicate always returns false, so it removes all routes
    );
  }
}

class SidebarTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        color: isSelected ? Colors.orange : Colors.transparent,
        child: Text(
          title,
          style: GoogleFonts.dmSans(
            color: isSelected ? Colors.white : AppColors.unselected,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Implement content widgets for each tab (e.g., DashboardContent, RequestsContent, etc.)
class DashboardContent extends StatefulWidget {
  final Color leftBarColor = AppColors.mainColor;
  final Color rightBarColor = AppColors.neutral;
  final Color avgColor = AppColors.sidebarbackground;

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final double width = 7;
  int touchedIndex = -1;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  String? role;
  String? userid;
  int touchedGroupIndex = -1;
  String? email;
  ScrollController _scrollController = ScrollController();
  String? token;
  bool isloading = true;
  bool isloading_sub = false;
  bool isloading_agent_sub = true;
  String? errortext;
  String? sub_error;
  String? sub_agent_error;
  List<Agent> agents = [];
  AgentInfo? agentDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (role == 'sales' && role != 'Admin')
          ? CircleAvatar(
              backgroundColor: primary,
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: whitefont,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            )
          : SizedBox(),
      backgroundColor: AppColors.mainbackground,
      body: role == 'Admin'
          ? isloading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                )
              : isloading == false && errortext != null
                  ? Center(
                      child: CustomText(text: errortext!),
                    )
                  : Theme(
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .25,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < agents.length; i++)
                                        GestureDetector(
                                          onTap: () {
                                            getAgentDetails(
                                                token!, agents[i].id);
                                            setState(() {
                                              isloading_sub = true;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  25, 15, 25, 15),
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color:
                                                    AppColors.sidebarbackground,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        'Name: ${agents[i].name}',
                                                    color: AppColors.mainColor,
                                                    fontSize: 16,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Role: ${agents[i].kind}',
                                                        color:
                                                            AppColors.neutral,
                                                        fontSize: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Request: ${agents[i].totalRequests}',
                                                        color:
                                                            AppColors.neutral,
                                                        fontSize: 12,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              isloading_sub == true
                                  ? Container(
                                      height: 250,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    )
                                  : agentDetails != null
                                      ? SingleChildScrollView(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            padding: EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  AppColors.sidebarbackground,
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            agentDetails!.name,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.mainColor,
                                                      ),
                                                      CustomText(
                                                        text: agentDetails!
                                                            .assignedRequests[
                                                                'total']
                                                            .toString(),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Agent Role: ${agentDetails!.kind}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            '${agentDetails!.email}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Created: ${convertTimestamp(agentDetails!.createdAt)}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Updated: ${convertTimestamp(agentDetails!.updatedAt)}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Netone Requests: ${agentDetails!.assignedRequests['netone']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['netone']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Bank Status: ${agentDetails!.assignedRequests['bank']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['bank']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Bank Approved: ${agentDetails!.assignedRequests['unconfirmed_orders']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['unconfirmed_orders']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Order Confiremd: ${agentDetails!.assignedRequests['confirmed_orders']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['confirmed_orders']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Delivered: ${agentDetails!.assignedRequests['delivered_orders']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['delivered_orders']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Closed request: ${agentDetails!.assignedRequests['closed_orders']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['closed_orders']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Pending: ${agentDetails!.assignedRequests['order_pending']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['order_pending']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            'Rejected request: ${agentDetails!.assignedRequests['rejected']['count']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'Amount: ${agentDetails!.assignedRequests['rejected']['total_cost']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.neutral,
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        )
                                      : isloading_sub == true
                                          ? Container(
                                              height: 250,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.mainColor,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 250,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4,
                                              child: Center(
                                                child: CustomText(
                                                    text: 'No Datas'),
                                              ),
                                            )
                            ],
                          )),
                    )
          : isloading_agent_sub == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                )
              : sub_agent_error != null
                  ? Center(
                      child: CustomText(text: sub_agent_error!),
                    )
                  : Theme(
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
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width * .4,
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.sidebarbackground,
                              ),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: agentDetails!.name,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.mainColor,
                                        ),
                                        CustomText(
                                          text: agentDetails!
                                              .assignedRequests['total']
                                              .toString(),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Agent Role: ${agentDetails!.kind}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                        CustomText(
                                          text: '${agentDetails!.email}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Created: ${convertTimestamp(agentDetails!.createdAt)}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                        CustomText(
                                          text:
                                              'Updated: ${convertTimestamp(agentDetails!.updatedAt)}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Netone Requests: ${agentDetails!.assignedRequests['netone']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['netone']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Bank Status: ${agentDetails!.assignedRequests['bank']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['bank']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Bank Approved: ${agentDetails!.assignedRequests['unconfirmed_orders']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['unconfirmed_orders']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Order Confiremd: ${agentDetails!.assignedRequests['confirmed_orders']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['confirmed_orders']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Delivered: ${agentDetails!.assignedRequests['delivered_orders']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['delivered_orders']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Closed request: ${agentDetails!.assignedRequests['closed_orders']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['closed_orders']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Pending: ${agentDetails!.assignedRequests['order_pending']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['order_pending']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              'Rejected request: ${agentDetails!.assignedRequests['rejected']['count']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                        CustomText(
                                          text:
                                              'Amount: ${agentDetails!.assignedRequests['rejected']['total_cost']}',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutral,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ))),
    );
  }

  @override
  void initState() {
    super.initState();
    gettokens();
  }

  void getAgents(String tokenValue) async {
    String url = '$endpoint/users';

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> responseData = response.data['users'];
        setState(() {
          agents = responseData.map((json) => Agent.fromJson(json)).toList();

          isloading = false;
          errortext = null;
        });
      } else {
        // Handle error
        setState(() {
          isloading = false;
          errortext = 'Error:404';
        });
        print('Failed to load agents: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      setState(() {
        isloading = false;
        errortext = 'Error';
      });
      print('Error fetching agents: $e');
    }
  }

  String convertTimestamp(String timestamp) {
    // Parse the provided timestamp string
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the DateTime object into the desired format
    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

    return formattedDate;
  }

  void getAgentDetails(String tokenValue, dynamic agentId) async {
    String url = '$endpoint/users/$agentId';

    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $tokenValue';

      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        setState(() {
          agentDetails = AgentInfo.fromJson(responseData);
          isloading_sub = false;
          isloading_agent_sub = false;
          sub_agent_error = null;
        });
      } else {
        // Handle error
        print('Failed to load agent details: ${response.statusCode}');
        setState(() {
          isloading_agent_sub = false;
          sub_agent_error =
              'Failed to load agent details: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Handle network error
      print('Error fetching agent details: $e');
      setState(() {
        isloading_agent_sub = false;
        sub_agent_error = 'Error fetching agent details';
      });
    }
  }

  void gettokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
      role = prefs.getString('role');
      userid = prefs.getString('userid');
    });
    if (role == 'Admin') {
      getAgents(token!);
    }
    if (role == 'sales' || role == 'delivery') {
      getAgentDetails(token!, userid);
    }
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: CustomText(text: text),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = CustomText(
      text: titles[value.toInt()],
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
