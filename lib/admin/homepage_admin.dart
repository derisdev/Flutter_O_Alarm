import 'package:flutter/material.dart';
import 'package:oalarm/admin/tab_admin/akun_admin.dart';
import 'package:oalarm/admin/tab_admin/list_pasien.dart';
import 'package:oalarm/tab/data_diri_pasien.dart';
import 'package:oalarm/tab/jadwal_minum.dart';
import 'package:oalarm/tab/jadwal_obat.dart';


class HomePageAdmin extends StatefulWidget {
  @override
  HomePageAdminState createState() => HomePageAdminState();
}

class HomePageAdminState extends State<HomePageAdmin> {

  final pages = [
    ListPasien(),
    AkunAdmin(),
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
              title: Text('Daftar Pasien')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              title: Text('Akun')
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