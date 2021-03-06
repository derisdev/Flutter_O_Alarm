import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:oalarm/widget/clock_alarm.dart';

class DetailAdminJadwalMinum extends StatefulWidget {
  final dynamic jamMinum;

  DetailAdminJadwalMinum(this.jamMinum);
  @override
  _DetailAdminJadwalMinumState createState() => _DetailAdminJadwalMinumState();
}

class _DetailAdminJadwalMinumState extends State<DetailAdminJadwalMinum> {

  final PageController controller = new PageController();

  List<String> listJam;

  String time1;
  String time2;
  String time3;

  @override
  void initState() {
    splitData();
    super.initState();
  }


  splitData(){
    listJam = widget.jamMinum['jadwalminum'].split(',');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3e3a63),
      body: PageIndicatorContainer(
        child: PageView.builder(
          itemCount: listJam.length,
          itemBuilder: (context, index){
            return PageViewPlayer(
                time: listJam[index],
                jadwalMinum: widget.jamMinum
            );
          },
          controller: controller,
        ),
        length: listJam.length,
        align: IndicatorAlign.bottom,
        indicatorSpace: 20.0,
        padding: const EdgeInsets.all(10),
        indicatorColor: Colors.white,
        indicatorSelectorColor: Color(listJam.length==1? 0xff3e3a63 : 0xff3587fc),
        shape: IndicatorShape.circle(size: listJam.length==1? 0: 8),
      ),
    );
  }
}
