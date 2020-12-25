import 'dart:math';

import 'package:better_uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tambah_jadwal_obat.dart';
import 'package:oalarm/login.dart';
import 'package:oalarm/service/fetchdataPasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahPasien extends StatefulWidget {
  @override
  _TambahPasienState createState() => _TambahPasienState();
}

class _TambahPasienState extends State<TambahPasien> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController tanggallahirController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kodeDiagnosaController = TextEditingController();
  TextEditingController kodeDxController = TextEditingController();
  TextEditingController terapiController = TextEditingController();
  TextEditingController dosisController = TextEditingController();
  TextEditingController pmoController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new  GlobalKey<ScaffoldState>();

  PersistentBottomSheetController _controller;

  double sliderValue = 0;

  bool isLoading = false;
  bool isLoadingScreen = false;



  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    usernameController.dispose();
    tanggallahirController.dispose();
    umurController.dispose();
    alamatController.dispose();
    kodeDiagnosaController.dispose();
    kodeDxController.dispose();
    terapiController.dispose();
    dosisController.dispose();
    pmoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: isLoadingScreen? Center(
          child: CircularProgressIndicator(),
        ) : Stack(
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.height),
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffededed)),
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text('Data Pasien',
                          style: TextStyle(fontSize: 17, color: Color(0xff8b2f08)))
                  )),
            ),
            Positioned(
                top: 100,
                right: 0.0,
                bottom: 0.0,
                left: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 180,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: usernameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.edit,
                                      color: Color(0xff8b2f08), size: 13),
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Nama',
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
                        SizedBox(
                          height: 20,
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
                                            color: Color(0xff8b2f08), fontWeight: FontWeight.bold, fontSize: 13),
                                        doneStyle: TextStyle(color: Color(0xff8b2f08), fontSize: 13)),
                                    onChanged: (date) {

                                    }, onConfirm: (date) {
                                      setState(() {
                                        tanggallahirController.text = date.toString().split(' ').first;
                                      });
                                    }, currentTime: DateTime.now(), locale: LocaleType.id);
                              },
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: tanggallahirController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Tanggal Lahir',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: umurController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Umur',
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

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: alamatController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Alamat',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: kodeDiagnosaController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Kode Diagnosa (ICD X)',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: kodeDxController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Kode Dx. Kep',
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

                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: terapiController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Terapi',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: dosisController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'Dosis',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xff8b2f08), fontSize: 13),
                              controller: pmoController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  labelText: 'PMO',
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
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Color(0xff8b2f08),
                            onPressed: isLoading? (){} : () {
                              {
                              if(usernameController.text.isNotEmpty || alamatController.text.isNotEmpty || kodeDiagnosaController.text.isNotEmpty
                              || alamatController.text.isNotEmpty || tanggallahirController.text.isNotEmpty || umurController.text.isNotEmpty
                              || kodeDxController.text.isNotEmpty || terapiController.text.isNotEmpty || dosisController.text.isNotEmpty|| pmoController.text.isNotEmpty
                              ){

                                var id = Uuid.v1();

                                int min = 100;
                                int max = 999;
                                var randomizer = new Random();
                                var kodeUnik = min + randomizer.nextInt(max - min);
                                String norekammedik = '001100'+kodeUnik.toString();
                                Map dataPasien = {
                                  'norekammedik': norekammedik,
                                  'nama': usernameController.text,
                                  'tanggallahir': tanggallahirController.text,
                                  'alamat': alamatController.text,
                                  'umur': umurController.text,
                                  'kodediagnosa': kodeDiagnosaController.text,
                                  'kodedx': kodeDxController.text,
                                  'terapi': terapiController.text,
                                  'dosis': dosisController.text,
                                  'pmo': pmoController.text
                                };
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TambahJadwalObat(isfromTambahPasien: true, dataPasien: dataPasien,)));
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
                              }}
                            },
                            child: isLoading? SpinKitThreeBounce(
                              color: Colors.white,
                              size: 30.0,
                            ) : Text(
                              'Selanjutnya',
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                )),


          ],
        ));
  }
}
