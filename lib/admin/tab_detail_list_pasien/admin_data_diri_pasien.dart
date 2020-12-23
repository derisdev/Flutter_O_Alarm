import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDataDiriPasien extends StatefulWidget {
  @override
  _AdminDataDiriPasienState createState() => _AdminDataDiriPasienState();
}

class _AdminDataDiriPasienState extends State<AdminDataDiriPasien> {
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


  File file;

  String image;

  double sliderValue = 0;

  bool isLoading = false;
  bool isLoadingAvatar = false;
  bool isLoadingScreen = false;



  @override
  void initState() {
    super.initState();
    getUserInfo();

    Future.delayed(Duration(seconds: 1), (){
      setState(() {
        isLoadingScreen = false;
      });
    });
  }

  getUserInfo() async {
    file = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    String gambar = prefs.getString('gambar');
    String tanggallahir = prefs.getString('tanggallahir');
    String jeniskelamin = prefs.getString('jeniskelamin');
    String nohp = prefs.getString('nohp');
    String email = prefs.getString('email');

    setState(() {
      usernameController.text = username;
      alamatController.text = tanggallahir;
      kodeDiagnosaController.text = jeniskelamin;
      kodeDxController.text = nohp;
      tanggallahirController.text = email;
      this.image = gambar;


      if (username != null) {
        sliderValue += 17;
      }
      if (gambar != null || gambar != 'default-avatar.png') {
        sliderValue += 16.6;
      }
      if (email != null) {
        sliderValue += 16.6;
      }
      if (tanggallahir != null) {
        sliderValue += 16.6;
      }
      if (jeniskelamin != null) {
        sliderValue += 16.6;
      }
      if (nohp != null) {
        sliderValue += 16.6;
      }
    });
  }
  //
  // void updateProfile() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   FetchDataUser fetchData = FetchDataUser();
  //   fetchData
  //       .updateProfile(usernameController.text, tanggallahirController.text,alamatController.text,
  //       kodeDiagnosaController.text)
  //       .then((value) {
  //     if (value) {
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => HomePage(index: 4)));
  //       setState(() {
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }
  //
  // void updateAvatar() async {
  //   File  file = await FilePicker.getFile(type: FileType.image);
  //   if(file!=null){
  //     File croppedImage = await ImageCropper.cropImage(
  //         sourcePath: file.path,
  //         maxWidth: 1080,
  //         maxHeight: 1080,
  //         aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
  //     );
  //     if (croppedImage  != null) {
  //
  //       setState(() {
  //         isLoadingAvatar = true;
  //         this.file = croppedImage;
  //       });
  //
  //       FetchDataUser fetchData = FetchDataUser();
  //       fetchData.updateAvatar(croppedImage).then((value){
  //         if(value){
  //
  //           setState(() {
  //             isLoadingAvatar = false;
  //           });
  //
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => HomePage(index: 4)));
  //         }
  //
  //         else {
  //           setState(() {
  //             isLoadingAvatar = false;
  //           });
  //         }
  //       });
  //     }
  //   }
  // }

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 80,),
                          Text('AKUN SAYA',
                              style: TextStyle(fontSize: 17, color: Color(0xff8b2f08))),
                          FlatButton(
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setBool('is_login', false);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => LogIn()));
                            },
                            child: Text('Logout',
                                style: TextStyle(fontSize: 17, color: Color(0xff8b2f08))),
                          ),
                        ],
                      )
                  )),
            ),
            Positioned(
                top: 250,
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
                          height: 70,
                        ),
                        Container(
                          height: 50,
                          child: new Flexible(
                            child: TextField(
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xff8b2f08)),
                              controller: usernameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xff8b2f08),
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.edit,
                                      color: Color(0xff8b2f08), size: 15),
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
                                            color: Color(0xff8b2f08), fontWeight: FontWeight.bold, fontSize: 18),
                                        doneStyle: TextStyle(color: Color(0xff8b2f08), fontSize: 16)),
                                    onChanged: (date) {

                                    }, onConfirm: (date) {
                                      setState(() {
                                        alamatController.text = date.toString().split(' ').first;
                                      });
                                    }, currentTime: DateTime.now(), locale: LocaleType.id);
                              },
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Color(0xff8b2f08)),
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
                              style: TextStyle(color: Color(0xff8b2f08)),
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
                              readOnly: true,
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xffabaca9), fontSize: 13),
                              controller: alamatController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Alamat',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffabaca9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffabaca9)),
                                ),
                              ),
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
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xffabaca9), fontSize: 13),
                              controller: kodeDiagnosaController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Kode Diagnosa (ICD X)',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffabaca9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffabaca9)),
                                ),
                              ),
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
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xffabaca9), fontSize: 13),
                              controller: kodeDxController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Kode Dx. Kep',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffabaca9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffabaca9)),
                                ),
                              ),
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
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xffabaca9), fontSize: 13),
                              controller: terapiController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Terapi',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffabaca9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffabaca9)),
                                ),
                              ),
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
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xffabaca9), fontSize: 13),
                              controller: dosisController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'Dosis',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffabaca9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffabaca9)),
                                ),
                              ),
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
                              textAlign: TextAlign.left,
                              style:
                              TextStyle(color: Color(0xffabaca9), fontSize: 13),
                              controller: pmoController,
                              keyboardType: TextInputType.text,
                              cursorColor: Color(0xffabaca9),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                labelText: 'PMO',
                                labelStyle: TextStyle(
                                    fontSize: 13, color: Color(0xffabaca9)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffabaca9)),
                                ),
                              ),
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
                              if(usernameController.text.isNotEmpty || alamatController.text.isNotEmpty || kodeDiagnosaController.text.isNotEmpty
                                  || alamatController.text.isNotEmpty || tanggallahirController.text.isNotEmpty
                              ){
                                if(tanggallahirController.text.contains('@')){
                                  // updateProfile();
                                }
                                else {
                                  Fluttertoast.showToast(
                                      msg:
                                      'Harap isi masukkan email yang valid',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      fontSize: 14.0,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white);
                                }
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
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 240,
              child: Container(
                color: Colors.white,
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    sliderValue == 100? SizedBox(height: 20,) : Align(
                      alignment: Alignment.center,
                      child: Text('Lengkapi Profil',
                          style: TextStyle(fontSize: 17, color: Color(0xff8b2f08))),
                    ),
                    SizedBox(
                      width: 300,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10,
                          valueIndicatorColor:
                          Color(0xffededed), // This is what you are asking for
                          inactiveTrackColor:
                          Color(0xffededed), // Custom Gray Color
                          activeTrackColor: Color(0xff8b2f08),
                          thumbColor: Color(0xff8b2f08),
                          thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 5.7),
                        ),
                        child: Slider(
                            min: 0.0,
                            max: 100,
                            value: sliderValue,
                            onChanged: (value) {}),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 96,
                left: MediaQuery.of(context).size.width / 2 - 63,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 57,
                      backgroundColor: Color(0xffe6e6e6),
                      backgroundImage: file!=null? FileImage(file) : NetworkImage(image == null ||  image != 'default-avatar.png'
                          ? ''
                          : 'http://api.fillocoffee.web.id/images/user/$image'),
                    ),
                    isLoadingAvatar? Positioned(
                      left: 30,
                      top: 30,
                      child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator()),
                    ) : SizedBox()

                  ],
                )
            ),
            Positioned(
                top: 196,
                left: MediaQuery.of(context).size.width / 2 - 15,
                child: InkWell(
                  onTap: () async {
                    // updateAvatar();
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    child: CustomPaint(
                        painter: CirclePainter(),
                        child:
                        Icon(Icons.edit, color: Color(0xff8b2f08), size: 15)),
                  ),
                ))
          ],
        ));
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Color(0xff8b2f08)
    ..strokeWidth = 2
  // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
