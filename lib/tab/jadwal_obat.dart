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
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Berobat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 20,),
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
                        1: FixedColumnWidth(95.0),
                        2: FixedColumnWidth(95.0),
                        3: FixedColumnWidth(100.0),
                      },
                      border: TableBorder.all(width: 1.0),
                      children: [
                        TableRow(children: <Widget>[
                          Container(
                            color: Colors.blue,
                            height: 51,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Tanggal Ambil',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Tanggal Kembali',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: 51,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Keluhan',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ])
                      ]),
                  Container(
                    height: 400,
                    child: SingleChildScrollView(
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(40.0),
                          1: FixedColumnWidth(95.0),
                          2: FixedColumnWidth(95.0),
                          3: FixedColumnWidth(100.0),
                        },
                        border: TableBorder.all(width: 1.0),
                        children: data.map((item) {
                          return TableRow(
                              children: item.map((row) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      row.toString(),
                                      style: TextStyle(fontSize: 15.0),
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
    );
  }
}
