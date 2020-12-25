import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tambah_jadwal_minum.dart';
import 'package:oalarm/service/fetchJadwalObat.dart';

class UpdateJadwalObat extends StatefulWidget {
  final dynamic listJadwalObat;
  final int idDataPasien;
  final String norekammedik;
  UpdateJadwalObat({this.listJadwalObat, this.idDataPasien, this.norekammedik});
  @override
  _UpdateJadwalObatObatState createState() => _UpdateJadwalObatObatState();
}

class _UpdateJadwalObatObatState extends State<UpdateJadwalObat> {
  var now = DateTime.now();

  final _formKey = GlobalKey<FormState>();


  final TextEditingController tanggalAmbilController = TextEditingController();
  final TextEditingController tanggalKembaliController = TextEditingController();
  final TextEditingController keluhanController = TextEditingController();

  bool isLoading = false;
  bool isLoadingDelete = false;


  @override
  void initState() {
    initData();
    super.initState();
  }

  initData(){
    setState(() {
      tanggalAmbilController.text = widget.listJadwalObat['tanggalambil'];
      tanggalKembaliController.text = widget.listJadwalObat['tanggalkembali'];
      keluhanController.text = widget.listJadwalObat['keluhan'];
    });
  }



  updateJadwalObat () async {

    setState(() {
      isLoading = true;
    });
    FetchJadwalObat fetchData = FetchJadwalObat();
    fetchData.updateJadwalObat(widget.listJadwalObat['id'], tanggalAmbilController.text, tanggalKembaliController.text, keluhanController.text, widget.idDataPasien.toString())
        .then((value) {
      if (value!=false) {
        showToast('Berhasil mengupdate data');
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

  deleteJadwalObat () async {

    setState(() {
      isLoadingDelete = true;
    });
    FetchJadwalObat fetchData = FetchJadwalObat();
    fetchData.deletejadwalObat(widget.listJadwalObat['id'])
        .then((value) {
      if (value!=false) {
        showToast('Berhasil Menghapus data');
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailListPasien(widget.norekammedik, widget.idDataPasien, index: 1,)));
        setState(() {
          isLoadingDelete = false;
        });
      } else {
        setState(() {
          isLoadingDelete = false;
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
      appBar: AppBar(
        title: Text(
          'Update Jadwal Berobat',
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
           isLoadingDelete? SpinKitThreeBounce(
             size: 30,
             color: Colors.yellow
           ) : FlatButton(
            child: Text('Hapus'),
            onPressed: (){
              deleteJadwalObat();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height / 15.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

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
                      'Simpan',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        updateJadwalObat();
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
