import 'package:flutter/material.dart';

class ParameterTouchContainer extends StatefulWidget {
  final Widget child;
  final String parameterName;
  final VoidCallback onTap;
  final Color borderColor;

  const ParameterTouchContainer({
    Key? key,
    required this.child,
    required this.parameterName,
    required this.onTap,
    required this.borderColor,
  }) : super(key: key);

  @override
  State<ParameterTouchContainer> createState() => _ParameterTouchContainerState();
}

class _ParameterTouchContainerState extends State<ParameterTouchContainer> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isSelected = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isSelected = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          isSelected = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.white : widget.borderColor,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.child,
      ),
    );
  }
} 