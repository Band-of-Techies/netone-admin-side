import 'package:flutter/material.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';

class BankStatusSection extends StatefulWidget {
  const BankStatusSection({super.key});

  @override
  State<BankStatusSection> createState() => _BankStatusSectionState();
}

class _BankStatusSectionState extends State<BankStatusSection> {
  TextEditingController search = TextEditingController();
  // Mock data for demonstration purposes
  List<String> bankstauslist = ['Approve', 'Reject'];
  String selectedStatus = '';
  List<RequestData> requestList = List.generate(
    10,
    (index) => RequestData(
      selectedstatus: '',
      functionstring: 'Bank Status',
      productname: 'Mobile Phone',
      amount: '10,000',
      requestId: 'NR23344',
      customerName: 'John Doe',
      date: '12 Nov 2023',
      isChecked: false,
      selectedAgent: 'Name Here',
    ),
  );

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
            onSubmit: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: requestList.length,
        itemBuilder: (context, index) {
          RequestData requestData = requestList[index];
          return SizedBox();
          /*   return RequestItem(
            loanid: 12,
            agent: requestData.selectedAgent,
            functionstring: requestData.functionstring,
            productname: requestData.productname,
            amount: requestData.amount,
            requestId: requestData.requestId,
            customerName: requestData.customerName,
            date: requestData.date,
            isChecked: requestData.isChecked,
            onCheckboxChanged: (value) {
              setState(() {
                requestData.isChecked = value!;
              });
              // Handle checkbox change, if needed
            },
            agents: bankstauslist,
            selectedAgent: requestData.selectedAgent,
            onAgentSelected: (status) {
              setState(() {
                requestData.selectedstatus = status!;
              });
              // Handle agent selection, if needed
            },
            onConfirm: () {
              // Handle confirmation
            },
            onVerticalMenuPressed: () {
              // Handle vertical menu press
            },
          );*/
        },
      ),
    );
  }
}

class RequestData {
  final String productname;
  final String amount;
  final String requestId;
  final String customerName;
  final String functionstring;
  final String date;
  bool isChecked;
  String selectedAgent;
  String selectedstatus;

  RequestData({
    required this.selectedstatus,
    required this.functionstring,
    required this.amount,
    required this.productname,
    required this.requestId,
    required this.customerName,
    required this.date,
    required this.isChecked,
    required this.selectedAgent,
  });
}
