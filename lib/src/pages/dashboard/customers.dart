import 'package:flutter/material.dart';
import 'package:netone_loanmanagement_admin/src/compontents/customercard.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/serchTextFiled.dart';

class CustomerSection extends StatefulWidget {
  const CustomerSection({super.key});

  @override
  State<CustomerSection> createState() => _CustomerSectionState();
}

class _CustomerSectionState extends State<CustomerSection> {
  TextEditingController search = TextEditingController();
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
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(12, (index) {
              return CustomerCard(
                gender: 'Male',
                customerName: 'Customer $index',
                // Add other necessary data
                onView: () {
                  // Handle view action
                },
                onEdit: () {
                  // Handle edit action
                },
                onDelete: () {
                  // Handle delete action
                },
              );
            }),
          ),
        ));
  }
}
