import 'package:flutter/material.dart';

class AkunAdmin extends StatefulWidget {
  @override
  _AkunAdminState createState() => _AkunAdminState();
}

class _AkunAdminState extends State<AkunAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Nama'),
                subtitle: Text('Ny. M'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
