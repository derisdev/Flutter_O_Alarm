import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/admin/tambah_jadwal_obat.dart';

class TambahPasien extends StatefulWidget {
  @override
  _TambahPasienState createState() => _TambahPasienState();
}

class _TambahPasienState extends State<TambahPasien> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController tanggallahirController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController pmoController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new  GlobalKey<ScaffoldState>();

  double sliderValue = 0;

  bool isLoading = false;
  bool isLoadingScreen = false;

  String kodeDx;
  String kodeDiagnosa;

  List<String> listKodeDiagnosa = [
    'F00-F19 :Gangguan mental organik dan simtomatik',
    'F10-f19 : Gangguan mental termasuk perilaku akibat penggunaan zat psikoaktif',
    'F20-F29 : Skizofrenia, gangguan waham dan gangguan skizotipal ',
    'F30-F39: Gangguan perasaan (mood/ afektif)',
    'F40-F48:Gangguan somatoform, gangguan neurotik dan gangguan terkait stres ',
    'F50-F59:Sindrom perilaku yang berhubungan dengan faktor fisik dan gangguan fisik',
    'F60-F69:Gangguan perilaku masa dewasa dan gangguan kepribadian',
    'F70-F79: Retardasi mental',
    'F80-F89: Gangguan  psikologis',
    'F90-F98: Gangguan emosional  dan perilaku biasanya pada anak dan remaja '
  ];

  List<String> listKodeDx = [

    '00132 : Nyeri akut',
    '00155 : Risiko jatuh',
    '00007 : Hipertermia',
    '00027 : Defisit volume cairan',
    '00002 : Ketidakseimbangan nutrisi kurang dari kebutuhan tubuh',
    '00031 : Ketidakefektifan bersihan jalan nafas',
    '00032 : Ketidakefektifan pola nafas',
    '00201 : Resikko ketidakefektifan perfusi jaringan serebral',
    '00094 : Intoleransi aktifitas',
    '00085 : Hambatan mobilitas fisik',
    '00146 : Ansietas',
    '00118 : Gangguan citra tubuh',
    '00120 : Harga diri rendah situasional',
    '00125 : Ketidakberdayaan',
    '00124 : Keputusasaan',
    '00069 : Ketidakefektifan koping individu',
    '00136 : Dukacita',
    '00078 : Ketidakefektifan manajemen kesehatan',
    '00055 : Ketidakefektifan performa peran',
    '00066 : Distres spiritual',
    '00140 : Risiko perilaku kekerasan terhadap Diri sendiri ',
    '00138 : Risiko perilaku kekerasan terhadap orang lain',
    'Halusinasi',
    'Waham',
    '00119 : Harga diri rendah kronik',
    '00053 : Isolasi social',
    '00182 : Kesiapan meningkatkan perawatan diri',
    '00108 : Defisit perawatan diri : Mandi',
    '00109 : Defisit perawatan diri : Berpakaian',
    '00102 : Defisit perawatan diri : Makan',
    '00110 : Defisit perawatan diri :Eliminasi',
    '00051 : Hambatan komunikasi verbal',
    '00099 : Ketidakefektifan pemeliharaan kesehatan',
    '00150 : Risiko bunuh diri'
  ];


  @override
  void initState() {
    super.initState();
    kodeDx =listKodeDx[0];
    kodeDiagnosa = listKodeDiagnosa[0];


  }

  @override
  void dispose() {
    usernameController.dispose();
    tanggallahirController.dispose();
    alamatController.dispose();
    pmoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: statusbarHeight),
                height: statusbarHeight + 50,
                child: Center(
                  child: Text(
                    'Detail Pasien',
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
              isLoadingScreen? Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2-50-statusbarHeight),
                child: CircularProgressIndicator(),
              ) : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50 - statusbarHeight,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(

                              contentPadding: EdgeInsets.all(5),
                              labelText: 'Nama',
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
                      SizedBox(
                        height: 20,
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
                                    tanggallahirController.text = date.toString().split(' ').first;
                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.id);
                          },
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                          controller: tanggallahirController,
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.left,
                          style:
                          TextStyle(color: Colors.white, fontSize: 13),
                          controller: alamatController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(

                              contentPadding: EdgeInsets.all(5),
                              labelText: 'Alamat',
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
                      SizedBox(height: 30),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffb0aed9)))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 6),
                              child: Text('Kode Diagnosa', style: TextStyle(
                                fontSize: 10, color: Color(0xffb0aed9),)),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 6),
                              child: new DropdownButton<String>(
                                isExpanded: true,
                                dropdownColor: Color(0xffb0aed9),
                                icon: Icon(Icons.arrow_drop_down, color: Color(0xffb0aed9),),
                                hint: Text('$kodeDiagnosa', style: TextStyle(color: Colors.white, fontSize: 13)),
                                items: listKodeDiagnosa.map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value, style: TextStyle(color: Color(0xff3e3a63)),),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    kodeDiagnosa = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffb0aed9)))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 6),
                              child: Text('Kode Dx. Kep', style: TextStyle(
                                fontSize: 13, color: Color(0xffb0aed9),)),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 6),
                              child: new DropdownButton<String>(
                                isExpanded: true,
                                dropdownColor: Color(0xffb0aed9),
                                icon: Icon(Icons.arrow_drop_down, color: Color(0xffb0aed9),),
                                hint: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text('$kodeDx', style: TextStyle(color: Colors.white, fontSize: 13))),
                                items: listKodeDx.map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value, style: TextStyle(color: Color(0xff3e3a63), fontSize: 13)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    kodeDx = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.left,
                          style:
                          TextStyle(color: Colors.white, fontSize: 13),
                          controller: pmoController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              labelText: 'PMO',
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
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: usernameController.text.isNotEmpty && alamatController.text.isNotEmpty && alamatController.text.isNotEmpty && tanggallahirController.text.isNotEmpty
                           ? Colors.lightBlueAccent : Colors.lightBlueAccent.withOpacity(0.5),
                          onPressed: isLoading? (){} : () {
                            {
                              if(usernameController.text.isNotEmpty && alamatController.text.isNotEmpty && alamatController.text.isNotEmpty && tanggallahirController.text.isNotEmpty

                              ){

                                DateTime currentTime = DateTime.now();

                                List<String> listDate = tanggallahirController.text.split('-');
                                DateTime newDate = DateTime(int.parse(listDate[0]), int.parse(listDate[1]), int.parse(listDate[2]));
                                int difference = currentTime.difference(newDate).inDays;

                                double umur = difference/365;

                                int min = 10000000;
                                int max = 99999999;
                                var randomizer = new Random();
                                var kodeUnik = min + randomizer.nextInt(max - min);
                                String norekammedik = kodeUnik.toString();
                                Map dataPasien = {
                                  'norekammedik': norekammedik,
                                  'nama': usernameController.text,
                                  'tanggallahir': tanggallahirController.text,
                                  'alamat': alamatController.text,
                                  'umur': umur.toString().split('.').first,
                                  'kodediagnosa': kodeDiagnosa,
                                  'kodedx': kodeDx,
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
              )
            ],
          ),
        ));
  }
}
