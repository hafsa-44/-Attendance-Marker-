// custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  const CustomAppBar({
    required this.title,
    required this.subtitle,

  }); 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 67, 157, 160),
    
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
