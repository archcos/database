import 'package:ass2/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Assignment 2",
    theme: ThemeData(
        primarySwatch: Colors.teal
    ),
    home: const HomePage(),
  ));
}
