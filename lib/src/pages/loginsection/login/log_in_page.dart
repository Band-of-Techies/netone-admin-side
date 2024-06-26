// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:netone_loanmanagement_admin/src/pages/dashboard/dashboard.dart';
import 'package:netone_loanmanagement_admin/src/res/colors.dart';
import 'package:netone_loanmanagement_admin/src/res/styles.dart';
import 'package:netone_loanmanagement_admin/src/shared/exc_button.dart';
import 'package:netone_loanmanagement_admin/src/shared/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainbackground,
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/png/netone.png',
                width: 300,
                height: 200,
                scale: .6,
              ),
            ),
          ),
          const CustomText(
            text: 'Login',
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 41),
          const SizedBox(height: 31),
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Username',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            labelText: "Username",
            keyboardType: TextInputType.visiblePassword,
            controller: username,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Password',
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: password,
            labelText: "********",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: true,
            enabled: true,
            suffixIcon: visibilityToggle(togglePasswordVisibility, true),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              SizedBox(
                  width: 20,
                  child: Theme(
                      data: ThemeData(unselectedWidgetColor: AppColors.neutral),
                      child: Checkbox(
                        activeColor: AppColors.mainColor,
                        value: rememberMe,
                        onChanged: (newValue) {
                          setState(() {
                            rememberMe = newValue ?? false;
                          });
                        },
                      ))),
              const SizedBox(width: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'Remember Me',
                  fontSize: 16,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 40),
          WonsButton(
            height: 50,
            width: 348,
            verticalPadding: 0,
            color: AppColors.primary,
            child: const CustomText(
              text: 'Login',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            onPressed: () {
              loginUser(username.text, password.text);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  togglePasswordVisibility() {}
  Future<void> loginUser(String email, String password) async {
    try {
      final response = await Dio().post(
        'https://loan-managment.onrender.com/users/sign_in',
        data: {'email': email, 'password': password},
      );

      // Handle the response according to your API structure
      if (response.statusCode == 200) {
        // Successful login, navigate to the dashboard

        // Obtain shared preferences.
        if (rememberMe == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', response.data['token']);
          await prefs.setString('email', email);
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        warning('Invalid Username or password');
        // Handle other status codes or error responses
        // print('Login failed: ${response.statusCode}');
        // print('Error message: ${response.data}');
        // You might want to show an error message to the user
      }
    } catch (error) {
      // Handle network errors or exceptions
      print('Error: $error');
      // You might want to show an error message to the user
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

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SvgPicture.asset(
          "assets/svg/login.svg",
          width: 647,
          height: 602,
        ),
      ),
    );
  }
}
