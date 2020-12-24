import 'package:flutter/material.dart';
import 'package:oalarm/lanjut_sebagai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunAdmin extends StatefulWidget {
  @override
  _AkunAdminState createState() => _AkunAdminState();
}

class _AkunAdminState extends State<AkunAdmin> {

  String username = '';

  @override
  void initState() {
    initAkun();
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
      appBar: AppBar(
        title: Text('Akun'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          FlatButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LanjutSebagai()));
              },
              child: Text('Logout', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text(username),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
