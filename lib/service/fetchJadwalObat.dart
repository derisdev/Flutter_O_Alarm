import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FetchJadwalObat {


  Future storeJadwalObat(Map dataJadwalObat) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalobat";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: dataJadwalObat);

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


  Future updateJadwalObat(int id, String tanggalAmbil, String tanggalKembali, String keluhan, String dataPasienId) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalobat/$id";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          'tanggalambil': tanggalAmbil,
          'tanggalkembali': tanggalKembali,
          'keluhan': keluhan,
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

  Future getAllJadwalObat() async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalobat";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['jadwalobats'];
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


  Future showJadwalObat(int idDataPasien) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalobat/$idDataPasien";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['jadwalobat'];
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


  Future deletejadwalObat(int idJadwalObat) async {

    String baseUrl =
        "http://oalarm.fillocoffee.web.id/api/v1/jadwalobat/$idJadwalObat";
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
