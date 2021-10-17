
# simple-quick-calendar

A calendar widget with simple look-like and quickly-started.


## Platform Support

| Android |
| :-----: |
|   ✔️    |


## Getting Started

First, import simple_quick_calendar package in your source.
```dart
import 'package:simple_quick_calendar/simple_quick_calendar.dart';
```

And just put SimpleQuickCalendar widget with year and month.
```dart
SimpleQuickCalendar(initYear: 2021, initMonth: 10)
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:simple_quick_calendar/simple_quick_calendar.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarPage(title: 'simple calendar demo'),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int year = 0, month = 0;

  @override
  void initState() {
    year = 2021;
    month = 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleQuickCalendar(initYear: year, initMonth: month),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Screen Shot

![sample_screen](https://user-images.githubusercontent.com/19565940/137628599-2ea31de5-aebe-4ab6-ba79-41612b35987c.png)