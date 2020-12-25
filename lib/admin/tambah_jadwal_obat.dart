import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tambah_jadwal_minum.dart';
import 'package:oalarm/service/fetchJadwalObat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahJadwalObat extends StatefulWidget {
  final bool isfromTambahPasien;
  final Map dataPasien;
  final int idDataPasien;
  final String norekammedik;
  TambahJadwalObat({this.isfromTambahPasien, this.dataPasien, this.idDataPasien, this.norekammedik});
  @override
  _TambahJadwalObatState createState() => _TambahJadwalObatState();
}

class _TambahJadwalObatState extends State<TambahJadwalObat> {

  final _formKey = GlobalKey<FormState>();


  final TextEditingController tanggalAmbilController = TextEditingController();
  final TextEditingController tanggalKembaliController = TextEditingController();
  final TextEditingController keluhanController = TextEditingController();

  bool isLoading = false;


  addJadwalObat (Map dataJadwalObat) async {



    setState(() {
      isLoading = true;
    });
    FetchJadwalObat fetchData = FetchJadwalObat();
    fetchData.storeJadwalObat(dataJadwalObat)
        .then((value) {
      if (value!=false) {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailListPasien(widget.norekammedik, widget.idDataPasien, index: 1,)));
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
  void dispose() {
    tanggalAmbilController.dispose();
    tanggalKembaliController.dispose();
    keluhanController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: height / 15.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  child: Text(
                    'Tambah Jadwal Berobat',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new Flexible(
                  child: TextField(
                    readOnly: true,
                    onTap: (){
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1920, 3, 5),
                          maxTime: DateTime.now(),
                          theme: DatePickerTheme(
                              headerColor: Colors.white,
                              backgroundColor: Colors.white,
                              itemStyle: TextStyle(
                                  color: Color(0xff8b2f08), fontWeight: FontWeight.bold, fontSize: 18),
                              doneStyle: TextStyle(color: Color(0xff8b2f08), fontSize: 16)),
                          onChanged: (date) {

                          }, onConfirm: (date) {
                            setState(() {
                              tanggalAmbilController.text = date.toString().split(' ').first;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff8b2f08)),
                    controller: tanggalAmbilController,
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xff8b2f08),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Tanggal Ambil',
                        labelStyle: TextStyle(
                            fontSize: 13, color: Color(0xff8b2f08)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff8b2f08)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff8b2f08)))),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new Flexible(
                  child: TextField(
                    readOnly: true,
                    onTap: (){
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1920, 3, 5),
                          maxTime: DateTime.now(),
                          theme: DatePickerTheme(
                              headerColor: Colors.white,
                              backgroundColor: Colors.white,
                              itemStyle: TextStyle(
                                  color: Color(0xff8b2f08), fontWeight: FontWeight.bold, fontSize: 18),
                              doneStyle: TextStyle(color: Color(0xff8b2f08), fontSize: 16)),
                          onChanged: (date) {

                          }, onConfirm: (date) {
                            setState(() {
                              tanggalKembaliController.text = date.toString().split(' ').first;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff8b2f08)),
                    controller: tanggalKembaliController,
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xff8b2f08),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        labelText: 'Tanggal Kembali',
                        labelStyle: TextStyle(
                            fontSize: 13, color: Color(0xff8b2f08)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff8b2f08)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff8b2f08)))),
                  ),
                ),
              ),
              Container(
                height: height / 3.00,
                child: SingleChildScrollView(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, height: height / 394.6),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: keluhanController,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'Silahkan isi keluhan';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Keluhan',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).accentColor))),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                    focusColor: Colors.white,
                    splashColor: Colors.white,
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: isLoading? SpinKitThreeBounce(
                      size: 30,
                      color: Colors.yellow,
                    ) : Text(
                      widget.isfromTambahPasien? 'Selanjutnya' : 'Simpan',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {

                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        Map dataJadwalObat = {
                          'tanggalambil': tanggalAmbilController.text,
                          'tanggalkembali': tanggalKembaliController.text,
                          'keluhan': keluhanController.text,
                        };

                        widget.isfromTambahPasien?
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalMinum(isfromTambahPasien: true, dataPasien: widget.dataPasien, dataJadwalObat: dataJadwalObat)))
                      :
                        addJadwalObat(dataJadwalObat);
                        // widget.mySong == null? _saveData() : _updateData();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
