import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: const Color(0xFF343434)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem('Control Panel', Icons.dashboard, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/control_panel');
            }),
            const Divider(color: Color(0xFF343434), height: 1),
            _buildMenuItem('Settings', Icons.settings, () {
              Navigator.pop(context);
              // Add settings navigation
            }),
            const Divider(color: Color(0xFF343434), height: 1),
            _buildMenuItem('About', Icons.info, () {
              Navigator.pop(context);
              // Add about navigation
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 