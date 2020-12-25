import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/service/fetchJadwalMinum.dart';

class UpdateJadwalMinum extends StatefulWidget {
  final dynamic dataJadwalMinum;
  final int idDataPasien;
  final String noRekamMedik;
  UpdateJadwalMinum({this.dataJadwalMinum, this.idDataPasien, this.noRekamMedik});

  @override
  _UpdateJadwalMinumState createState() => _UpdateJadwalMinumState();
}

class _UpdateJadwalMinumState extends State<UpdateJadwalMinum> {

  List<TimeOfDay> _times = [];

  bool iosStyle = true;
  bool isLoading = false;


  final _formKey = GlobalKey<FormState>();


  final TextEditingController dosisController = TextEditingController();
  final TextEditingController terapiController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData(){

    String time = widget.dataJadwalMinum['jadwalminum'];
    List<String> listTime = time.split(',');

    print(listTime);


    setState(() {
      dosisController.text = widget.dataJadwalMinum['dosis'];
      terapiController.text = widget.dataJadwalMinum['terapi'];

      for(int i=0; i<listTime.length;i++){
        TimeOfDay timeOfDay = TimeOfDay(hour: int.parse(listTime[i].split(':').first), minute: int.parse(listTime[i].split(':').last));
        _times.add(timeOfDay);
      }

    });
  }





  updateJadwalMinum () async {

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
    fetchData.updateJadwalMinum(widget.dataJadwalMinum['id'], terapiController.text, dosisController.text, jamMinum, widget.idDataPasien.toString())
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

  @override
  void dispose() {
    dosisController.dispose();
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
            child: isLoading? SpinKitThreeBounce(
              size: 30,
              color: Colors.yellow,
            )  : Text(
              'Simpan',
              textScaleFactor: 1.5,
            ),
            onPressed: (){
              if (_formKey.currentState.validate()) {
                updateJadwalMinum();
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
