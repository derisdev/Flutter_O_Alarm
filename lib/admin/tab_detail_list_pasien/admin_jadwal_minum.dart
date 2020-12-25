import 'package:flutter/material.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tambah_jadwal_minum.dart';
import 'package:oalarm/admin/update_jadwal_minum.dart';
import 'package:oalarm/service/fetchJadwalMinum.dart';

import '../detail_admin_jadwal_minum.dart';


class AdminJadwalMinum extends StatefulWidget {
  final int idDataPasien;
  final String norekamMedik;
  AdminJadwalMinum(this.idDataPasien, this.norekamMedik);
  @override
  _AdminJadwalMinumState createState() => _AdminJadwalMinumState();
}

enum MENU {UBAH, HAPUS }

class _AdminJadwalMinumState extends State<AdminJadwalMinum> {

  List listJadwalMinum = [];

  bool isLoading = false;

  @override
  void initState() {
    getListJadwalMinum();
    super.initState();
  }

  getListJadwalMinum(){

    setState(() {
      isLoading = true;
    });
    FetchJadwalMinum fetchData = FetchJadwalMinum();
    fetchData.showJadwalMinum(widget.idDataPasien)
        .then((value) {
      if (value!=false) {
        setState(() {
          listJadwalMinum = value;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  deleteJadwalMinum(int idJadwalMinum){

    setState(() {
      isLoading = true;
    });
    FetchJadwalMinum fetchData = FetchJadwalMinum();
    fetchData.deletejadwalMinum(idJadwalMinum)
        .then((value) {
      if (value!=false) {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailListPasien(widget.norekamMedik, widget.idDataPasien, index: 2,)));
        setState(() {
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalMinum(isfromTambahPasien: false, idDataPasien: widget.idDataPasien, noRekamMedik: widget.norekamMedik,)));
        },
        child: Icon(Icons.add),
      ),
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: listJadwalMinum.length,
          itemBuilder: (context, index){
            return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailAdminJadwalMinum(listJadwalMinum[index]['jadwalminum'])));
                },
                onLongPress: (){
                  confirm(context, listJadwalMinum[index]);
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


  Future<Null> confirm(BuildContext context, dynamic jadwalMinum) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, MENU.UBAH);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    title:
                    Text('UBAH', textAlign: TextAlign.center),
                  )),
              Divider(
                color: Colors.grey,
              ),
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, MENU.HAPUS);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    title:
                    Text('HAPUS', textAlign: TextAlign.center),
                  )),

            ],
          );
        })) {
      case MENU.UBAH:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJadwalMinum(dataJadwalMinum: jadwalMinum, idDataPasien: widget.idDataPasien, noRekamMedik: widget.norekamMedik,)));
        break;
      case MENU.HAPUS:
        deleteJadwalMinum(jadwalMinum['id']);
        break;
    }
  }
}
