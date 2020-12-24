import 'package:flutter/material.dart';
import 'package:oalarm/service/fetchJadwalMinum.dart';
import 'package:oalarm/service/fetchdataPasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../detail_jadwal_minum.dart';

class JadwalMinum extends StatefulWidget {
  @override
  _JadwalMinumState createState() => _JadwalMinumState();
}

class _JadwalMinumState extends State<JadwalMinum> {


  List listJadwalMinum = [];
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
          listJadwalMinum = value['jadwal_minums'];
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
        title: Text('Jadwal Minum Obat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: listJadwalMinum.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailJadwalMinum(listJadwalMinum[index]['jadwalminum'])));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(listJadwalMinum[index]['terapi']),
                      subtitle: Text(listJadwalMinum[index]['dosis']),
                      trailing: Icon(Icons.chevron_right),
                    )
                ),
              )
            );
          }),
    );
  }
}
