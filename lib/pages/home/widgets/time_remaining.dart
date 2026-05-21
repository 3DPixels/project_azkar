import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeRemaining extends StatefulWidget {
  final DateTime? targetTime;

  const TimeRemaining({super.key, this.targetTime});

  @override
  State<TimeRemaining> createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  Timer? _timer;
  Duration _duration = Duration.zero;

  static final NumberFormat _arabicTwoDigits = NumberFormat("00", "ar_EG");

  @override
  void initState() {
    super.initState();
    _updateDuration();
    if (widget.targetTime != null) {
      _startTimer();
    }
  }

  // 1. Listens for when the API finally passes data to the widget
  @override
  void didUpdateWidget(TimeRemaining oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetTime != oldWidget.targetTime) {
      _updateDuration();
      // If we just got a valid time and no timer is running, start it
      if (widget.targetTime != null && _timer == null) {
        _startTimer();
      }
    }
  }

  void _updateDuration() {
    // Handle the null case explicitly
    if (widget.targetTime == null) {
      _duration = Duration.zero;
      return;
    }

    final now = DateTime.now();
    if (widget.targetTime!.isAfter(now)) {
      _duration = widget.targetTime!.difference(now);
    } else {
      _duration = Duration.zero;
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _updateDuration();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDurationToArabic(Duration duration) {
    if (duration.inSeconds <= 0) return "٠٠:٠٠:٠٠";

    String hours = _arabicTwoDigits.format(duration.inHours);
    String minutes = _arabicTwoDigits.format(duration.inMinutes.remainder(60));
    String seconds = _arabicTwoDigits.format(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.1),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        spacing: 5,
        // Ensures the column only takes up as much space as it needs
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'باقي على الأذان',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white54),
          ),
          Text(
            widget.targetTime == null
                ? "--:--:--"
                : _formatDurationToArabic(_duration),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
