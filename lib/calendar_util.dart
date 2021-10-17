enum TimePoint { past, present, tomorrow, future }

class CalendarUtil {
  static final List<String> kr_week = ['일', '월', '화', '수', '목', '금', '토'];
  static final List<String> en_week = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat'
  ];

  static List<int> dayListForMonth(int year, int month) {
    int shift = DateTime.utc(year, month, 1).weekday % 7;
    int daysInMonth = daysCount(year, month);
    List<int> ret = List.generate(shift, (index) => -1);
    List<int> _day = List.generate(daysInMonth, (index) => index + 1);
    ret.addAll(_day);
    return ret;
  }

  static bool isIncludeToday(int year, int month) {
    DateTime now = DateTime.now();
    if (now.year == year && now.month == month) {
      return true;
    }
    return false;
  }

  static TimePoint decidePastPresentFuture(int year, int month, int day) {
    if (thisYear() < year) {
      return TimePoint.future;
    } else if (thisYear() > year) {
      return TimePoint.past;
    } else {
      if (thisMonth() < month) {
        return TimePoint.future;
      } else if (thisMonth() > month) {
        return TimePoint.past;
      } else {
        if (thisDay() < day) {
          if (thisDay() + 1 == day) {
            return TimePoint.tomorrow;
          } else {
            return TimePoint.future;
          }
        } else if (thisDay() > day) {
          return TimePoint.past;
        } else {
          return TimePoint.present;
        }
      }
    }
  }

  static TimePoint decidePastPresentFutureWithDate(String date) {
    List<int> temp = date.split('-').map((e) => int.parse(e)).toList();
    return decidePastPresentFuture(temp[0], temp[1], temp[2]);
  }

  static int thisYear() {
    return DateTime.now().year;
  }

  static int thisMonth() {
    return DateTime.now().month;
  }

  static int thisDay() {
    return DateTime.now().day;
  }

  static int daysCount(int year, int month) {
    List<int> monthLength = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (isLeapYear(year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[month - 1];
  }

  static bool isLeapYear(int year) {
    bool isLeap = false;
    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      isLeap = false;
    } else if (year % 4 == 0) {
      isLeap = true;
    }

    return isLeap;
  }
}
