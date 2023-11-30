// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class CustomerCard extends StatelessWidget {
  final String customerName;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String gender;

  CustomerCard({
    required this.gender,
    required this.customerName,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.sidebarbackground,
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width * .15,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.0, 15, 12, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add customer image here if needed
            CircleAvatar(
              radius: 40,
              backgroundImage: gender == 'Male'
                  ? AssetImage('../assets/png/avatar-4.png')
                  : AssetImage('../assets/png/avatar-5.png'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(fontSize: 15, text: customerName),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    size: 20,
                    color: AppColors.neutral,
                  ),
                  onPressed: onView,
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                    color: AppColors.neutral,
                  ),
                  onPressed: onEdit,
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: AppColors.neutral,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
