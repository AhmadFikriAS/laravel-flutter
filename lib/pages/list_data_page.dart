import 'dart:convert';

import 'package:crud_user_flutter/pages/add_data_page.dart';
import 'package:crud_user_flutter/pages/sign_in_page.dart';
import 'package:crud_user_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListDataPage extends StatefulWidget {
  @override
  State<ListDataPage> createState() => _ListDataPageState();
}

class _ListDataPageState extends State<ListDataPage> {
  late List data;

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse('http://192.168.57.1:8000/api/persons'));
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        backgroundColor: blackColor,
        centerTitle: true,
        title: Text(
          'Data User',
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      );
    }

    Widget data() {
      return FutureBuilder(
        future: getData(),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, index) => Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        title: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            snapshot.data![index]['name'].toString(),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(),
      body: data(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDataPage(
                title: '',
              ),
            ),
          );
        },
      ),
    );
  }
}
