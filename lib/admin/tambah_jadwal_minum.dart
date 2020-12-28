import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fraction/fraction.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/service/fetchJadwalMinum.dart';

class TambahJadwalMinum extends StatefulWidget {
  final bool isfromTambahPasien;
  final int idDataPasien;
  final String noRekamMedik;
  TambahJadwalMinum({this.isfromTambahPasien, this.idDataPasien, this.noRekamMedik});

  @override
  _TambahJadwalMinumState createState() => _TambahJadwalMinumState();
}

class _TambahJadwalMinumState extends State<TambahJadwalMinum> {

  List<TimeOfDay> _times = [];

  int jumlahMinum = 1;
  double jumlahObat = 1/2;

  String tipeObat = 'Kapsul';

  bool iosStyle = true;
  bool isLoading = false;


  final _formKey = GlobalKey<FormState>();


  final TextEditingController terapiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _times.add(TimeOfDay.now());

  }



  addJadwalMinum () async {

    String jamMinum = '';
    for(int index=0; index<_times.length; index++){
      if(index!=0){
        jamMinum+=',';
      }
      jamMinum+='${_times[index].format(context)}';
    }


    setState(() {
      isLoading = true;
    });



    FetchJadwalMinum fetchData = FetchJadwalMinum();
    fetchData.storeJadwalMinum(terapiController.text, '$jumlahMinum x ${Fraction.fromDouble(jumlahObat)} $tipeObat', jamMinum, widget.idDataPasien.toString())
        .then((value) {
      if (value!=false) {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailListPasien(widget.noRekamMedik, widget.idDataPasien, index: 2,)));
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

  addJadwalMinumFromTambahPasien () async {

    String jamMinum = '';
    for(int index=0; index<_times.length; index++){
      if(index!=0){
        jamMinum+=',';
      }
      jamMinum+='${_times[index].format(context)}';
    }

    setState(() {
      isLoading = true;
    });
    Map dataMinum = {
      'terapi': terapiController.text,
      'dosis': '$jumlahMinum x ${Fraction.fromDouble(jumlahObat)} $tipeObat',
      'jadwalminum': jamMinum,
    };

    Navigator.pop(context, dataMinum);
  }


  @override
  void dispose() {
    terapiController.dispose();
    super.dispose();
  }


  void onTimeChanged(TimeOfDay newTime, index) {
    setState(() {
      _times[index] = newTime;
    });
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
          color:  terapiController.text.isEmpty? Colors.lightBlueAccent.withOpacity(0.5) : Colors.lightBlueAccent,
          onPressed: isLoading? (){} : () async{
              if (terapiController.text.isNotEmpty) {
                widget.isfromTambahPasien?
                addJadwalMinumFromTambahPasien():
                addJadwalMinum();
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
              Container(
                padding: EdgeInsets.only(top: statusbarHeight),
                height: statusbarHeight + 50,
                child: Center(
                  child: Text(
                    'Tambah Jadwal Minum',
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
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                          controller: terapiController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              labelText: 'Terapi',
                              labelStyle: TextStyle(
                                  fontSize: 13, color: Color(0xffb0aed9)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffb0aed9)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Theme.of(context).accentColor))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        child: Row(
                          children: [
                            Text('Dosis', style: TextStyle(color: Color(0xffb0aed9)),),
                            Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      jumlahMinum++;
                                      _times.add(TimeOfDay.now());
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color(0xffb0aed9),
                                    ),
                                    child: Center(child: Text('+', style: TextStyle(color: Colors.white, fontSize: 15),)),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                  ),
                                  child: Center(child: Text('$jumlahMinum', style: TextStyle(color: Color(0xffb0aed9), fontSize: 15),)),
                                ),
                                InkWell(
                                  onTap: (){
                                    if(jumlahMinum>1){
                                      setState(() {
                                        jumlahMinum--;
                                        _times.removeAt(_times.length-1);
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color(0xffb0aed9),
                                    ),
                                    child: Center(child: Text('-', style: TextStyle(color: Colors.white, fontSize: 15),)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Text('X', style: TextStyle(color: Color(0xffb0aed9), fontSize: 20)),
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      jumlahObat+=1/2;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color(0xffb0aed9),
                                    ),
                                    child: Center(child: Text('+', style: TextStyle(color: Colors.white, fontSize: 15),)),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                  ),
                                  child: Center(child: Text('${Fraction.fromDouble(jumlahObat)}', style: TextStyle(color: Color(0xffb0aed9), fontSize: 12),)),
                                ),
                                InkWell(
                                  onTap: (){
                                    if(jumlahObat>1/2){
                                      setState(() {
                                        jumlahObat-=1/2;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Color(0xffb0aed9),
                                    ),
                                    child: Center(child: Text('-', style: TextStyle(color: Colors.white, fontSize: 15),)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            new DropdownButton<String>(
                              dropdownColor: Color(0xffb0aed9),
                              icon: Icon(Icons.arrow_drop_down, color: Color(0xffb0aed9),),
                              hint: Text('$tipeObat', style: TextStyle(color: Colors.white, fontSize: 15)),
                              items: <String>['Kapsul', 'Pil', 'Tablet', 'Kaplet', 'Sendok Makan', 'Sendok Teh', 'Oles'].map((value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  tipeObat = value;
                                });
                              },
                            )
                          ],
                        )
                      ),
                      Divider(color: Color(0xffb0aed9),),
                      SizedBox(height: 20,),
                      Container(
                        height: 300,
                        child: ListView.builder(
                            itemCount: _times.length,
                            itemBuilder: (context, index){
                              return Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: RaisedButton(
                                  color: Color(0xffb0aed9),
                                  elevation: 0,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      showPicker(
                                        accentColor: Theme.of(context).accentColor,
                                        unselectedColor: Color(0xffb0aed9),
                                        blurredBackground: true,
                                        context: context,
                                        value: _times[index],
                                        onChange: (value){
                                          onTimeChanged(value, index);
                                        },
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Text(
                                        "${_times[index].format(context)}",
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                      Icon(Icons.edit,
                                          color: Colors.white, size: 13),
                                    ],
                                  )
                                ),
                              );
                            }),
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
