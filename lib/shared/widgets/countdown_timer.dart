import 'package:flutter/material.dart';
import 'dart:async';

/// CountdownTimer: StatefulWidget example for appointment countdown.
class CountdownTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback? onFinished;
  const CountdownTimer({Key? key, required this.seconds, this.onFinished})
      : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining > 0) {
        setState(() => _remaining--);
      } else {
        timer.cancel();
        widget.onFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_remaining s',
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
