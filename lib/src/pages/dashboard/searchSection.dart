import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/compontents/requstcard.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class SearchStatus extends StatefulWidget {
  const SearchStatus({super.key});

  @override
  State<SearchStatus> createState() => _SearchStatusState();
}

class _SearchStatusState extends State<SearchStatus> {
  TextEditingController requestid = TextEditingController();
  TextEditingController customername = TextEditingController();
  TextEditingController licnesenumber = TextEditingController();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  List<String> productslist = ['Mobile', 'Laptop', 'Tv', 'Fridge'];
  List<String> agentList = ['Agent 1', 'Agent 2', 'Agent 3'];
  String selectedProduct = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 350,
                    child: CustomTextFormField(
                      labeltext: 'Form ID',
                      controller: requestid,
                      onSubmit: () {},
                    ),
                  ),
                  CustomText(fontSize: 12, text: 'OR'),
                  SizedBox(
                    width: 350,
                    child: CustomTextFormField(
                      labeltext: 'Customer Name',
                      controller: customername,
                      onSubmit: () {},
                    ),
                  ),
                  CustomText(fontSize: 12, text: 'OR'),
                  SizedBox(
                    width: 350,
                    child: CustomTextFormField(
                      labeltext: 'License Number',
                      controller: licnesenumber,
                      onSubmit: () {},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(fontSize: 12, text: 'OR'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 350,
                      child: GestureDetector(
                        onTap: () async {
                          await _selectDate(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            readOnly: true,
                            controller: startdate,
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                              labelStyle: GoogleFonts.dmSans(
                                color: AppColors.neutral,
                                height: 0.5,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: AppColors.neutral, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: AppColors.neutral, width: 0.5),
                              ),
                            ),
                            style: GoogleFonts.dmSans(
                              color: AppColors.neutral,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                      width: 350,
                      child: GestureDetector(
                        onTap: () async {
                          await _enddate(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            readOnly: true,
                            controller: enddate,
                            decoration: InputDecoration(
                              labelText: 'End Date',
                              labelStyle: GoogleFonts.dmSans(
                                color: AppColors.neutral,
                                height: 0.5,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    color: AppColors.neutral, width: .5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: AppColors.neutral, width: .5),
                              ),
                            ),
                            style: GoogleFonts.dmSans(
                              color: AppColors.neutral,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 350,
                    child: DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        focusColor: AppColors.neutral,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.neutral, width: .5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.neutral, width: .5)),
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.neutral),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // Add more decoration..
                      ),
                      hint: Text(
                        'Choose Product',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, color: AppColors.neutral),
                      ),
                      items: productslist
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: CustomText(
                                  fontSize: 14,
                                  color: AppColors.neutral,
                                  text: item,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        //Do something when selected item is changed.
                      },
                      onSaved: (value) {
                        selectedProduct = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.neutral,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: AppColors.sidebarbackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              for (int i = 0; i < 10; i++) SizedBox()
              /* RequestItem(
                  loanid: 12,
                  agent: 'Agent Name',
                  functionstring: 'Bank Status',
                  productname: 'Mobile',
                  amount: '10,000',
                  requestId: 'NR12473',
                  customerName: 'requestData.customerName',
                  date: '12 Nov 2023',
                  isChecked: false,
                  onCheckboxChanged: (value) {
                    setState(() {});
                    // Handle checkbox change, if needed
                  },
                  agents: agentList,
                  selectedAgent: 'Agent',
                  onAgentSelected: (agent) {
                    setState(() {});
                    // Handle agent selection, if needed
                  },
                  onConfirm: () {
                    // Handle confirmation
                  },
                  onVerticalMenuPressed: () {
                    // Handle vertical menu press
                  },
                )*/
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // if backend requires time and date in another format use staring in applicant details and assign here, controller in textfield
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        startdate.text = formattedDate;
      });
    }
  }

  Future<void> _enddate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // if backend requires time and date in another format use staring in applicant details and assign here, controller in textfield
        String formattedDate = DateFormat('dd MMMM yyyy').format(picked);
        enddate.text = formattedDate;
      });
    }
  }
}
