import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:oalarm/widget/clock_alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DetailJadwalMinum extends StatefulWidget {
  final String jamMinum;
  DetailJadwalMinum(this.jamMinum);
  @override
  _DetailJadwalMinumState createState() => _DetailJadwalMinumState();
}

class _DetailJadwalMinumState extends State<DetailJadwalMinum> {

  final PageController controller = new PageController();

  String time1;
  String time2;
  String time3;

  @override
  void initState() {
    splitData();
    super.initState();
  }


  splitData(){
    List<String> listJam = widget.jamMinum.split(',');
    print(listJam.toString());
    time1 = listJam.first;
    time2 = listJam[1];
    time3 = listJam.last;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageIndicatorContainer(
        child: PageView(
          children: <Widget>[
            PageViewPlayer(
              time: time1,
            ),
            PageViewPlayer(
              time: time2,
            ),
            PageViewPlayer(
              time: time3,
            )
          ],
          controller: controller,
        ),
        align: IndicatorAlign.bottom,
        length: 3,
        indicatorSpace: 20.0,
        padding: const EdgeInsets.all(10),
        indicatorColor: Colors.white,
        indicatorSelectorColor: Color(0xffec2f82),
        shape: IndicatorShape.circle(size: 8),
      ),
    );
  }
}
