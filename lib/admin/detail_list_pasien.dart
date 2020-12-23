import 'package:flutter/material.dart';
import 'package:oalarm/admin/tab_detail_list_pasien/admin_data_diri_pasien.dart';
import 'package:oalarm/admin/tab_detail_list_pasien/admin_jadwal_minum.dart';
import 'package:oalarm/admin/tab_detail_list_pasien/admin_jadwal_obat.dart';


class DetailListPasien extends StatefulWidget {
  @override
  DetailListPasienState createState() => DetailListPasienState();
}

class DetailListPasienState extends State<DetailListPasien> {

  final pages = [
    AdminDataDiriPasien(),
    AdminJadwalObat(),
    AdminJadwalMinum(),
  ];

  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // membuat objek dari kelas BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              title: Text('Data Pasien')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_rounded),
              title: Text('Jadwal Obat')
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_rounded),
              title: Text('Alarm')
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        onTap: onTap,
      ),
      // membuat objek dari kelas TabBarView
      body: pages.elementAt(selectedIndex),
    );
  }
}
