import 'package:flutter/material.dart';

class WifiStatusComponent extends StatefulWidget {
  const WifiStatusComponent({Key? key}) : super(key: key);

  @override
  State<WifiStatusComponent> createState() => _WifiStatusComponentState();
}

class _WifiStatusComponentState extends State<WifiStatusComponent> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        // Add your onTap functionality here
        print('WiFi icon pressed');
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: 45,
        height: 36,
        child: Icon(
          Icons.wifi,
          color: _isPressed ? const Color(0xFF00FD0C) : Colors.white,  // Changes color when pressed
          size: 36,
        ),
      ),
    );
  }
} 