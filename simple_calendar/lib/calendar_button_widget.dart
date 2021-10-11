import 'package:flutter/material.dart';

class CalendarDayButtonWidget extends StatelessWidget {
  final int day;
  String get text => '$day';
  bool isEnabled;
  bool isHighlighted;
  int selectedDay;
  final void Function(int)? onSelectDay;
  CalendarDayButtonWidget(
      {Key? key,
      required this.day,
      required this.selectedDay,
      required this.onSelectDay})
      : isEnabled = true,
        isHighlighted = false,
        super(key: key);
  CalendarDayButtonWidget.disabled({Key? key})
      : day = 0,
        isEnabled = false,
        isHighlighted = false,
        onSelectDay = null,
        this.selectedDay = 0,
        super(key: key);
  CalendarDayButtonWidget.highlighted(
      {Key? key,
      required this.day,
      required this.selectedDay,
      required this.onSelectDay})
      : isEnabled = true,
        isHighlighted = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.040;
    return Padding(
      padding: const EdgeInsets.all(2),
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
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }

  ButtonStyle selectedButtonStyle() {
    return ElevatedButton.styleFrom(
      onSurface: Colors.transparent,
      onPrimary: Colors.transparent,
      padding: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      shape: CircleBorder(),
      primary: Colors.brown,
    );
  }

  ButtonStyle unselectedButtonStyle() {
    return ElevatedButton.styleFrom(
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
      primary: Colors.green,
    );
  }
}
