import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/list_tambah_jadwal_minum.dart';
import 'package:oalarm/service/fetchJadwalObat.dart';

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

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData(){
    var currentTime = DateTime.now();
    tanggalKembaliController.text = currentTime.toString().split(' ').first;
    tanggalAmbilController.text = currentTime.toString().split(' ').first;
  }


  addJadwalObat (Map dataJadwalObat) async {

    dataJadwalObat['data_pasien_id'] = widget.idDataPasien.toString();

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
            color: keluhanController.text.isNotEmpty? Colors.lightBlueAccent: Colors.lightBlueAccent.withOpacity(0.5),
            onPressed: isLoading? (){} : () async{
              if (keluhanController.text.isNotEmpty) {

                Map dataJadwalObat = {
                  'tanggalambil': tanggalAmbilController.text,
                  'tanggalkembali': tanggalKembaliController.text,
                  'keluhan': keluhanController.text,
                };

                widget.isfromTambahPasien?
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListTambahJadwalMinum(dataPasien: widget.dataPasien, dataJadwalObat: dataJadwalObat,)))
                    :
                addJadwalObat(dataJadwalObat);
                // widget.mySong == null? _saveData() : _updateData();
              }
            },
            child: isLoading? SpinKitThreeBounce(
              color: Colors.white,
              size: 30.0,
            ) : Text(widget.isfromTambahPasien?
                'Selanjutnya'
                :
              'SIMPAN',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: statusbarHeight),
                height: statusbarHeight + 50,
                child: Center(
                  child: Text(
                    'Tambah jadwal Obat',
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 106 - statusbarHeight,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 50,
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
                                        color: Color(0xffb0aed9), fontWeight: FontWeight.bold, fontSize: 13),
                                    doneStyle: TextStyle(color: Color(0xffb0aed9), fontSize: 13)),
                                onChanged: (date) {

                                }, onConfirm: (date) {
                                  setState(() {
                                    tanggalAmbilController.text = date.toString().split(' ').first;
                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.id);
                          },
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          controller: tanggalAmbilController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit,
                                  color: Colors.white, size: 13),
                              contentPadding: EdgeInsets.all(5),
                              labelText: 'Tanggal Ambil',
                              labelStyle: TextStyle(
                                  fontSize: 13, color: Color(0xffb0aed9)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffb0aed9)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffb0aed9)))),
                        ),
                      ),
                      Container(
                        height: 50,
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
                                        color: Color(0xffb0aed9), fontWeight: FontWeight.bold, fontSize: 13),
                                    doneStyle: TextStyle(color: Color(0xffb0aed9), fontSize: 13)),
                                onChanged: (date) {

                                }, onConfirm: (date) {
                                  setState(() {
                                    tanggalKembaliController.text = date.toString().split(' ').first;
                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.id);
                          },
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          controller: tanggalKembaliController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit,
                                  color: Colors.white, size: 13),
                              contentPadding: EdgeInsets.all(5),
                              labelText: 'Tanggal Kembali',
                              labelStyle: TextStyle(
                                  fontSize: 13, color: Color(0xffb0aed9)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffb0aed9)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffb0aed9)))),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        controller: keluhanController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value){
                          if (value.isEmpty) {
                            return 'Silahkan isi keluhan';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Keluhan',
                            labelStyle: TextStyle(color: Color(0xffb0aed9)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffb0aed9),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).accentColor))),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
