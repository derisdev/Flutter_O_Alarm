import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FetchJadwalMinum {


  Future storeJadwalMinum(String terapi, String dosis, String jadwalminum, String dataPasienId) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalminum";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'terapi': terapi,
          'dosis': dosis,
          'jadwalminum': jadwalminum,
          'data_pasien_id': dataPasienId,
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
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


  Future updateJadwalMinum(int id, String terapi, String dosis, String jadwalminum, String dataPasienId) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalminum/$id";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'terapi': terapi,
          'dosis': dosis,
          'jadwalminum': jadwalminum,
          'data_pasien_id': dataPasienId,
          '_method' : 'PATCH'
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

  Future getAllJadwalMinum() async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalminum";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['jadwalminums'];
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


  Future showJadwalMinum(int idDataPasien) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalminum/$idDataPasien";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['jadwalminum'];
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


  Future deletejadwalMinum(int idJadwalMinum) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalminum/$idJadwalMinum";
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
