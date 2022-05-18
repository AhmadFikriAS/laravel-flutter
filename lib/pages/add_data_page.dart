import 'package:crud_user_flutter/controllers/database_helpers.dart';
import 'package:crud_user_flutter/theme.dart';
import 'package:flutter/material.dart';

class AddDataPage extends StatefulWidget {
  final String title;
  AddDataPage({required this.title});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: blackColor,
        title: Text(
          'Add Data',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 140,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      'assets/person.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: _nameController,
                      cursorColor: blackColor,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Your Name',
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

    Widget addressInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      'assets/address.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: _addressController,
                      cursorColor: blackColor,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Your Address',
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

    Widget ageInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      'assets/age.png',
                      width: 17,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: _ageController,
                      cursorColor: blackColor,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Your Age',
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

    Widget AddDataButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: TextButton(
          onPressed: () {
            databaseHelper.addDataPersons(
              _nameController.text,
              _addressController.text,
              _ageController.text,
            );
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Add Data User',
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
      appBar: header(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              nameInput(),
              addressInput(),
              ageInput(),
              AddDataButton(),
            ],
          ),
        ),
      ),
    );
  }
}
