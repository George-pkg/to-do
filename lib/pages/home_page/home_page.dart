import 'package:flutter/material.dart';
import 'package:pomodoro/pages/home_page/home_desktop.dart';
import 'package:pomodoro/pages/home_page/home_mobile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 700) {
        return const HomeMobile();
      } else {
        return const HomeDesktop();
      }
    });
  }
}
