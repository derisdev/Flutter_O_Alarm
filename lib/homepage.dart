import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/tab/data_diri_pasien.dart';
import 'package:oalarm/tab/jadwal_minum.dart';
import 'package:oalarm/tab/jadwal_obat.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  DateTime currentBackPressTime;



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
              icon: Icon(Icons.timelapse_rounded, size: 20,),
              title: Text('Alarm', style: TextStyle(fontSize: 13))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_rounded,size: 20,),
              title: Text('Jadwal Obat', style: TextStyle(fontSize: 13))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded,size: 20,),
              title: Text('Data Pasien', style: TextStyle(fontSize: 13))
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xff10c8ff),
        onTap: onTap,
      ),
      // membuat objek dari kelas TabBarView
      body: WillPopScope(child: pages.elementAt(selectedIndex), onWillPop: onWillPop),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
