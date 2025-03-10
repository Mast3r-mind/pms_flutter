import 'package:flutter/material.dart';

class DraggableParameter extends StatefulWidget {
  final Widget child;
  final String parameterType;
  final Function(Offset) onPositionChanged;
  final Offset initialPosition;

  const DraggableParameter({
    Key? key,
    required this.child,
    required this.parameterType,
    required this.onPositionChanged,
    required this.initialPosition,
  }) : super(key: key);

  @override
  State<DraggableParameter> createState() => _DraggableParameterState();
}

class _DraggableParameterState extends State<DraggableParameter> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable<String>(
        data: widget.parameterType,
        feedback: Material(
          color: Colors.transparent,
          child: Opacity(
            opacity: 0.7,
            child: widget.child,
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: widget.child,
        ),
        onDragEnd: (details) {
          setState(() {
            // Update position based on drop point
            position = Offset(
              position.dx + details.offset.dx,
              position.dy + details.offset.dy,
            );
            // Notify parent of position change
            widget.onPositionChanged(position);
          });
        },
        child: widget.child,
      ),
    );
  }
} 