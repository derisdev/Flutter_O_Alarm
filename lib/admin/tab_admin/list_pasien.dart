import 'package:flutter/material.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tambah-pasien.dart';
import 'package:oalarm/service/fetchdataPasien.dart';

class ListPasien extends StatefulWidget {
  @override
  _ListPasienState createState() => _ListPasienState();
}

class _ListPasienState extends State<ListPasien> {

  List listDataPasien = [];
  bool isLoading = true;
  @override
  void initState() {
    getAllPasien();
    super.initState();
  }


  getAllPasien () {
    setState(() {
      isLoading = true;
    });
    FetchDataPasien fetchData = FetchDataPasien();
    fetchData.getAllDataPasien()
        .then((value) {
      if (value!=false) {
        setState(() {
          listDataPasien = value;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pasien'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahPasien()));
        },
        child: Icon(Icons.add),
      ),
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: listDataPasien.length,
          itemBuilder: (context, index){
            return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailListPasien(listDataPasien[index]['norekammedik'], listDataPasien[index]['id'])));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text(listDataPasien[index]['nama']),
                        subtitle: Text(listDataPasien[index]['kodediagnosa']),
                        trailing: Icon(Icons.chevron_right),
                      )
                  ),
                )
            );
          }),
    );
  }
}
