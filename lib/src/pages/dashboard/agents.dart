// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';

class AgentStatus extends StatefulWidget {
  const AgentStatus({super.key});

  @override
  State<AgentStatus> createState() => _AgentStatusState();
}

class _AgentStatusState extends State<AgentStatus> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKeycreateagent = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyeditagent = GlobalKey<FormState>();
  TextEditingController addusernameController = TextEditingController();
  TextEditingController addpasswordController = TextEditingController();
  TextEditingController addconfirmPasswordController = TextEditingController();
  TextEditingController addemailController = TextEditingController();

  bool isEditing = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      body: SingleChildScrollView(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 800,
            child: Form(
              key: _formKeyeditagent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      for (int i = 0; i < 10; i++)
                        agentcontainer('Agent ${i + 1}'),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 500,
                    child: Column(
                      children: [
                        buildEditableField(
                          'Username',
                          usernameController,
                          isEditing,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            } else if (value.length < 6) {
                              return 'Username must be at least 6 characters long';
                            }
                            return null; // Return null if validation passes
                          },
                        ),
                        SizedBox(height: 30),
                        buildEditableField(
                          'Email',
                          emailController,
                          isEditing,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!value.contains('@') ||
                                !value.contains('.com')) {
                              return 'Email format error';
                            }
                            return null; // Return null if validation passes
                          },
                        ),
                        SizedBox(height: 30),
                        buildEditableField(
                          'Password',
                          passwordController,
                          isEditing,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null; // Return null if validation passes
                          },
                        ),
                        SizedBox(height: 30),
                        buildEditableField(
                          'Confirm Password',
                          confirmPasswordController,
                          isEditing,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null; // Return null if validation passes
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  //show this button only when agents are fetched and clicked on any of the agents
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.mainColor),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(15))),
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                        if (_formKeyeditagent.currentState?.validate() ??
                            false) {
                          // The form is valid, perform the necessary actions
                        }
                      },
                      child: CustomText(
                        text: isEditing == true ? 'Edit' : 'Update',
                        color: AppColors.neutral,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            width: 2, // Adjust the width as needed
            color: AppColors.neutral, // Set the color of the divider
          ),
          Form(
            key: _formKeycreateagent,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      buildEditableField(
                        'Username',
                        addusernameController,
                        false,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          } else if (value.length < 6) {
                            return 'Username must be at least 6 characters long';
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                      SizedBox(height: 30),
                      buildEditableField(
                        'Email',
                        addemailController,
                        false,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!value.contains('@') ||
                              !value.contains('.com')) {
                            return 'Email format error';
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                      SizedBox(height: 30),
                      buildEditableField(
                        'Password',
                        addpasswordController,
                        false,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$')
                              .hasMatch(value)) {
                            return 'Password must contain at least one letter, one number, and be at least 6 characters long';
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                      SizedBox(height: 30),
                      buildEditableField(
                        'Confirm Password',
                        addconfirmPasswordController,
                        false,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != addpasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null; // Return null if validation passes
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainColor),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    onPressed: () {
                      if (_formKeycreateagent.currentState?.validate() ??
                          false) {
                        createUser(
                            addusernameController.text,
                            addpasswordController.text,
                            addconfirmPasswordController.text,
                            addemailController.text);
                        // The form is valid, perform the necessary actions
                      }
                    },
                    child: const CustomText(
                      text: 'Add Agent',
                      color: AppColors.neutral,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }

  Container agentcontainer(String title) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.sidebarbackground),
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      margin: EdgeInsets.all(6),
      child: CustomText(
        text: title,
        color: AppColors.neutral,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget buildEditableField(String labelText, TextEditingController controller,
      bool isEditing, String? Function(String?)? validator) {
    return TextFormField(
      readOnly: isEditing,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.dmSans(
          color: AppColors.neutral,
          height: 0.5,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.neutral, width: 1.0),
        ),
      ),
      style: GoogleFonts.dmSans(
        color: AppColors.neutral,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
    );
  }

  Future<void> createUser(String name, String password, String confirmPassword,
      String email) async {
    try {
      final response = await Dio().post(
        'https://loan-managment.onrender.com/users',
        data: {
          'user': {
            'name': name,
            'password': password,
            'password_confirmation': confirmPassword,
            'email': email,
          },
        },
        options: Options(
          headers: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHBpcmVzIjoxNzAxNjc0NjE5fQ.6vC4yaryRm4Q3mwfzAPvP-JxbqqF-3YmS6qQW_00bbk',
          },
        ),
      );

      // Check if the response status code is in the success range (200-299)
      if (response.statusCode == 200 && response.statusCode == 201) {
        // Successful request
        warning('Agent Created');
        print('Success: ${response.data}');
      } else {
        warning('Email already exist');
        // Request failed with an error status code
        print('Error: ${response.statusCode}, ${response.data}');
      }
    } catch (error) {
      // Handle Dio errors or network errors
      warning('Error');
    }
  }

  warning(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: MediaQuery.of(context).size.width * .7,
        backgroundColor: AppColors.neutral,
        duration: Duration(seconds: 3),
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: CustomText(
              text: message,
              fontSize: 13,
              color: AppColors.mainbackground,
              fontWeight: FontWeight.w500),
        )));
  }
}
