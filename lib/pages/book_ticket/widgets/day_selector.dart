import 'package:flutter/material.dart';
import 'package:flutter_movies/widgets/scaleup_animation.dart';
import 'package:flutter_movies/widgets/translate_animation.dart';

class DateDaySelector extends StatefulWidget {
  const DateDaySelector({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<DateTime> onChanged;

  @override
  State<DateDaySelector> createState() => _DateDaySelectorState();
}

class _DateDaySelectorState extends State<DateDaySelector> {
  late PageController _pageController;
  late DateTime _current;
  int _page = 0;
  @override
  void initState() {
    super.initState();
    _current = DateTime.now();
    _page = _current.day - 1;
    _pageController = PageController(initialPage: _page.toInt(), viewportFraction: .23);
  }

  void _onPageChange(int index) {
    if (_page != index) {
      _current = _current.add(Duration(days: index.toInt() - _current.day));
      widget.onChanged(_current);
      setState(() {
        _page = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var firstDay = DateTime(_current.year, _current.month, 0);
    int daysInMonth = DateTime(_current.year, _current.month + 1, 0).day;

    return SizedBox(
      height: 130,
      child: TranslateRightAnimation(
        child: ScaleUpAnimation(
          child: ShadowedBox(
            child: PageView(
              onPageChanged: (value) => _onPageChange(value),
              controller: _pageController,
              children: List.generate(
                daysInMonth,
                (index) {
                  firstDay = firstDay.add(const Duration(days: 1));
                  final isSelected = index == _page;
                  final angle = isSelected
                      ? 0.0
                      : index > _page
                          ? index.isOdd
                              ? .18
                              : -.18
                          : index.isOdd
                              ? -.18
                              : .18;
                  return Transform.rotate(
                    angle: angle,
                    child: DayCard(
                      dateTime: firstDay,
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShadowedBox extends StatelessWidget {
  const ShadowedBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [
                  .01,
                  .5,
                  .99,
                ],
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0),
                  Colors.black,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required this.dateTime,
    required this.isSelected,
  });

  final DateTime dateTime;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Colors.black : Colors.white70;
    return Center(
      child: SizedBox(
        width: 82,
        height: 100,
        child: Stack(
          children: [
            Positioned(
              left: 6,
              child: Container(
                width: 70,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isSelected ? [Colors.yellow, Colors.orange] : [Colors.white30, Colors.white30],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      getDayOfWeek(dateTime.weekday).substring(0, 2),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      dateTime.day.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 10,
              child: Column(
                children: [
                  CircleAvatar(radius: 6, backgroundColor: Colors.black),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(radius: 6, backgroundColor: Colors.black),
                      CircleAvatar(radius: 6, backgroundColor: Colors.black),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "Invalid weekday";
  }
}
