import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import'tiy.dart';

void main() {
  runApp(const MyApp());
    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:   const Color.fromARGB(255, 67, 157, 160),// Set the status bar color to black
      statusBarBrightness: Brightness.dark, // Set brightness of the status bar (light icons on dark background)
      statusBarIconBrightness: Brightness.dark, // Light icons for better contrast against dark status bar
    ),
  );

}


