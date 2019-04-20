import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'draggable.g.dart';

void main() => runApp(MyApp());

@FunctionalWidget(widgetType: FunctionalWidgetType.stateless)
Widget myApp() {
  return MaterialApp(
    home: Scaffold(
      body: App(),
    ),
  );
}

@hwidget
Widget app() {
  final caughtColor = useState(Colors.white);
  return Stack(
    children: <Widget>[
      DragBox(Offset(0.0, 0.0), 'Box One', Colors.blue),
      DragBox(Offset(150.0, 0.0), 'Box two', Colors.orange),
      DragBox(Offset(300.0, 0.0), 'Box three', Colors.lightGreen),
      Positioned(
        left: 100.0,
        bottom: 0.0,
        child: DragTarget(
          onAccept: (Color color) {
            caughtColor.value = color;
          },
          builder: (context, accept, rejected) {
            return Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                color:
                    accept.isEmpty ? caughtColor.value : Colors.grey.shade100,
              ),
              child: Center(
                child: Text("Drag Here"),
              ),
            );
          },
        ),
      )
    ],
  );
}

@hwidget
Widget dragBox(Offset initPos, String label, Color itemColor) {
  final position = useState(initPos);
  return Positioned(
    left: position.value.dx,
    top: position.value.dy,
    child: Draggable(
      data: itemColor,
      child: Container(
        width: 100.0,
        height: 100.0,
        color: itemColor,
        child: Center(
          child: Text(label),
        ),
      ),
      onDraggableCanceled: (velocity, offset) {
        position.value = offset;
      },
      feedback: Material(
        child: Container(
          width: 120.0,
          height: 120.0,
          color: itemColor.withOpacity(0.5),
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    ),
  );
}
