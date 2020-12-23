import 'package:flutter/material.dart';

import '../detail_jadwal_minum.dart';

class JadwalMinum extends StatefulWidget {
  @override
  _JadwalMinumState createState() => _JadwalMinumState();
}

class _JadwalMinumState extends State<JadwalMinum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Minum Obat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailJadwalMinum()));
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
