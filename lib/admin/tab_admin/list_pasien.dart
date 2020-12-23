import 'package:flutter/material.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';

class ListPasien extends StatefulWidget {
  @override
  _ListPasienState createState() => _ListPasienState();
}

class _ListPasienState extends State<ListPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Minum Obat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index){
            return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailListPasien()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text('Ny. M'),
                        subtitle: Text('F.20'),
                        trailing: Icon(Icons.chevron_right),
                      )
                  ),
                )
            );
          }),
    );
  }
}
