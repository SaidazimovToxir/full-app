import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lesson50/viewmodel/weather_view_model.dart';
import 'package:lesson50/views/screens/course_screen.dart';
import 'package:lesson50/views/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: CourseListScreen(),
    // );
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: CourseListScreen(),
    );
    
  }
}

