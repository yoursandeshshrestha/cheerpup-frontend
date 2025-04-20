// lib/pages/activities_page/widgets/streak_calendar.dart

import 'package:flutter/material.dart';

class StreakCalendar extends StatelessWidget {
  final List<int> streak;
  final DateTime? lastUpdated;
  final int maxDaysToShow;

  const StreakCalendar({
    super.key,
    required this.streak,
    this.lastUpdated,
    this.maxDaysToShow = 7,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysToShow =
        streak.length > maxDaysToShow
            ? streak.sublist(streak.length - maxDaysToShow)
            : streak;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current Streak',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              '${streak.length} ${streak.length == 1 ? 'day' : 'days'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    streak.length > 0
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (streak.isEmpty)
          const Text(
            'No streak yet. Start by marking today as completed!',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        else
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(maxDaysToShow, (index) {
                final daysFromEnd = maxDaysToShow - index - 1;
                final streakIndex = streak.length - daysFromEnd - 1;
                final isActive =
                    streakIndex >= 0 && streakIndex < streak.length;
                final isToday =
                    lastUpdated != null &&
                    _isSameDay(lastUpdated!, DateTime.now()) &&
                    streakIndex == streak.length - 1;

                return _StreakDot(
                  isActive: isActive,
                  isHighlighted: isToday,
                  dayNumber: streakIndex + 1,
                );
              }),
            ),
          ),
      ],
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class _StreakDot extends StatelessWidget {
  final bool isActive;
  final bool isHighlighted;
  final int dayNumber;

  const _StreakDot({
    Key? key,
    required this.isActive,
    required this.isHighlighted,
    required this.dayNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isActive
                    ? (isHighlighted
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.primary)
                    : Colors.grey[300],
            border:
                isHighlighted
                    ? Border.all(color: theme.colorScheme.secondary, width: 2)
                    : null,
          ),
          child:
              isActive
                  ? Center(
                    child: Text(
                      dayNumber.toString(),
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  )
                  : null,
        ),
        const SizedBox(height: 2),
        Text(
          isActive ? 'Day $dayNumber' : '',
          style: TextStyle(
            fontSize: 10,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
