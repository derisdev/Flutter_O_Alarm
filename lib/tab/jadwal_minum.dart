import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oalarm/service/fetchdataPasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../detail_jadwal_minum.dart';

class JadwalMinum extends StatefulWidget {
  @override
  _JadwalMinumState createState() => _JadwalMinumState();
}

class _JadwalMinumState extends State<JadwalMinum> {

  FlutterLocalNotificationsPlugin fltrNotification;

  List listJadwalMinum = [];
  bool isLoading = true;
  @override
  void initState() {
    getPasien();


    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize,iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);


    super.initState();
  }


  getPasien () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String noRekamMedik = prefs.getString('norekammedik');

    setState(() {
      isLoading = true;
    });
    FetchDataPasien fetchData = FetchDataPasien();
    fetchData.showDataPasien(noRekamMedik)
        .then((value) {
      if (value!=false) {


        List listJadwalMinumm = value['jadwal_minums'];

        for(int i=0; i<listJadwalMinumm.length;i++){
          String deskripsi = listJadwalMinumm[i]['terapi']+' x '+listJadwalMinumm[i]['dosis'].split('x').last;

          String listWaktu = listJadwalMinumm[i]['jadwalminum'];

          List<String> jamlistWaktu = listWaktu.split(',');

          print(jamlistWaktu);

          for(int j=0;j<jamlistWaktu.length;j++){
            int jam = int.parse(jamlistWaktu[j].split(':').first);
            int menit = int.parse(jamlistWaktu[j].split(':').last);

            _showNotification(deskripsi, jam, menit, i+1, j+1);

          }

        }

        setState(() {
          if(mounted){
            listJadwalMinum = value['jadwal_minums'];
            isLoading = false;
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }



  Future notificationSelected(String payload) async {
    // if (payload != null) {
    //   debugPrint('notification payload: $payload');
    // }
    // await Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => HomePage()),
    // );
  }

  Future _showNotification(String deskripsi, int jam, int menit, int indexObat, int indexWaktu) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "OAlarm", "This is notif alarm",
        playSound: true,
        sound: RawResourceAndroidNotificationSound('alarm_clock'),
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iSODetails);

    print('jam $jam, menit $menit');

    DateTime currentTime = DateTime.now();
    DateTime newDate = DateTime(currentTime.year, currentTime.month, currentTime.day, jam, menit);
    int difference = newDate.difference(currentTime).inSeconds;
    print(difference);
    final scheduledTime1 = DateTime.now().add(Duration(seconds: difference));
    final scheduledTime2 = DateTime.now().add(Duration(days: 1, seconds: difference));
    final scheduledTime3 = DateTime.now().add(Duration(days: 2, seconds: difference));
    final scheduledTime4 = DateTime.now().add(Duration(days: 3, seconds: difference));
    final scheduledTime5 = DateTime.now().add(Duration(days: 4, seconds: difference));
    final scheduledTime6 = DateTime.now().add(Duration(days: 5, seconds: difference));
    final scheduledTime7 = DateTime.now().add(Duration(days: 6, seconds: difference));


    if(difference>0){
      fltrNotification.schedule(indexObat+indexWaktu*100, "Waktunya minum obat!", deskripsi,
          scheduledTime1, generalNotificationDetails);
    }

    fltrNotification.schedule(indexObat+indexWaktu*110, "Waktunya minum obat!", deskripsi,
        scheduledTime2, generalNotificationDetails);

    fltrNotification.schedule(indexObat+indexWaktu*120, "Waktunya minum obat!", deskripsi,
        scheduledTime3, generalNotificationDetails);

    fltrNotification.schedule(indexObat+indexWaktu*130, "Waktunya minum obat!", deskripsi,
        scheduledTime4, generalNotificationDetails);

    fltrNotification.schedule(indexObat+indexWaktu*140, "Waktunya minum obat!", deskripsi,
        scheduledTime5, generalNotificationDetails);

    fltrNotification.schedule(indexObat+indexWaktu*150, "Waktunya minum obat!", deskripsi,
        scheduledTime6, generalNotificationDetails);

    fltrNotification.schedule(indexObat+indexWaktu*160, "Waktunya minum obat!", deskripsi,
        scheduledTime7, generalNotificationDetails);



  }



  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Scaffold(
      backgroundColor: Color(0xff3e3a63),
      body: Column(
        children: [
      Container(
        padding: EdgeInsets.only(top: statusbarHeight),
        height: statusbarHeight + 50,
      child: Center(
        child:Text('Jadwal Minum Obat', style: TextStyle(color: Colors.white, fontSize: 17),),
        ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff3587fc), Color(0xff10c8ff)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    ),
          Container(
            height: MediaQuery.of(context).size.height-106-statusbarHeight,
            child: isLoading? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ) : listJadwalMinum.isEmpty?
            Center(
              child: Text('Data Kosong', style: TextStyle(color: Colors.white, fontSize: 17)),
            )
                : MediaQuery.removePadding(
              removeTop: true,
                  context: context,
                  child: ListView.builder(
                  itemCount: listJadwalMinum.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding:  EdgeInsets.only(top: index==0? 8 : 0),
                      child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailJadwalMinum(listJadwalMinum[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 80,
                            child: Card(
                                elevation: 0,
                                color: Color(0xff434372),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 30,
                                      minHeight: 30,
                                      maxWidth: 30,
                                      maxHeight: 30,
                                    ),
                                    child:Image.asset('assets/images/capsules.png', fit: BoxFit.contain,),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Text(listJadwalMinum[index]['terapi'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
                                  ),
                                  subtitle: Text(listJadwalMinum[index]['dosis'],  style: TextStyle(color: Color(0xffadaad6)),),
                                  trailing: Icon(Icons.chevron_right, color: Color(0xffadaad6)),
                                )
                            ),
                          )
                      ),
                    );
                  }),
                ),
          ),
        ],
      )
    );
  }
}
