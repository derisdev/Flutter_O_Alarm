import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:oalarm/widget/clock_alarm.dart';

class DetailAdminJadwalMinum extends StatefulWidget {
  final String jadwalMinum;
  DetailAdminJadwalMinum(this.jadwalMinum);
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
        child: PageView.builder(
          itemCount:  widget.jadwalMinum.split(',').length,
          itemBuilder: (context, index){
            return  PageViewPlayer(
              time: widget.jadwalMinum.split(',')[index],
            );
          },
          controller: controller,
        ),
        align: IndicatorAlign.bottom,
        length:  widget.jadwalMinum.split(',').length,
        indicatorSpace: 20.0,
        padding: const EdgeInsets.all(10),
        indicatorColor: Colors.white,
        indicatorSelectorColor: Color(0xffec2f82),
        shape: IndicatorShape.circle(size: 8),
      ),
    );
  }
}
