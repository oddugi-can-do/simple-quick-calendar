import 'package:flutter/material.dart';

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
