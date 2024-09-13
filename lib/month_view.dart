import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/day_number.dart';
import 'package:scrolling_years_calendar/month_title.dart';
import 'package:scrolling_years_calendar/utils/dates.dart';
import 'package:scrolling_years_calendar/utils/screen_sizes.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    required this.context,
    required this.year,
    required this.month,
    required this.padding,
    required this.currentDateColor,
    required this.monthNames,
    required this.onTap,
    required this.titleStyle,
    required this.daysColor,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final Color currentDateColor;
  final List<String> monthNames;
  final Function? onTap;
  final TextStyle titleStyle;
  final Color daysColor;

  Color? getDayNumberColor(DateTime date) {
    Color? color;
    if (isCurrentDate(date)) {
      color = currentDateColor;
    }
    return color;
  }

  Widget buildMonthDays(BuildContext context) {
    final List<Row> dayRows = <Row>[];
    final List<DayNumber> dayRowChildren = <DayNumber>[];

    final int daysInMonth = getDaysInMonth(year, month);
    final int firstWeekdayOfMonth = DateTime(year, month, 1).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      Color color = Colors.transparent;
      bool isToday = false;
      if (day > 0) {
        color =
            getDayNumberColor(DateTime(year, month, day)) ?? Colors.transparent;
        isToday = true;
      }

      dayRowChildren.add(
        DayNumber(
          day: day,
          color: color,
          isToday: isToday,
          daysColor: daysColor,
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return Container(
      width: 7 * getDayNumberSize(context),
      margin: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MonthTitle(
            month: month,
            monthNames: monthNames,
            style: titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: buildMonthDays(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: buildMonthView(context));
  }
}
