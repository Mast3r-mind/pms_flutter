import 'package:flutter/material.dart';
import 'menus/home_menu.dart';

class BottomMenuComponent extends StatefulWidget {
  const BottomMenuComponent({Key? key}) : super(key: key);

  @override
  State<BottomMenuComponent> createState() => _BottomMenuComponentState();
}

class _BottomMenuComponentState extends State<BottomMenuComponent> {
  bool _isExpanded = false;
  bool _isPressed = false;
  OverlayEntry? _overlayEntry;

  void _toggleMenu(BuildContext context) {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _overlayEntry = OverlayEntry(
        builder: (context) => const HomeMenu(),
      );
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 25,
      decoration: BoxDecoration(
        color: const Color(0xFF343434),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF000000),
          width: 1,
        ),
      ),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _toggleMenu(context);
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: Icon(
          _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
          color: const Color(0xFFFFFFFF),
          size: 20,
        ),
      ),
    );
  }
} 