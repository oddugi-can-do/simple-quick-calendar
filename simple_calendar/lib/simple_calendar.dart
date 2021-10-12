import 'package:flutter/material.dart';
import 'calendar_util.dart';

class SimpleCalendar extends StatefulWidget {
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

  const SimpleCalendar({
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
  _SimpleCalendarState createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
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

class CalendarDayButtonWidget extends StatelessWidget {
  final int day;
  String get text => '$day';
  bool isEnabled;
  bool isHighlighted;
  int selectedDay;
  final void Function(int)? onSelectDay;
  final TextStyle dayTextStyle;
  final double buttonPadding;
  final ButtonStyle? style;
  final ButtonStyle? selectedStyle;

  CalendarDayButtonWidget(
      {Key? key,
      required this.day,
      required this.selectedDay,
      required this.onSelectDay,
      required this.dayTextStyle,
      required this.buttonPadding,
      this.style,
      this.selectedStyle})
      : isEnabled = true,
        isHighlighted = false,
        super(key: key);
  CalendarDayButtonWidget.disabled({
    Key? key,
  })  : day = 0,
        isEnabled = false,
        isHighlighted = false,
        onSelectDay = null,
        selectedDay = 0,
        buttonPadding = 0,
        dayTextStyle = const TextStyle(),
        selectedStyle = null,
        style = null,
        super(key: key);
  CalendarDayButtonWidget.highlighted(
      {Key? key,
      required this.day,
      required this.selectedDay,
      required this.onSelectDay,
      required this.dayTextStyle,
      required this.buttonPadding,
      this.style,
      this.selectedStyle})
      : isEnabled = true,
        isHighlighted = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.040;
    return Padding(
      padding: EdgeInsets.all(buttonPadding),
      child: isEnabled
          ? isHighlighted
              ? _highlightedContainerBuilder(fontSize, onSelectDay!)
              : _enabledContainerBuilder(fontSize, onSelectDay!)
          : _disabledContainerBuilder(),
    );
  }

  Widget _enabledContainerBuilder(
      double fontSize, void Function(int) onSelectDay) {
    return day == selectedDay
        ? ElevatedButton(
            onPressed: () {
              onSelectDay(day);
            },
            child: _calendarTextWidget(fontSize),
            style: selectedButtonStyle(),
          )
        : ElevatedButton(
            onPressed: () {
              onSelectDay(day);
            },
            child: _calendarTextWidget(fontSize),
            style: unselectedButtonStyle(),
          );
  }

  Widget _highlightedContainerBuilder(
      double fontSize, void Function(int) onSelectDay) {
    return day == selectedDay
        ? ElevatedButton(
            onPressed: () {
              onSelectDay(day);
            },
            child: _calendarTextWidget(fontSize),
            style: selectedButtonStyle(),
          )
        : ElevatedButton(
            onPressed: () {
              onSelectDay(day);
            },
            child: _calendarTextWidget(fontSize),
            style: highlightedButtonStyle(),
          );
  }

  Widget _disabledContainerBuilder() {
    return Container();
  }

  Widget _calendarTextWidget(double fontSize) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        text,
        style: dayTextStyle,
      ),
    );
  }

  ButtonStyle selectedButtonStyle() {
    return selectedStyle ??
        ElevatedButton.styleFrom(
          onSurface: Colors.transparent,
          onPrimary: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shadowColor: Colors.transparent,
          shape: CircleBorder(),
          primary: Colors.brown, // brown
        );
  }

  ButtonStyle unselectedButtonStyle() {
    return style ??
        ElevatedButton.styleFrom(
          onSurface: Colors.transparent,
          onPrimary: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shadowColor: Colors.transparent,
          shape: CircleBorder(),
          primary: Colors.transparent,
        );
  }

  ButtonStyle highlightedButtonStyle() {
    return ElevatedButton.styleFrom(
      onSurface: Colors.transparent,
      onPrimary: Colors.transparent,
      padding: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      shape: CircleBorder(),
      primary: Colors.grey,
    );
  }
}
