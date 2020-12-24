import 'package:flutter/material.dart';
import 'package:oalarm/admin/tab_detail_list_pasien/admin_data_diri_pasien.dart';
import 'package:oalarm/admin/tab_detail_list_pasien/admin_jadwal_minum.dart';
import 'package:oalarm/admin/tab_detail_list_pasien/admin_jadwal_obat.dart';


class DetailListPasien extends StatefulWidget {
  final String norekammedik;
  final int idDataPasien;
  final int index;
  DetailListPasien(this.norekammedik, this.idDataPasien, {this.index});
  @override
  DetailListPasienState createState() => DetailListPasienState();
}

class DetailListPasienState extends State<DetailListPasien> {

  Widget getPage(int index) {

    if (index == 0) {
      return AdminDataDiriPasien(widget.norekammedik, widget.idDataPasien);
    }
    if (index == 1) {
      return AdminJadwalObat(widget.idDataPasien, widget.norekammedik);
    }
    if(index==2){
      return  AdminJadwalMinum(widget.idDataPasien, widget.norekammedik);
    }
    // A fallback, in this case just PageOne
    return AdminDataDiriPasien(widget.norekammedik, widget.idDataPasien);
  }


  int selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      selectedIndex = widget.index!=null? widget.index : 0;
    });
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: getPage(selectedIndex),
    );
  }
}
