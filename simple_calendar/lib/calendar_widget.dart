import 'package:flutter/material.dart';

import 'calendar_button_widget.dart';
import 'calendar_util.dart';

class CalendarWidget extends StatefulWidget {
  final int initYear;
  final int initMonth;
  final int initDay;

  const CalendarWidget(
      {Key? key, required this.initYear, required this.initMonth, this.initDay = 1})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<int> _dayListForMonth = [];
  int year = 0;
  int month = 0;
  int selectedDay = 0;

  @override
  void initState() {
    super.initState();
    year = widget.initYear;
    month = widget.initMonth;
    selectedDay = widget.initDay;
  }

  @override
  Widget build(BuildContext context) {
    double _fontSize = MediaQuery.of(context).size.width * 0.035;
    _dayListForMonth = CalendarUtil.dayListForMonth(year, month);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        key: UniqueKey(),
        itemCount: 7 + _dayListForMonth.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
          mainAxisSpacing: 2, //수평 Padding
          crossAxisSpacing: 2, //수직 Padding
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index < 7) {
            return Center(
              child: Text(
                CalendarUtil.week[index],
                style: TextStyle(fontSize: _fontSize, color: Colors.white),
              ),
            );
          }
          if (_dayListForMonth[index - 7] == -1) {
            return CalendarDayButtonWidget.disabled();
          } else if (CalendarUtil.isIncludeToday(year, month) &&
              _dayListForMonth[index - 7] == CalendarUtil.thisDay()) {
            return CalendarDayButtonWidget.highlighted(
              key: UniqueKey(),
              day: _dayListForMonth[index - 7],
              onSelectDay: onSelectDay,
              selectedDay: selectedDay,
            );
          } else {
            return CalendarDayButtonWidget(
              key: UniqueKey(),
              day: _dayListForMonth[index - 7],
              onSelectDay: onSelectDay,
              selectedDay: selectedDay,
            );
          }
        },
      ),
    );
  }

  void onSelectMonth(int _year, int _month) {
    setState(() {
      year = _year;
      month = _month;
    });
  }

  void onSelectDay(int _day) {
    setState(() {
      selectedDay = _day;
    });
  }
}
