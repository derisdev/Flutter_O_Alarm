import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TambahJadwalMinum extends StatefulWidget {
  final bool isfromTambahPasien;
  TambahJadwalMinum({this.isfromTambahPasien});

  @override
  _TambahJadwalMinumState createState() => _TambahJadwalMinumState();
}

class _TambahJadwalMinumState extends State<TambahJadwalMinum> {

  List<String> jamMinum = [];

  List<TimeOfDay> _times = [];

  bool iosStyle = true;


  var now = DateTime.now();
  final String nonfavorite = 'nonfavorit';

  final _formKey = GlobalKey<FormState>();


  final TextEditingController dosisController = TextEditingController();
  final TextEditingController terapiController = TextEditingController();
  final TextEditingController KeluhanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _times.add(TimeOfDay.now().replacing(minute: 30));

  }

  @override
  void dispose() {
    dosisController.dispose();
    terapiController.dispose();
    KeluhanController.dispose();
    super.dispose();
  }


  void onTimeChanged(TimeOfDay newTime, index) {
    setState(() {
      _times[index] = newTime;
    });
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        child: RaisedButton(
            focusColor: Colors.white,
            splashColor: Colors.white,
            color: Theme.of(context).buttonColor,
            textColor: Colors.white,
            child: Text(
              'Simpan',
              textScaleFactor: 1.5,
            ),
            onPressed: (){
              if (_formKey.currentState.validate()) {
                // widget.mySong == null? _saveData() : _updateData();
              }
            }),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height / 15.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  child: Text(
                    'Tambah Jadwal Minum',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
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
                    style: TextStyle(color: Color(0xff8b2f08)),
                    controller: terapiController,
                    keyboardType: TextInputType.emailAddress,
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
                    style: TextStyle(color: Color(0xff8b2f08)),
                    controller: dosisController,
                    keyboardType: TextInputType.emailAddress,
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
              Container(
                height: 300,
                child: ListView.builder(
                    itemCount: _times.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () {
                            Navigator.of(context).push(
                              showPicker(
                                context: context,
                                value: _times[index],
                                onChange: (value){
                                  onTimeChanged(value, index);
                                },
                              ),
                            );
                          },
                          child: Text(
                            "${_times[index].format(context)}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
              RaisedButton(
                onPressed: (){
                 setState(() {
                   _times.add(TimeOfDay.now().replacing(minute: 30));
                 });
                },
                child: Text('Tambah Jam Minum'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
