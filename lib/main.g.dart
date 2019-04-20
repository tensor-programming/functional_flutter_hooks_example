// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => myApp();
}

class TimerColumn extends HookWidget {
  const TimerColumn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => timerColumn();
}

class Timer extends StatelessWidget {
  const Timer({Key key, this.timerController}) : super(key: key);

  final AnimationController timerController;

  @override
  Widget build(BuildContext _context) =>
      timer(timerController: timerController);
}

class TimerBuilder extends StatelessWidget {
  const TimerBuilder({Key key, this.timerController}) : super(key: key);

  final AnimationController timerController;

  @override
  Widget build(BuildContext _context) =>
      timerBuilder(timerController: timerController);
}

class TimerText extends StatelessWidget {
  const TimerText({Key key, this.timerController}) : super(key: key);

  final AnimationController timerController;

  @override
  Widget build(BuildContext _context) =>
      timerText(timerController: timerController);
}

class TimerButtons extends HookWidget {
  const TimerButtons({Key key, this.timerController}) : super(key: key);

  final AnimationController timerController;

  @override
  Widget build(BuildContext _context) =>
      timerButtons(timerController: timerController);
}
