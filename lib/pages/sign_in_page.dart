import 'dart:convert';

import 'package:crud_user_flutter/pages/list_data_page.dart';
import 'package:crud_user_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Sign in to continue',
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/email.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: emailController,
                      cursorColor: blackColor,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Your Email Address',
                        hintStyle: secondaryTextStyle,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/password.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: passwordController,
                      cursorColor: blackColor,
                      obscureText: true,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Your Password',
                        hintStyle: secondaryTextStyle,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    signIn(String email, pass) async {
      String baseUrl = 'http://192.168.57.1:8000/api';
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      Map data = {
        'email': email,
        'password': pass,
      };

      var url = '$baseUrl/login';

      var jsonResponse = null;

      var response = await http.post(
        Uri.parse(url),
        body: data,
      );
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });

          sharedPreferences.setString('token', jsonResponse['token']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => ListDataPage()),
              (Route<dynamic> route) => false);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }

    Widget SignInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            signIn(emailController.text, passwordController.text);
          },
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign In',
            style: primaryTextStyle.copyWith(
              color: whiteColor,
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                emailInput(),
                passwordInput(),
                SignInButton(),
                Spacer(),
              ],
            )),
      ),
    );
  }
}
