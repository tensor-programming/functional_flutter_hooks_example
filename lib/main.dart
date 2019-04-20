import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'main.g.dart';

void main() => runApp(MyApp());

@FunctionalWidget(
  widgetType: FunctionalWidgetType.stateless,
)
Widget myApp() {
  return MaterialApp(
    theme: ThemeData(
      canvasColor: Colors.blueGrey,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      accentColor: Colors.pinkAccent,
      brightness: Brightness.dark,
    ),
    home: Scaffold(
      body: TimerColumn(),
    ),
  );
}

@hwidget
Widget timerColumn() {
  final seconds = useState(0.0);
  final minutes = useState(0.0);

  final timerController = useAnimationController(
      duration: Duration(
    minutes: minutes.value.toInt(),
    seconds: seconds.value.toInt(),
  ));

  return Column(
    children: <Widget>[
      Expanded(
        child: Timer(
          timerController: timerController,
        ),
      ),
      Text('Minutes'),
      Slider(
        value: minutes.value,
        min: 0.0,
        max: 10.0,
        onChanged: (value) {
          if (timerController.isAnimating == false) {
            minutes.value = value;
          }
        },
        divisions: 10,
        label: minutes.value.toString(),
      ),
      Text('Seconds'),
      Slider(
        value: seconds.value,
        min: 0.0,
        max: 60.0,
        onChanged: (value) {
          if (timerController.isAnimating == false) {
            seconds.value = value;
          }
        },
        divisions: 60,
        label: seconds.value.toString(),
      )
    ],
  );
}

@FunctionalWidget(widgetType: FunctionalWidgetType.stateless)
Widget timer({
  AnimationController timerController,
}) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Align(
          alignment: FractionalOffset.center,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: TimerBuilder(timerController: timerController),
                ),
                TimerText(timerController: timerController),
              ],
            ),
          ),
        ),
      ),
      TimerButtons(timerController: timerController),
    ],
  );
}

@FunctionalWidget(widgetType: FunctionalWidgetType.stateless)
Widget timerBuilder({
  AnimationController timerController,
}) {
  return AnimatedBuilder(
    animation: timerController,
    builder: (context, child) {
      return CustomPaint(
        painter: TimerPainter(
          animation: timerController,
          backgroundColor: Colors.white,
          color: Theme.of(context).indicatorColor,
        ),
      );
    },
  );
}

@FunctionalWidget(widgetType: FunctionalWidgetType.stateless)
Widget timerText({
  AnimationController timerController,
}) {
  return Align(
    alignment: FractionalOffset.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Count Down", style: TextStyle(fontSize: 30.0)),
        AnimatedBuilder(
          animation: timerController,
          builder: (context, child) {
            Duration duration =
                timerController.duration * (1.0 - timerController.value);

            return Text(
              timerController.isAnimating == false
                  ? '${timerController.duration.inMinutes}:${(timerController.duration.inSeconds % 60).toString().padLeft(2, '0')}'
                  : '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 30.0),
            );
          },
        ),
      ],
    ),
  );
}

@FunctionalWidget(
  widgetType: FunctionalWidgetType.hook,
)
Widget timerButtons({AnimationController timerController}) {
  final animated = useState(false);
  timerController.addStatusListener((status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      timerController.reset();
      animated.value = false;
    }
  });

  return ButtonBar(
    alignment: MainAxisAlignment.center,
    children: <Widget>[
      MaterialButton(
        color: Colors.deepOrangeAccent,
        onPressed: () {
          if (timerController.isAnimating) {
            timerController.stop();
            animated.value = false;
          } else {
            timerController.forward(
              from: timerController.value == 0.0 ? 1.0 : timerController.value,
            );
            animated.value = true;
          }
        },
        child: Icon(
          animated.value ? Icons.stop : Icons.play_arrow,
        ),
      ),
      MaterialButton(
        onPressed: () {
          if (timerController.isAnimating) {
            timerController
              ..stop(canceled: true)
              ..reset();
            animated.value = false;
          }
        },
        color: Colors.purpleAccent,
        child: Icon(
          Icons.redo,
        ),
      ),
    ],
  );
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
