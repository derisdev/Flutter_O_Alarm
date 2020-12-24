import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchDataPasien {


  Future storeDataPasien(String norekammedik, String nama, String tanggallahir, String umur, String alamat, String kodediagnosa, String kodedx, String terapi, String dosis, String pmo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/datapasien";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'norekammedik': norekammedik,
          'nama': nama,
          'tanggallahir': tanggallahir,
          'alamat': alamat,
          'umur': umur,
          'kodediagnosa': kodediagnosa,
          'kodedx': kodedx,
          'terapi': terapi,
          'dosis': dosis,
          'pmo': pmo

    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      int datapasienid = jsonData['datapasien']['id'];
      String norekammedik = jsonData['datapasien']['norekammedik'];

      prefs.setInt('datapasienid', datapasienid);
      prefs.setString('norekammedik', norekammedik);

      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }

  Future updateDataPasien(int idDataPasien, String norekammedik, String nama, String tanggallahir, String umur, String alamat, String kodediagnosa, String kodedx, String terapi, String dosis, String pmo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/datapasien/$idDataPasien";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'norekammedik': norekammedik,
          'nama': nama,
          'tanggallahir': tanggallahir,
          'alamat': alamat,
          'umur': umur,
          'kodediagnosa': kodediagnosa,
          'kodedx': kodedx,
          'terapi': terapi,
          'dosis': dosis,
          'pmo': pmo,
          '_method' : 'PATCH'

        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      int datapasienid = jsonData['datapasien']['id'];
      // String nama = jsonData['datapasien']['nama'];
      String norekammedik = jsonData['datapasien']['norekammedik'];
      // String tanggallahir = jsonData['datapasien']['tanggallahir'];
      // String alamat = jsonData['datapasien']['alamat'];
      // String kodediagnosa = jsonData['datapasien']['kodediagnosa'];
      // String terapi = jsonData['datapasien']['terapi'];
      // String dosis = jsonData['datapasien']['dosis'];
      // String pmo = jsonData['datapasien']['pmo'];
      //
      prefs.setInt('datapasienid', datapasienid);
      prefs.setString('norekammedik', norekammedik);
      // prefs.setString('nama', nama);
      // prefs.setString('tanggallahir', tanggallahir);
      // prefs.setString('alamat', alamat);
      // prefs.setString('kodediagnosa', kodediagnosa);
      // prefs.setString('terapi', terapi);
      // prefs.setString('dosis', dosis);
      // prefs.setString('pmo', pmo);


      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future getAllDataPasien() async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/datapasien";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['datapasiens'];
    }

    else if (response.statusCode == 404) {
      showToast('Nama atau password salah');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future showDataPasien(String norekammedik) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/datapasien/$norekammedik";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['datapasien'];
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future deleteDataPasien(String idDataPasien) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/datapasien/$idDataPasien";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
    body: {
      '_method' : 'DELETE'
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
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
