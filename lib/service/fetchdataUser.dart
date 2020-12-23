import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchDataUser {

  Future userRegister(String nama, String noHp, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://api.fillocoffee.web.id/api/v1/user/register";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {'nama': nama, 'nomorponsel': noHp, 'password': password});

    print(response.statusCode);
    print(response.body);


    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      int userId = jsonData['user']['id'];
      String username = jsonData['user']['nama'];
      String nohp = jsonData['user']['nomorponsel'];
      String token = jsonData['token'];

      prefs.setInt('user_id', userId);
      prefs.setString('username', username);
      prefs.setString('nohp', nohp);
      prefs.setString('password', password);
      prefs.setString('token', token);
      prefs.setBool('is_login', true);


      return true;
    }

    else if (response.statusCode == 500) {
      showToast('User sudah terdaftar');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future userLogin(String noHp, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://api.fillocoffee.web.id/api/v1/user/signin";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {'nomorponsel': noHp, 'password': password});


    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      int userId = jsonData['user']['id'];
      String username = jsonData['user']['nama'];
      String gambar = jsonData['user']['gambar'];
      String tanggallahir = jsonData['user']['tanggallahir'];
      String jeniskelamin = jsonData['user']['jeniskelamin'];
      String noHp = jsonData['user']['nomorponsel'];
      String token = jsonData['token'];

      prefs.setInt('user_id', userId);
      prefs.setString('username', username);
      prefs.setString('gambar', gambar);
      prefs.setString('tanggallahir', tanggallahir);
      prefs.setString('jeniskelamin', jeniskelamin);
      prefs.setString('nohp', noHp);
      prefs.setString('password', password);
      prefs.setString('token', token);
      prefs.setBool('is_login', true);


      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Nomor ponsel atau password salah');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future updateProfile(String username, String email, String tanggallahir, String jenisKelamin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('user_id');
    String token = prefs.getString('token');

    String baseUrl =
        "http://api.fillocoffee.web.id/api/v1/user/profile?token=$token";

    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'nama': username,
          'email': email,
          'tanggallahir': tanggallahir,
          'jeniskelamin': jenisKelamin,
          'user_id': userId.toString()
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      String username = jsonData['user']['nama'];
      String tanggallahir = jsonData['user']['tanggallahir'];
      String jeniskelamin = jsonData['user']['jeniskelamin'];
      String email = jsonData['user']['email'];

      prefs.setString('username', username);
      prefs.setString('tanggallahir', tanggallahir);
      prefs.setString('jeniskelamin', jeniskelamin);
      prefs.setString('email', email);

      showToast('profil berhasil di update');
      return true;
    }
    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future updateAvatar(File image) async {

    String fileName = image.path.split('/').last;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');

    String baseUrl =
        "http://api.fillocoffee.web.id/api/v1/user/profile/image?token=$token";


    FormData formData = FormData.fromMap({
      'user_id' : userId.toString(),
      'gambar' : await MultipartFile.fromFile(image.path, filename: fileName)
    });

    Response response = await Dio().post(baseUrl, data: formData,
        options: Options(headers: {
          'Accept' : '*/*',
        }));

    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      var data = response.data;
      var fileName = data['user']['gambar'];
      print(fileName);
      prefs.setString('gambar', fileName.toString());

      return true;
    }
    else{
      showToast('Terjadi kesalahan');
      return false;
    }
  }


}



showToast(String text) {
  Fluttertoast.showToast(
      msg:
      text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}
