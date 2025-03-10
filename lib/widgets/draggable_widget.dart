import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Widget child;

  const DraggableWidget({
    super.key,
    required this.child,
  });

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  double xPosition = 0;
  double yPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xPosition,
      top: yPosition,
      child: Draggable(
        feedback: widget.child,
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: widget.child,
        ),
        onDragEnd: (details) {
          setState(() {
            xPosition = details.offset.dx;
            yPosition = details.offset.dy;
          });
        },
        child: widget.child,
      ),
    );
  }
} 