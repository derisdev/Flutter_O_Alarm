import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oalarm/admin/detail_list_pasien.dart';
import 'package:oalarm/admin/tambah-pasien.dart';
import 'package:oalarm/service/fetchdataPasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login.dart';

class ListPasien extends StatefulWidget {
  @override
  _ListPasienState createState() => _ListPasienState();
}

enum MENU {HAPUS }


class _ListPasienState extends State<ListPasien> {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime currentBackPressTime;


  String username = '';

  List listDataPasien = [];
  bool isLoading = true;
  @override
  void initState() {
    getAllPasien();
    initAkun();
    super.initState();
  }

  initAkun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('admin_username');
    });
  }

  getAllPasien() {
    setState(() {
      isLoading = true;
    });
    FetchDataPasien fetchData = FetchDataPasien();
    fetchData.getAllDataPasien().then((value) {
      if (value != false) {
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

  deletePasien(int id){

    setState(() {
      isLoading = true;
    });


    FetchDataPasien fetchDataPasien = FetchDataPasien();
    fetchDataPasien.deleteDataPasien(id.toString()).then((value){
      if(value!=false){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListPasien()));
        setState(() {
          isLoading = false;
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xff3e3a63),
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahPasien()));
          },
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
          ),
        ),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: statusbarHeight),
                    height: statusbarHeight + 50,
                    child: Center(
                      child: Text(
                        'Daftar Pasien',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.5, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                  ),
                  Positioned(
                      left: 10,
                      top: 30,
                      child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.white,),
                        onPressed: (){
                          scaffoldKey.currentState.openDrawer();
                        },
                      )),
                ],
              ),
              Container(
                height:
                    MediaQuery.of(context).size.height - 50 - statusbarHeight,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : listDataPasien.isEmpty
                        ? Center(
                            child: Text('Belum ada pasien',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 17)),
                          )
                        : MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                itemCount: listDataPasien.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailListPasien(
                                                        listDataPasien[index]
                                                            ['norekammedik'],
                                                        listDataPasien[index]
                                                            ['id'])));
                                      },
                                      onLongPress: (){
                                        confirm(context, listDataPasien[index]);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 20),
                                        margin: EdgeInsets.only(
                                            top: index == 0 ? 6 : 0),
                                        child: Card(
                                            color: Color(0xff434372),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                              leading: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minWidth: 30,
                                                  minHeight: 30,
                                                  maxWidth: 30,
                                                  maxHeight: 30,
                                                ),
                                                child: Image.asset(
                                                  'assets/images/account.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              title: Text(
                                                listDataPasien[index]['nama'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              subtitle: Text(
                                                listDataPasien[index]
                                                    ['kodediagnosa'],
                                                style: TextStyle(
                                                    color: Color(0xffadaad6)),
                                              ),
                                              trailing: Icon(Icons.chevron_right, color: Color(0xffadaad6)),
                                            )),
                                      ));
                                }),
                          ),
              ),
            ],
          ),
        ));
  }

  Widget buildDrawer(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xff3e3a63), //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(

        child: ListView(
          children: <Widget>[
            new Container(
              child: new DrawerHeader(
                  child: CircleAvatar(
                  radius: 57,
                  backgroundColor: Color(0xffe6e6e6),
                  backgroundImage: AssetImage('assets/images/account.png')
              )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff3587fc), Color(0xff10c8ff)],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),),
            ListTile(
              title: Text(username, style: TextStyle(color: Colors.white, fontSize: 15),),
              leading: Icon(Icons.person, color: Colors.white,),
              onTap: ()  {

              },
            ),
            RaisedButton(
              onPressed: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('is_pasien', false);
                prefs.setBool('is_admin', false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
              },
              color: Color(0xff10c8ff),
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }


  Future<Null> confirm(BuildContext context, dynamic jadwalMinum) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, MENU.HAPUS);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.lightBlueAccent,
                    ),
                    title:
                    Text('HAPUS', textAlign: TextAlign.center),
                  )),

            ],
          );
        })) {
      case MENU.HAPUS:
        deletePasien(jadwalMinum['id']);
        break;
    }
  }


  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
