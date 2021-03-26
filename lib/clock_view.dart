import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  void initState() {
    // TODO: implement initState

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter{
  var dataTime = DateTime.now();


  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX,centerY);
    
    var fillBrush = Paint()
    ..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 16;

    var centerFillBrush = Paint()
      ..color = Color(0xFFEAECFF);

    var secHandBrush =  Paint()
      ..color = Colors.orange[300]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    var minHandBrush =  Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)]).createShader(Rect.fromCircle(center: center, radius: radius),)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var hourHandBrush =  Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)]).createShader(Rect.fromCircle(center: center, radius: radius),)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    
    canvas.drawCircle(center, radius-40, fillBrush);
    canvas.drawCircle(center, radius-40, outlineBrush);

    var hourHandX = centerX + 60 * cos((dataTime.hour * 30 + dataTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX + 60 * sin((dataTime.hour * 30 + dataTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX,hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dataTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dataTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX,minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dataTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dataTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX,secHandY), secHandBrush);


    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadies = radius;
    var innerCircleRadies = radius -14;
    for(double i = 0; i<360; i +=6){
      var x1 = centerX + outerCircleRadies * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadies * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadies * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadies * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) { 
    return true;
  }
}
