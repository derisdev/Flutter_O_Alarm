import 'package:flutter/material.dart';
import 'package:oalarm/admin/tambah_jadwal_minum.dart';

import '../detail_admin_jadwal_minum.dart';


class AdminJadwalMinum extends StatefulWidget {
  final int idDataPasien;
  final String norekamMedik;
  AdminJadwalMinum(this.idDataPasien, this.norekamMedik);
  @override
  _AdminJadwalMinumState createState() => _AdminJadwalMinumState();
}

class _AdminJadwalMinumState extends State<AdminJadwalMinum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Minum Obat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalMinum()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index){
            return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailAdminJadwalMinum()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text('Paracetamol 5 mg'),
                        subtitle: Text('2x1/2'),
                        trailing: Icon(Icons.chevron_right),
                      )
                  ),
                )
            );
          }),
    );
  }
}
