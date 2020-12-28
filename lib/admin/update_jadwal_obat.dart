import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
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
          color: Colors.lightBlueAccent,
          onPressed: isLoading? (){} : () {
            if(tanggalAmbilController.text.isNotEmpty || tanggalKembaliController.text.isNotEmpty || keluhanController.text.isNotEmpty
            ){
              updateJadwalObat();
            }
            else {
              Fluttertoast.showToast(
                  msg:
                  'Harap isi semua data',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 14.0,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white);
            }
          },
          child: isLoading? SpinKitThreeBounce(
            color: Colors.white,
            size: 30.0,
          ) : Text(
            'SIMPAN',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: statusbarHeight),
                  height: statusbarHeight + 50,
                  child: Center(
                    child: Text(
                      'Update Jadwal Obat',
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
                Positioned(
                  top: 45,
                  right: 20,
                  child: isLoadingDelete? SpinKitThreeBounce(
                      size: 30,
                      color: Colors.white
                  ) : InkWell(
                    child: Icon(Icons.delete_forever, color: Colors.white,),
                    onTap: (){
                      deleteJadwalObat();
                    },
                  ),
                )
              ],
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
                            labelText: 'Tanggal Lahir',
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
                            labelText: 'Tanggal Lahir',
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
