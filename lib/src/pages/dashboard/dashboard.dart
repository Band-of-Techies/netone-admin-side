// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/agents.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/bankstatus.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/closedorders.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/customers.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/products.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/searchSection.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/netonestatus.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/orderconfirmed.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/orderdeliverd.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/rejected.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/request.dart';
import 'package:netone_loanmanagement_admin/src/pages/loginsection/login/log_in_page.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedTab = 'dashboard';
  String datetimestart = DateTime.now().toString();
  String currentTime = '';
  String currentDate = '';
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
                  '../../assets/png/netone.png',
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
                  Text('admin@netone.com'),
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
                        'Section Started:',
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
                SidebarTab(
                  title: 'Requests',
                  isSelected: selectedTab == 'requests',
                  onTap: () => onTabSelected('requests'),
                ),
                SidebarTab(
                  title: 'Netone Status',
                  isSelected: selectedTab == 'neteon_status',
                  onTap: () => onTabSelected('neteon_status'),
                ),
                SidebarTab(
                  title: 'Bank Status',
                  isSelected: selectedTab == 'bank_status',
                  onTap: () => onTabSelected('bank_status'),
                ),
                SidebarTab(
                  title: 'Order Confirmed',
                  isSelected: selectedTab == 'order_confirmed',
                  onTap: () => onTabSelected('order_confirmed'),
                ),
                SidebarTab(
                  title: 'Order Delivered',
                  isSelected: selectedTab == 'order_delivered',
                  onTap: () => onTabSelected('order_delivered'),
                ),
                SidebarTab(
                  title: 'Order Closed',
                  isSelected: selectedTab == 'order_closed',
                  onTap: () => onTabSelected('order_closed'),
                ),
                SidebarTab(
                  title: 'Search',
                  isSelected: selectedTab == 'search_requests',
                  onTap: () => onTabSelected('search_requests'),
                ),
                SidebarTab(
                  title: 'All Customers',
                  isSelected: selectedTab == 'all_customers',
                  onTap: () => onTabSelected('all_customers'),
                ),
                SidebarTab(
                  title: 'Rejected',
                  isSelected: selectedTab == 'order_rejected',
                  onTap: () => onTabSelected('order_rejected'),
                ),
                SidebarTab(
                  title: 'Products',
                  isSelected: selectedTab == 'products',
                  onTap: () => onTabSelected('products'),
                ),
                SidebarTab(
                  title: 'Agents',
                  isSelected: selectedTab == 'agents',
                  onTap: () => onTabSelected('agents'),
                ),
                SidebarTab(
                  title: 'Logout',
                  isSelected: selectedTab == 'logout',
                  onTap: () => onTabSelected('logout'),
                ),
              ],
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
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeAndDate();
    });
  }

  void _updateTimeAndDate() {
    setState(() {
      final now = DateTime.now();
      currentTime = DateFormat('hh:mm a').format(now);
      currentDate = DateFormat('d MMMM yyyy').format(now);
    });
  }

  Widget getContentBasedOnTab() {
    switch (selectedTab) {
      case 'dashboard':
        return DashboardContent();
      case 'requests':
        return RequestsSection();
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
      case 'all_customers':
        return CustomerSection();
      case 'agents':
        return AgentStatus();
      case 'search_requests':
        return SearchStatus();
      case 'products':
        return ProductsStatus();
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
class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        height: 400,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minX: 0,
            maxX: 7,
            minY: 0,
            maxY: 6,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(1, 1),
                  FlSpot(2, 4),
                  FlSpot(3, 2),
                  FlSpot(4, 5),
                  FlSpot(5, 3),
                  FlSpot(6, 4),
                ],
                isCurved: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
