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

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => app();
}

class DragBox extends HookWidget {
  const DragBox(this.initPos, this.label, this.itemColor, {Key key})
      : super(key: key);

  final Offset initPos;

  final String label;

  final Color itemColor;

  @override
  Widget build(BuildContext _context) => dragBox(initPos, label, itemColor);
}
