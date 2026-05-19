import 'package:flutter/material.dart';
import 'dart:async';

class TimeRemaining extends StatefulWidget {
  const TimeRemaining({super.key});

  @override
  State<TimeRemaining> createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  late Timer _timer;
  // Initial duration: 1 hour and 3 minutes
  Duration _duration = const Duration(hours: 1, minutes: 3);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final seconds = _duration.inSeconds - 1;
        if (seconds < 0) {
          _timer.cancel();
        } else {
          _duration = Duration(seconds: seconds);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    // If duration is 0 or less, show 00:00:00
    if (duration.inSeconds <= 0) return "00:00:00";

    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.1),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        spacing: 5,
        children: [
          Text(
            'باقي على الأذان',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white54),
          ),
          Text(
            _formatDuration(_duration),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
