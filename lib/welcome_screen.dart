import 'package:flutter/material.dart';
import 'package:oalarm/homepage.dart';
import 'package:oalarm/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(children: <Widget>[

        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/hexagon.jpg',
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100,),
              Text('     Selamat datang di\n            “O! Alarm”', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
              SizedBox(height: 100,),
              Text('Bagaimana perasaanmu? \n\nSudahkah kamu minum obat hari ini?',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*3/4,
          left:0.0,
          right:0.0,
          bottom:0.0,
          child: Builder(
            builder: (context) {
              final GlobalKey<SlideActionState> _key = GlobalKey();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SlideAction(
                  key: _key,
                  outerColor: Colors.blueAccent.withOpacity(0.7),
                  onSubmit: () {
                    Future.delayed(
                      Duration(seconds: 1),
                          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn())),
                    );
                  },
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Geser untuk melanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  sliderButtonIcon: Icon(Icons.chevron_right, color: Colors.blueAccent.withOpacity(0.7),),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
