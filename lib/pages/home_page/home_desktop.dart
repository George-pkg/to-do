import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/components/button_widget.dart';
import 'package:pomodoro/components/gradient_background.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({super.key});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void resetTimer() => setState(() => seconds = maxSeconds);

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() {
      timer?.cancel();
      timer = null;
    });
  }

  void restartTimer() {
    stopTimer(reset: false);
    setState(() {
      timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
        if (seconds < maxSeconds) {
          setState(() {
            seconds++;
          });
        } else {
          stopTimer(reset: true); // Para o timer quando alcançar o valor máximo novamente
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        gradientBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimer(),
                const SizedBox(height: 80),
                buildButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonWidget(
                  text: isRunning ? 'Pausar' : 'Continuar',
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(reset: false);
                    } else {
                      startTimer(reset: false);
                    }
                  }),
              const SizedBox(width: 20),
              buttonWidget(
                  text: 'Resetar',
                  onPressed: () {
                    restartTimer();
                  }),
            ],
          )
        : buttonWidget(
            text: 'Start Timer',
            onPressed: () {
              startTimer();
            });
  }

  Widget buildTimer() => SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.green[700],
              strokeWidth: 12,
            ),
            Center(child: buildTime()),
          ],
        ),
      );

  Widget buildTime() {
    return Text(
      '$seconds',
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 80),
    );
  }
}
