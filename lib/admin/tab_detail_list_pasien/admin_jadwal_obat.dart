import 'package:flutter/material.dart';

class AdminJadwalObat extends StatefulWidget {
  @override
  _AdminJadwalObatState createState() => _AdminJadwalObatState();
}

class _AdminJadwalObatState extends State<AdminJadwalObat> {

  List<List<dynamic>> data = [];


  List<String> split = [];

  bool isLoading = false;

  List<double> skor = [0, 0, 0, 0, 0];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData(){
    List<dynamic> row = List();
    row.add('1');
    row.add('29-02-2020');
    row.add('29-02-2020');
    row.add('Tidak ada keluhan');
    data.add(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Berobat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
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
