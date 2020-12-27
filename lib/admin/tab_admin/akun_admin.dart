import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oalarm/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunAdmin extends StatefulWidget {
  @override
  _AkunAdminState createState() => _AkunAdminState();
}

class _AkunAdminState extends State<AkunAdmin> {

  String username = '';
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    initAkun();



    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize,iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings);


    super.initState();
  }

  initAkun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('admin_username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff3e3a63),
        body: Stack(
          children: [
            buildShape(),
            Positioned(
                top: 80,
                left: 20,
                child: Text(username, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),)
            ),

            Positioned(
                top: 40,
                right: 10,
                child: InkWell(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('is_pasien', false);
                    prefs.setBool('is_admin', false);
                    fltrNotification.cancelAll();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/logout.png')
                    ,
                  ),
                )
            ),
            Positioned(
                top: 94,
                right: 45,
                child: CircleAvatar(
                  radius: 63,
                  backgroundColor: Colors.blue[100].withOpacity(0.5),
                )
            ),
            Positioned(
                top: 100,
                right: 50,
                child: CircleAvatar(
                    radius: 57,
                    backgroundColor: Color(0xffe6e6e6),
                    backgroundImage: AssetImage('assets/images/account.png')
                )
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.only(top: 250),
              child: ListView(
                children: [
                ],
              ),
            ),
          ],
        )
    );
  }

  static Widget buildShape(){
    return ClipPath(
      clipper: CustomShapeClass(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff3587fc), Color(0xff10c8ff)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),
        ),
      ),
    );
  }

}



class CustomShapeClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height / 4.5);
    var firstControlPoint = new Offset(size.width / 4.5, size.height / 2.4);
    var firstEndPoint = new Offset(size.width / 2.5, size.height / 2.3 - 60);
    var secondControlPoint =
    new Offset(size.width - (size.width / 3), size.height / 2.9 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 5 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)
  {
    return true;
  }
}


