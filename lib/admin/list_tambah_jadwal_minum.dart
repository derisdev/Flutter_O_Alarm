
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oalarm/admin/detail_admin_jadwal_minum.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tab_admin/list_pasien.dart';
import 'package:oalarm/admin/tambah_jadwal_minum.dart';
import 'package:oalarm/admin/update_jadwal_minum.dart';
import 'package:oalarm/service/fetchJadwalMinum.dart';
import 'package:oalarm/service/fetchJadwalObat.dart';
import 'package:oalarm/service/fetchdataPasien.dart';



class ListTambahJadwalMinum extends StatefulWidget {
  final Map dataPasien;
  final Map dataJadwalObat;
  ListTambahJadwalMinum({this.dataPasien, this.dataJadwalObat});
  @override
  _ListTambahJadwalMinumState createState() => _ListTambahJadwalMinumState();
}

enum MENU {UBAH, HAPUS }

class _ListTambahJadwalMinumState extends State<ListTambahJadwalMinum> {

  List listJadwalMinum = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  getListJadwalMinum(var listJadwalMinum){

    setState(() {
      this.listJadwalMinum.add(listJadwalMinum);
    });

  }


  deleteJadwalMinum(int index){

    setState(() {
      listJadwalMinum.removeAt(index);
    });
  }


  addPasien () async {

    setState(() {
      isLoading = true;
    });

    FetchDataPasien fetchDataPasien = FetchDataPasien();
    Map newDataPasien = widget.dataPasien;
    newDataPasien['terapi'] = this.listJadwalMinum[0]['terapi'];
    newDataPasien['dosis'] = this.listJadwalMinum[0]['dosis'];
        fetchDataPasien.storeDataPasien(widget.dataPasien).then((value){
      if(value!=false){
        int newIdDataPasien = value['id'];
        Map newDataJadwalObat = widget.dataJadwalObat;
        newDataJadwalObat['data_pasien_id'] = newIdDataPasien.toString();
        FetchJadwalObat fetchJadwalObat = FetchJadwalObat();
        fetchJadwalObat.storeJadwalObat(widget.dataJadwalObat).then((value) async {
          if(value!=false){
            for(int i=0;i<this.listJadwalMinum.length;i++){
              print(this.listJadwalMinum.length);
              this.listJadwalMinum[i]['data_pasien_id'] = newIdDataPasien.toString();

              FetchJadwalMinum fetchData = FetchJadwalMinum();
              await fetchData.storeJadwalMinum(this.listJadwalMinum[i]['terapi'], this.listJadwalMinum[i]['dosis'], this.listJadwalMinum[i]['jadwalminum'], this.listJadwalMinum[i]['data_pasien_id'])
                  .then((value) {

              });
            }
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListPasien()));
              setState(() {
                isLoading = false;
              });
          }
          else {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    });


  }



  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            color:  listJadwalMinum.isEmpty? Colors.lightBlueAccent.withOpacity(0.5) : Colors.lightBlueAccent,
            onPressed: isLoading? (){} : () async{
              if (listJadwalMinum.isNotEmpty) {
                addPasien();
              }
            },
            child: isLoading? SpinKitThreeBounce(
              color: Colors.white,
              size: 30.0,
            ) : Text(
              'Buat Data Pasien',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalMinum(isfromTambahPasien: true))).then((value){
              if(value!=null){
                getListJadwalMinum(value);
              }
            });
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
              MediaQuery.of(context).size.height - 120 - statusbarHeight,
              child: listJadwalMinum.isEmpty? Center(
                child: Text('Jadwal Minum Belum ditambahkan', style: TextStyle(color: Colors.white),),
              ) : ListView.builder(
                  itemCount: listJadwalMinum.length,
                  itemBuilder: (context, index){
                    return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailAdminJadwalMinum(listJadwalMinum[index])));
                        },
                        onLongPress: (){
                          confirm(context, listJadwalMinum[index], index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
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
                        )
                    );
                  }),
            ),
          ],
        )
    );
  }

  Future<Null> confirm(BuildContext context, dynamic jadwalMinum, int index) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              // SimpleDialogOption(
              //     onPressed: () {
              //       Navigator.pop(context, MENU.UBAH);
              //     },
              //     child: ListTile(
              //       leading: Icon(
              //         Icons.edit,
              //         color: Colors.blue,
              //       ),
              //       title:
              //       Text('UBAH', textAlign: TextAlign.center),
              //     )),
              // Divider(
              //   color: Colors.grey,
              // ),
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
      // case MENU.UBAH:
      //   // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJadwalMinum(dataJadwalMinum: jadwalMinum, idDataPasien: widget.idDataPasien, noRekamMedik: widget.norekamMedik,)));
      //   break;
      case MENU.HAPUS:
        deleteJadwalMinum(index);
        break;
    }
  }
}
