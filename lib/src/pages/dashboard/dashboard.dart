// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/widgets.dart';
import 'package:netone_loanmanagement_admin/src/createapplication/createapp.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/agents.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/assigntome.dart';
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
  String? email;
  String? token;
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
                  if (role == 'Agent' && role != 'Admin')
                    SidebarTab(
                      title: 'Assign to Me',
                      isSelected: selectedTab == 'assigntome',
                      onTap: () => onTabSelected('assigntome'),
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
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeAndDate();
    });
    gettokens();
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
      // case 'all_customers':
      //   return CustomerSection();
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
  int touchedGroupIndex = -1;
  String? email;
  String? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (role == 'Admin' && role != 'Agent')
          ? IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            )
          : SizedBox(),
      backgroundColor: AppColors.mainbackground,
      body: ListView(children: [
        Wrap(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              height: 300,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 80,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: AppColors.mainColor,
                        text: 'First',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: AppColors.sidebarbackground,
                        text: 'Second',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: AppColors.neutral,
                        text: 'Third',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: AppColors.textLight,
                        text: 'Fourth',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 38,
                    ),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          maxY: 20,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.grey,
                              getTooltipItem: (a, b, c, d) => null,
                            ),
                            touchCallback: (FlTouchEvent event, response) {
                              if (response == null || response.spot == null) {
                                setState(() {
                                  touchedGroupIndex = -1;
                                  showingBarGroups = List.of(rawBarGroups);
                                });
                                return;
                              }

                              touchedGroupIndex =
                                  response.spot!.touchedBarGroupIndex;

                              setState(() {
                                if (!event.isInterestedForInteractions) {
                                  touchedGroupIndex = -1;
                                  showingBarGroups = List.of(rawBarGroups);
                                  return;
                                }
                                showingBarGroups = List.of(rawBarGroups);
                                if (touchedGroupIndex != -1) {
                                  var sum = 0.0;
                                  for (final rod
                                      in showingBarGroups[touchedGroupIndex]
                                          .barRods) {
                                    sum += rod.toY;
                                  }
                                  final avg = sum /
                                      showingBarGroups[touchedGroupIndex]
                                          .barRods
                                          .length;

                                  showingBarGroups[touchedGroupIndex] =
                                      showingBarGroups[touchedGroupIndex]
                                          .copyWith(
                                    barRods: showingBarGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(
                                          toY: avg, color: widget.avgColor);
                                    }).toList(),
                                  );
                                }
                              });
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: bottomTitles,
                                reservedSize: 42,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                interval: 1,
                                getTitlesWidget: leftTitles,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                          gridData: const FlGridData(show: false),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  void gettokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      email = prefs.getString('email');
      role = prefs.getString('role');
    });
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

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.sidebarbackground,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.neutral,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.neutral,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.sidebarbackground,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.mainbackground,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: GoogleFonts.dmSans(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.neutral,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.mainColor,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.neutral,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
