

import 'dart:async';

import 'package:flutter/material.dart';

///
/// Controller for Count down
///
class TimerController {
  /// Called when called `pause` method
  VoidCallback? onPause;

  /// Called when called `resume` method
  VoidCallback? onResume;

  /// Called when restarting the timer
  VoidCallback? onRestart;

  /// Called when timer is staring
  VoidCallback? onStart;

  ///
  /// Checks if the timer is running and enables you to take actions
  /// according to that. if the timer is still active,
  ///
  /// `isCompleted` returns `false` and vice versa.
  ///
  /// for example:
  ///
  /// ``` dart
  ///   _controller.isCompleted ? _controller.restart() : _controller.pause();
  /// ```
  ///
  bool? isCompleted;

  /// if timer auto start.
  final bool autoStart;

  ///
  /// Constructor
  ///
  TimerController({this.autoStart = false});

  ///
  /// Run timer
  ///
  start() {
    if (onStart != null) {
      onStart!();
    }
  }

  /// Set onStart callback
  setOnStart(VoidCallback onStart) {
    this.onStart = onStart;
  }

  ///
  /// Set timer in pause
  ///
  pause() {
    if (onPause != null) {
      onPause!();
    }
  }

  /// Set onPause callback
  setOnPause(VoidCallback onPause) {
    this.onPause = onPause;
  }

  ///
  /// Resume from pause
  ///
  resume() {
    if (onResume != null) {
      onResume!();
    }
  }

  /// Set onResume callback
  setOnResume(VoidCallback onResume) {
    this.onResume = onResume;
  }

  ///
  /// Restart timer from cold
  ///
  restart() {
    if (onRestart != null) {
      onRestart!();
    }
  }

  /// set onRestart callback
  setOnRestart(VoidCallback onRestart) {
    this.onRestart = onRestart;
  }
}




class TimerWidget extends StatefulWidget {
  /// Length of the timer
  final int seconds;

  /// Build method for the timer
  final Widget Function(BuildContext, double) build;

  /// Called when finished
  final Function? onFinished;

  /// Build interval
  final Duration interval;

  /// Controller
  final TimerController? controller;

  ///
  /// Simple countdown timer
  ///
  const TimerWidget({
    Key? key,
    required this.seconds,
    required this.build,
    this.interval = const Duration(seconds: 1),
    this.onFinished,
    this.controller,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

///
/// State of timer
///
class _TimerWidgetState extends State<TimerWidget> {
  // Multiplier of secconds
  final int _secondsFactor = 1000000;

  // Timer
  Timer? _timer;

  /// Internal control to indicate if the onFinished method was executed
  bool _onFinishedExecuted = false;

  // Current seconds
  late int _currentMicroSeconds;

  @override
  void initState() {
    _currentMicroSeconds = widget.seconds * _secondsFactor;

    widget.controller?.setOnStart(_startTimer);
    widget.controller?.setOnPause(_onTimerPaused);
    widget.controller?.setOnResume(_onTimerResumed);
    widget.controller?.setOnRestart(_onTimerRestart);
    widget.controller?.isCompleted = false;

    if (widget.controller == null || widget.controller!.autoStart == true) {
      _startTimer();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.seconds != widget.seconds) {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    }
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(
      context,
      _currentMicroSeconds / _secondsFactor,
    );
  }

  ///
  /// Then timer paused
  ///
  void _onTimerPaused() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  ///
  /// Then timer resumed
  ///
  void _onTimerResumed() {
    _startTimer();
  }

  ///
  /// Then timer restarted
  ///
  void _onTimerRestart() {
    widget.controller?.isCompleted = false;
    _onFinishedExecuted = false;

    setState(() {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    });

    _startTimer();
  }

  ///
  /// Start timer
  ///
  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer!.cancel();

      widget.controller?.isCompleted = true;
    }

    if (_currentMicroSeconds != 0) {
      _timer = Timer.periodic(
        widget.interval,
            (Timer timer) {
          if (_currentMicroSeconds <= 0) {
            timer.cancel();

            if (widget.onFinished != null) {
              widget.onFinished!();
              _onFinishedExecuted = true;
            }
            widget.controller?.isCompleted = true;
          } else {
            _onFinishedExecuted = false;
            setState(() {
              _currentMicroSeconds =
                  _currentMicroSeconds - widget.interval.inMicroseconds;
            });
          }
        },
      );
    } else if (!_onFinishedExecuted) {
      if (widget.onFinished != null) {
        widget.onFinished!();
        _onFinishedExecuted = true;
      }
      widget.controller?.isCompleted = true;
    }
  }
}