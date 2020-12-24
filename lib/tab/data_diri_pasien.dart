import 'package:flutter/material.dart';
import 'package:oalarm/lanjut_sebagai.dart';
import 'package:oalarm/service/fetchdataPasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataDiriPasien extends StatefulWidget {
  @override
  _DataDiriPasienState createState() => _DataDiriPasienState();
}

class _DataDiriPasienState extends State<DataDiriPasien> {

  String nama;
  String ttl;
  String alamat;
  String umur;
  String kodeDiagnosa;
  String kodeDx;
  String terapi;
  String dosis;
  String pmo;



  bool isLoading = true;
  @override
  void initState() {
    getPasien();
    super.initState();
  }


  getPasien () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String noRekamMedik = prefs.getString('norekammedik');

    setState(() {
      isLoading = true;
    });
    FetchDataPasien fetchData = FetchDataPasien();
    fetchData.showDataPasien(noRekamMedik)
        .then((value) {
      if (value!=false) {
        setState(() {
          nama = value['nama'];
          ttl = value['tanggallahir'];
          umur = value['umur'];
          alamat = value['alamat'];
          kodeDiagnosa = value['kodediagnosa'];
          kodeDx = value['kodedx'];
          terapi = value['terapi'];
          dosis = value['dosis'];
          pmo = value['pmo'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Diri Pasien'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LanjutSebagai()));
              },
              child: Text('Logout', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Nama'),
                subtitle: Text(nama),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('TTL/Umur'),
                subtitle: Text(ttl+'/'+umur),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Alamat'),
                subtitle: Text(alamat),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Kode diagnosa (ICD X)'),
                subtitle: Text(kodeDiagnosa),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Kode Dx. Kep 00118'),
                subtitle: Text(kodeDx),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Terapi'),
                subtitle: Text(terapi),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Dosis'),
                subtitle: Text(dosis),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('PMO'),
                subtitle: Text(pmo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
