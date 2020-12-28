import 'package:flutter/material.dart';
import 'package:oalarm/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/tab_admin/list_pasien.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), (){
      checkIsLogin();
    });
    super.initState();
  }

  void checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPasien = prefs.getBool('is_pasien');
    if(isPasien==null){
      isPasien = false;
    }
    bool isAdmin = prefs.getBool('is_admin');
    if(isAdmin==null){
      isAdmin = false;
    }
      if(isPasien){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      else if(isAdmin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListPasien()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
  }



  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/splash.png",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
