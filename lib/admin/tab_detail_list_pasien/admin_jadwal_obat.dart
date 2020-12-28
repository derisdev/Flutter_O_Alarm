import 'package:flutter/material.dart';
import 'package:oalarm/admin/tambah_jadwal_obat.dart';
import 'package:oalarm/admin/update_jadwal_obat.dart';
import 'package:oalarm/service/fetchJadwalObat.dart';

class AdminJadwalObat extends StatefulWidget {
  final int idDataPasien;
  final String norekammedik;
  AdminJadwalObat(this.idDataPasien, this.norekammedik);
  @override
  _AdminJadwalObatState createState() => _AdminJadwalObatState();
}

class _AdminJadwalObatState extends State<AdminJadwalObat> {

  List<List<dynamic>> data = [];

  List listJadwalObat = [];

  bool isLoading = false;

  int index = 0;

  @override
  void initState() {
    super.initState();
    getJadwalObat();
  }

  getJadwalObat () async {

    setState(() {
      isLoading = true;
    });
    FetchJadwalObat fetchData = FetchJadwalObat();
    fetchData.showJadwalObat(widget.idDataPasien)
        .then((value) {
      if (value!=false) {
        listJadwalObat = value;
        List jadwalObat = value;

        for(int index=0; index<jadwalObat.length; index++){
          List<dynamic> row = List();
          row.add('${index+1}');
          row.add(jadwalObat[index]['tanggalambil']);
          row.add(jadwalObat[index]['tanggalkembali']);
          row.add(jadwalObat[index]['keluhan']);
          row.add('iconEdit ,'+index.toString());
          row.add(index);
          data.add(row);
        }
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
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalObat(isfromTambahPasien: false, idDataPasien: widget.idDataPasien, norekammedik: widget.norekammedik,)));
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
                child:Text('Jadwal Berobat', style: TextStyle(color: Colors.white, fontSize: 17),),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height-106-statusbarHeight,
              child: isLoading? Center(
                child: CircularProgressIndicator(),
              )  : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 10,),
                          data.isEmpty? Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2-statusbarHeight-50),
                            child: Text('Data Kosong', style: TextStyle(color: Colors.white),),
                          )
                              : Column(
                        children: <Widget>[
                          Table(
                              columnWidths: {
                                0: FixedColumnWidth(40.0),
                                1: FixedColumnWidth(93.0),
                                2: FixedColumnWidth(93.0),
                                3: FixedColumnWidth(93.0),
                                4: FixedColumnWidth(40.0),
                              },
                              border: TableBorder(top: BorderSide(color: Color(0xff434372), width: 1), bottom: BorderSide(color: Color(0xff434372), width: 1)),
                              children: [
                                TableRow(children: <Widget>[
                                  Container(
                                    height: 51,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'No',
                                        style: TextStyle(fontSize: 15.0,  color: Color(0xff9f9cc8)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tanggal Ambil',
                                        style: TextStyle(fontSize: 15.0, color: Color(0xff9f9cc8)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tanggal Kembali',
                                        style: TextStyle(fontSize: 15.0, color: Color(0xff9f9cc8)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 51,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Keluhan',
                                        style: TextStyle(fontSize: 15.0, color: Color(0xff9f9cc8)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 51,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '',
                                        style: TextStyle(fontSize: 15.0, color: Color(0xff9f9cc8)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ])
                              ]),
                          Container(
                            height: MediaQuery.of(context).size.height-106-statusbarHeight-10,
                            child: SingleChildScrollView(
                              child: Table(
                                columnWidths: {
                                  0: FixedColumnWidth(40.0),
                                  1: FixedColumnWidth(93.0),
                                  2: FixedColumnWidth(93.0),
                                  3: FixedColumnWidth(93.0),
                                  4: FixedColumnWidth(40.0),
                                },
                                border: TableBorder(bottom: BorderSide(color: Color(0xff434372), width: 1)),
                                children: data.map((item) {
                                  index +=1;
                                  return TableRow(
                                      children: item.map((row) {
                                        return Container(
                                          color: Color(0xff3e3a63),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: row.toString().contains('iconEdit')?
                                            InkWell(
                                                child: Icon(Icons.edit, size: 15, color: Colors.lightBlueAccent),
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJadwalObat(listJadwalObat: listJadwalObat[int.parse(row.toString().split(',').last)], idDataPasien: widget.idDataPasien, norekammedik: widget.norekammedik,)));
                                                })
                                                : Text(
                                              row.toString(),
                                              style: TextStyle(fontSize: 13.0, color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }).toList());
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
