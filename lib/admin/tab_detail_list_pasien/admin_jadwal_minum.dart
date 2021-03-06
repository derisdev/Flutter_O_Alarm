import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  showToast(String text) {
    Fluttertoast.showToast(
        msg:
        text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }




  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color(0xff3e3a63),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalMinum(isfromTambahPasien: false, idDataPasien: widget.idDataPasien, noRekamMedik: widget.norekamMedik,)));
        },
        child: Container(
        width: 60,
        height: 60,
        child: Icon(
          Icons.add,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
      ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: statusbarHeight),
            height: statusbarHeight + 50,
            child: Center(
              child: Text(
                'Jadwal Minum Obat',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Container(
            height:
          MediaQuery.of(context).size.height - 106 - statusbarHeight,
            child: isLoading? Center(
              child: CircularProgressIndicator(),
            ) : listJadwalMinum.isEmpty? Center(
              child: Text('Data Kosong', style: TextStyle(color: Colors.white),),
            ) : ListView.builder(
                itemCount: listJadwalMinum.length,
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailAdminJadwalMinum(listJadwalMinum[index])));
                      },
                      child: Dismissible(
                        key: Key('item ${listJadwalMinum[index]}'),
                        confirmDismiss: (direction){
                          if(direction ==  DismissDirection.startToEnd){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJadwalMinum(dataJadwalMinum: listJadwalMinum[index], idDataPasien: widget.idDataPasien, noRekamMedik: widget.norekamMedik,)));
                          }
                          else {
                            confirm(context, listJadwalMinum[index]);
                          }
                          return Future.value(false);
                        },
                        background: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ListTile(
                                leading: Icon(Icons.edit, color: Colors.lightBlueAccent),
                              )
                          ),
                        ),
                        secondaryBackground: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ListTile(
                                trailing: Icon(Icons.delete_forever, color: Colors.lightBlueAccent),
                              )
                          ),
                        ),
                        child: Card(
                            color: Color(0xff434372),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              leading: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 30,
                                  minHeight: 30,
                                  maxWidth: 30,
                                  maxHeight: 30,
                                ),
                                child:Image.asset('assets/images/capsules.png', fit: BoxFit.contain,),
                              ),
                              title: Text(listJadwalMinum[index]['terapi'], style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),),
                              subtitle: Text(listJadwalMinum[index]['dosis'],  style: TextStyle(
                                  color: Color(0xffadaad6)),),
                              trailing: Icon(Icons.chevron_right, color: Color(0xffadaad6)),
                            )
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      )
    );
  }


  Future<Null> confirm(BuildContext context, dynamic jadwalMinum) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konformasi Hapus"),
            content: const Text("Yakin ingin menghapus?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    deleteJadwalMinum(jadwalMinum['id']);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Hapus")
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Batal"),
              ),
            ],
          );
        })) {
    }
  }

}
