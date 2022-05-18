import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = 'http://192.168.57.1:8000/api';
  String serverUrlpersons = 'http://192.168.57.1:8000/api/persons';

  var status;

  var token;

  //NOTE for login
  loginData(String email, String password) async {
    String myUrl = '$serverUrl/login';
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
      body: {'email': '$email', 'password': '$password'},
    );

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data['error']}');
    } else {
      print('data : ${data['token']}');
      _save(data['token']);
    }
  }

  //NOTE for register

  void addDataPersons(String _nameController, String _addressController,
      String _ageController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = 'http://192.168.57.1:8000/api/persons';
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
      body: {
        'name': '$_nameController',
        'address': '$_addressController',
        'age': '$_ageController',
      },
    );

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data['error']}');
    } else {
      print('data : ${data['token']}');
      _save(data['token'] ?? '');
    }
  }

  //NOTE for edit data
  void editData(String id, String name, String address, String age) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = 'http://192.168.57.1:8000/api/persons/$id';
    http.put(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      'name': '$name',
      'address': '$address',
      'age': '$age',
    }).then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    });
  }

  //NOTE for delete data
  void deleteData(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = 'http://192.168.57.1:8000/api/persons/$id';
    http.delete(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    });
  }

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = '$serverUrlpersons';
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key) ?? 0;
    print('read : $value');
  }
}
