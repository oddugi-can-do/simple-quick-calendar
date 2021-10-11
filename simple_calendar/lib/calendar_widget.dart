import 'package:flutter/material.dart';

import 'calendar_button_widget.dart';
import 'calendar_util.dart';

class CalendarWidget extends StatefulWidget {
  final int initYear;
  final int initMonth;
  final int initDay;
  final TextStyle? weekTextStyle;
  final TextStyle? dayTextStyle;
  final ButtonStyle? selectedStyle;
  final ButtonStyle? enabledStyle;
  final ButtonStyle? highlightedStyle;
  final double buttonPadding;
  final double horizontalPadding;
  final double verticalPadding;
  final double itemAspectRatio;
  // final Locale? locale;

  const CalendarWidget({
    Key? key,
    required this.initYear,
    required this.initMonth,
    this.initDay = 1,
    this.weekTextStyle,
    this.dayTextStyle,
    this.selectedStyle,
    this.enabledStyle,
    this.highlightedStyle,
    this.buttonPadding = 2,
    this.horizontalPadding = 2,
    this.verticalPadding = 2,
    this.itemAspectRatio = 1 / 1,
  }) : super(key: key);

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
    return GridView.builder(
      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      key: UniqueKey(),
      itemCount: 7 + _dayListForMonth.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, //1 개의 행에 보여줄 item 개수
        childAspectRatio: widget.itemAspectRatio, //item 의 가로 1, 세로 1 의 비율
        mainAxisSpacing: widget.horizontalPadding, //수평 Padding
        crossAxisSpacing: widget.verticalPadding, //수직 Padding
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (index < 7) {
          return Center(
            child: Text(
              CalendarUtil.week[index],
              style: widget.weekTextStyle ??
                  TextStyle(fontSize: _fontSize, color: Colors.white),
            ),
          );
        }
        if (_dayListForMonth[index - 7] == -1) {
          return CalendarDayButtonWidget.disabled();
        } else if (CalendarUtil.isIncludeToday(year, month) &&
            _dayListForMonth[index - 7] == CalendarUtil.thisDay()) {
          return CalendarDayButtonWidget.highlighted(
            dayTextStyle: widget.dayTextStyle ??
                TextStyle(fontSize: _fontSize, color: Colors.black),
            key: UniqueKey(),
            day: _dayListForMonth[index - 7],
            onSelectDay: onSelectDay,
            selectedDay: selectedDay,
            buttonPadding: widget.buttonPadding,
            style: widget.highlightedStyle,
            selectedStyle: widget.selectedStyle,
          );
        } else {
          return CalendarDayButtonWidget(
            dayTextStyle: widget.dayTextStyle ??
                TextStyle(fontSize: _fontSize, color: Colors.black),
            key: UniqueKey(),
            day: _dayListForMonth[index - 7],
            onSelectDay: onSelectDay,
            selectedDay: selectedDay,
            buttonPadding: widget.buttonPadding,
            style: widget.enabledStyle,
            selectedStyle: widget.selectedStyle,
          );
        }
      },
    );
  }

  void onSelectDay(int _day) {
    setState(() {
      selectedDay = _day;
    });
  }
}
