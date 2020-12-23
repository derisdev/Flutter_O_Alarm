import 'package:flutter/material.dart';
import 'package:oalarm/login.dart';

class LanjutSebagai extends StatefulWidget {
  @override
  _LanjutSebagaiState createState() => _LanjutSebagaiState();
}

class _LanjutSebagaiState extends State<LanjutSebagai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 60,
              child: RaisedButton(
                  elevation: 7,
                  color: Color(0xff8b2f08),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side:
                      BorderSide(color: Color(0xffACADA9), width: 0.1)),
                  child: Text('Masuk Sebagi Admin',  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn(isAdmin:true)));
                  }),
            ),
            SizedBox(height: 20,),
            Container(
              width: 200,
              height: 60,
              child: RaisedButton(
                  elevation: 7,
                  color: Color(0xff8b2f08),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side:
                      BorderSide(color: Color(0xffACADA9), width: 0.1)),
                  child: Text('Masuk Sebagi Pasien',  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn(isAdmin:false)));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
