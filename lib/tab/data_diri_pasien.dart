import 'package:flutter/material.dart';

class DataDiriPasien extends StatefulWidget {
  @override
  _DataDiriPasienState createState() => _DataDiriPasienState();
}

class _DataDiriPasienState extends State<DataDiriPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Diri Pasien'),
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
            Card(
              child: ListTile(
                title: Text('TTL/Umur'),
                subtitle: Text('27 Agustus 1990/30'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Alamat'),
                subtitle: Text('Jln. Sukamaju'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Kode diagnosa (ICD X)'),
                subtitle: Text('F.20'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Kode Dx. Kep 00118'),
                subtitle: Text('F.20'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Terapi'),
                subtitle: Text('Halloperidol 5 Mg'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Dosis'),
                subtitle: Text('2 x 1/2'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('PMO'),
                subtitle: Text('Tn. R'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
