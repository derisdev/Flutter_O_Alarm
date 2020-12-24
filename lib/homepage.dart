import 'package:flutter/material.dart';
import 'package:oalarm/tab/data_diri_pasien.dart';
import 'package:oalarm/tab/jadwal_minum.dart';
import 'package:oalarm/tab/jadwal_obat.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final pages = [
    JadwalMinum(),
    JadwalObat(),
    DataDiriPasien()
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
              icon: Icon(Icons.timelapse_rounded),
              title: Text('Alarm')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_rounded),
              title: Text('Jadwal Obat')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              title: Text('Data Pasien')
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
