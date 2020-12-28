import 'package:flutter/material.dart';
import 'package:oalarm/service/fetchdataPasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JadwalObat extends StatefulWidget {
  @override
  _JadwalObatState createState() => _JadwalObatState();
}

class _JadwalObatState extends State<JadwalObat> {

  List<List<dynamic>> data = [];

  bool isLoading = false;

  int index=0;

  @override
  void initState() {
    getPasien();
    super.initState();
  }



  getPasien () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String noRekamMedik = prefs.getString('norekammedik');

    setState(() {
      isLoading = true;
    });
    FetchDataPasien fetchData = FetchDataPasien();
    fetchData.showDataPasien(noRekamMedik)
        .then((value) {
      if (value!=false) {

        List jadwalObat = value['jadwal_obats'];

        for(int index=0; index<jadwalObat.length; index++){
          List<dynamic> row = List();
          row.add('${index+1}');
          row.add(jadwalObat[index]['tanggalambil']);
          row.add(jadwalObat[index]['tanggalkembali']);
          row.add(jadwalObat[index]['keluhan']);
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
            ) : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 10,),
                  isLoading
                      ? Container(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: Center(child: CircularProgressIndicator()))
                      : data.isEmpty
                      ? Spacer()
                      : Column(
                    children: <Widget>[
                      Table(
                          columnWidths: {
                            0: FixedColumnWidth(40.0),
                            1: FixedColumnWidth(110.0),
                            2: FixedColumnWidth(110.0),
                            3: FixedColumnWidth(100.0),
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
                            ])
                          ]),
                      Container(
                        height: MediaQuery.of(context).size.height-106-statusbarHeight-72,
                        child: SingleChildScrollView(
                          child: Table(
                            columnWidths: {
                              0: FixedColumnWidth(40.0),
                              1: FixedColumnWidth(110.0),
                              2: FixedColumnWidth(110.0),
                              3: FixedColumnWidth(100.0),
                            },
                            border: TableBorder(bottom: BorderSide(color: Color(0xff434372), width: 1)),
                            children: data.map((item) {
                              index +=1;
                              return TableRow(
                                  children: item.map((row) {
                                    return Container(
                                      color: Color(0xff3e3a63),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          row.toString(),
                                          style: TextStyle(fontSize: 13.0,color: Colors.white),
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
        ],
      )
    );
  }
}
