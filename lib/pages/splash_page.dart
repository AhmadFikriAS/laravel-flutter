import 'package:crud_user_flutter/pages/sign_in_page.dart';
import 'package:crud_user_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:crud_user_flutter/theme.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset('assets/splashicon.json'),
            ),
            Text(
              'Flutter CRUD',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
