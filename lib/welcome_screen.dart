import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'lanjut_sebagai.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(children: <Widget>[
        Container(
          height: double.infinity,
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey.withOpacity(0.0),
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100,),
                Text('Selamat datang di\n“O! Alarm”.', style: TextStyle(color: Color(0xff8b2f08), fontSize: 25),),
                SizedBox(height: 50,),
                Text('Bagaimana perasaanmu? \n\nSudahkah kamu minum obat hari ini?',
                    style: TextStyle(color: Color(0xff8b2f08))),
              ],
            ),
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
                  outerColor: Color(0xff8b2f08),
                  onSubmit: () {
                    Future.delayed(
                      Duration(seconds: 1),
                          () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LanjutSebagai())),
                    );
                  },
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Geser untuk melanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  sliderButtonIcon: Icon(Icons.chevron_right, color: Color(0xff8b2f08),),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
