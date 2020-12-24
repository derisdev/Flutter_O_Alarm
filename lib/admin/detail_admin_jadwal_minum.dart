import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:oalarm/widget/clock_alarm.dart';

class DetailAdminJadwalMinum extends StatefulWidget {
  @override
  _DetailAdminJadwalMinumMinumState createState() => _DetailAdminJadwalMinumMinumState();
}

class _DetailAdminJadwalMinumMinumState extends State<DetailAdminJadwalMinum> {

  final PageController controller = new PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageIndicatorContainer(
        child: PageView(
          children: <Widget>[
            PageViewPlayer(
              time: '21.00',
            ),
            PageViewPlayer(
              time: '12.00',
            ),
            PageViewPlayer(
              time: '07.00',
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
