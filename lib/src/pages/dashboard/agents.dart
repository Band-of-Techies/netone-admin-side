// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Map<String, dynamic>> agentsList = [];
  String? createddate;
  String? emailpref;
  String? token;
  bool isEditing = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackground,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppColors.neutral,
        ),
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          usernameController.clear();
          confirmPasswordController.clear();
          passwordController.clear();
          _showAddAgentPopup(context);
        },
      ),
      body: agentsList != null && agentsList.isNotEmpty
          ? Wrap(children: [
              for (int i = 0; i < agentsList.length; i++)
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * .35,
                    height: MediaQuery.of(context).size.height * .1,
                    decoration: BoxDecoration(
                        color: AppColors.sidebarbackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 120,
                              height: MediaQuery.of(context).size.height * .18,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    scale: .5,
                                    opacity: .7,
                                    image: AssetImage(
                                        '../../assets/png/agent.png'), // Replace 'your_image.png' with the path to your image asset
                                    fit: BoxFit.contain,
                                  ),
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(text: agentsList[i]['name']),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      CustomText(
                                        text: agentsList[i]['role'],
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: agentsList[i]['email'],
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            right: 5,
                            top: 5,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.mainbackground,
                              ),
                              onPressed: () {
                                _showDeleteConfirmationDialog(
                                    context, agentsList[i]['id'].toString());
                                // Show the confirmation dialog
                              },
                            ))
                      ],
                    ),
                  ),
                )
            ])
          : Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yy, hh:mma').format(dateTime);
    return formattedDate;
  }

  Widget buildEditableField(String labelText, TextEditingController controller,
      String? Function(String?)? validator) {
    return TextFormField(
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

  @override
  void initState() {
    super.initState();
    fetchDataAndBuildUI();
  }

  Future<void> fetchDataAndBuildUI() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      emailpref = prefs.getString('email');
    });
    try {
      // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
      String bearerToken = token!;

      final response = await Dio().get(
        'https://loan-managment.onrender.com/users',
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          agentsList = List<Map<String, dynamic>>.from(response.data['users']);
        });
      } else {
        // If the request fails, you can throw an exception or handle it accordingly
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      // Handle Dio errors or network errors
      print('Error: $error');
      throw Exception('Failed to load user data');
    }
  }

  Future<void> createUser(String name, String password, String confirmPassword,
      String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      emailpref = prefs.getString('email');
    });
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
            'Authorization': token!,
          },
        ),
      );

      // Check if the response status code is in the success range (200-299)
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful request
        fetchDataAndBuildUI();
        Navigator.pop(context);
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

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String agentid) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.sidebarbackground,
          title: CustomText(text: 'Delete Confirmation'),
          content: CustomText(text: 'Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomText(text: 'Cancel'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor)),
              onPressed: () {
                _deleteAgent(agentid);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: CustomText(text: 'Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAgent(String agentid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      emailpref = prefs.getString('email');
    });
    try {
      print(agentid);
      Dio dio = Dio();
      dio.options.headers['Authorization'] = token!;
      final response = await dio
          .delete('https://loan-managment.onrender.com/users/$agentid');

      // Check the response status code and handle accordingly
      if (response.statusCode! > 200 || response.statusCode! < 290) {
        // Successful delete
        fetchDataAndBuildUI();
        print('Product deleted successfully.');
      } else {
        // Handle error
        print('Error deleting product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors
      print('Dio error: $error');
    }
  }

  void _showAddAgentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.sidebarbackground,
          title: CustomText(text: 'Add Agent'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: Form(
              key: _formKeycreateagent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add your form fields or content for adding a product
                  buildEditableField(
                    'Username',
                    usernameController,
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
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the popup
                Navigator.of(context).pop();
              },
              child: CustomText(
                text: 'Cancel',
                fontSize: 16,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.mainColor)),
              onPressed: () async {
                if (_formKeycreateagent.currentState!.validate()) {
                  createUser(usernameController.text, passwordController.text,
                      confirmPasswordController.text, emailController.text);
                }
              },
              child: CustomText(
                text: 'Add',
                fontSize: 16,
                color: AppColors.neutral,
              ),
            ),
          ],
        );
      },
    );
  }
}
