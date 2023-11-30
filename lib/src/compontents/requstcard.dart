// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/pages/applications/viewapplication.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class RequestItem extends StatefulWidget {
  final String requestId;
  final String customerName;
  final String date;
  final bool isChecked;
  final Function(bool?) onCheckboxChanged;
  final List<String> agents;
  final String selectedAgent;
  final Function(String?) onAgentSelected;
  final VoidCallback onConfirm;
  final VoidCallback onVerticalMenuPressed;
  final String productname;
  final String amount;
  final String functionstring;
  final String agent;

  RequestItem({
    required this.agent,
    required this.functionstring,
    required this.requestId,
    required this.customerName,
    required this.date,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.agents,
    required this.selectedAgent,
    required this.onAgentSelected,
    required this.onConfirm,
    required this.onVerticalMenuPressed,
    required this.amount,
    required this.productname,
  });

  @override
  _RequestItemState createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.sidebarbackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white, // Set the border color to white
                      width: 1.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(
                        4.0), // Adjust the border radius as needed
                  ),
                  checkColor: Colors.white,
                  focusColor: Colors.white,
                  activeColor: AppColors.mainColor,
                  value: widget.isChecked,
                  onChanged: widget.onCheckboxChanged,
                ),
                SizedBox(width: 12),
                CustomText(fontSize: 14, text: widget.requestId),
                SizedBox(
                  width: 15,
                ),
                CustomText(
                  fontSize: 13,
                  text: widget.agent,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
            Row(
              children: [
                //check male or female here, so can check and show iamges accoridngly

                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('../../assets/png/avatar-4.png'),
                ),
                SizedBox(
                  width: 15,
                ),
                CustomText(
                  fontSize: 15,
                  text: widget.customerName,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            CustomText(
              fontSize: 14,
              text: widget.date,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              fontSize: 14,
              text: widget.amount,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              fontSize: 14,
              text: widget.productname,
              fontWeight: FontWeight.w400,
            ),
            Row(
              children: [
                SizedBox(
                  width: 160,
                  child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // Add more decoration..
                    ),
                    hint: Text(
                      widget.functionstring,
                      style: GoogleFonts.dmSans(
                          fontSize: 14, color: AppColors.neutral),
                    ),
                    items: widget.agents.map((agent) {
                      return DropdownMenuItem<String>(
                        value: agent,
                        child: CustomText(
                          fontSize: 14,
                          color: AppColors.neutral,
                          text: agent,
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return widget.functionstring;
                      }
                      return null;
                    },
                    onChanged: widget.onAgentSelected,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
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
                SizedBox(
                  width: 30,
                ),
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(20, 5, 20, 5)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the border radius as needed
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainColor)),
                    onPressed: () {},
                    child: CustomText(
                      fontSize: 14,
                      color: AppColors.neutral,
                      text: 'Submit',
                    )),
                SizedBox(
                  width: 30,
                ),
                PopupMenuButton<String>(
                  color: AppColors.sidebarbackground,
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.neutral,
                  ),
                  onSelected: (value) {
                    // Handle the selected option
                    if (value == 'edit') {
                      // Handle edit action
                    } else if (value == 'delete') {
                      // Handle delete action
                    } else if (value == 'view') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewApplication()),
                      );
                      // Handle view action
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        textStyle: GoogleFonts.dmSans(color: AppColors.neutral),
                        value: 'view',
                        child: CustomText(
                          fontSize: 13,
                          text: 'View',
                        ),
                      ),
                      PopupMenuItem<String>(
                          textStyle:
                              GoogleFonts.dmSans(color: AppColors.neutral),
                          value: 'edit',
                          child: CustomText(
                            fontSize: 13,
                            text: 'Edit',
                          )),
                      PopupMenuItem<String>(
                        textStyle: GoogleFonts.dmSans(color: AppColors.neutral),
                        value: 'delete',
                        child: CustomText(
                          fontSize: 13,
                          text: 'Delete',
                        ),
                      ),
                    ];
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
