import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oalarm/homepage.dart';
import 'package:oalarm/service/fetchJadwalMinum.dart';
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
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (context) => HomePage()),
    );
  }

  Future _showNotification(String deskripsi, int jam, int menit, int indexObat, int indexWaktu) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "OAlarm", "This is notif alarm",
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Minum Obat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: listJadwalMinum.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailJadwalMinum(listJadwalMinum[index]['jadwalminum'])));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(listJadwalMinum[index]['terapi']),
                      subtitle: Text(listJadwalMinum[index]['dosis']),
                      trailing: Icon(Icons.chevron_right),
                    )
                ),
              )
            );
          }),
    );
  }
}
