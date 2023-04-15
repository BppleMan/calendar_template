import 'package:flutter/material.dart';

enum WeekLanguage { english, chinese }

final List<String> weekString = ["一", "二", "三", "四", "五", "六", "日"];

class CalendarRenderModel {
  late DateTime _date;

  double _width = 375;
  late double _height;
  double radius;

  Color primaryColor;
  WeekLanguage weekLanguage;
  late int _firstDay;
  late int _daysInMonth;

  late List<List<DateTime?>> _calendar;
  late List<String> weekNames;
  RangeValues? range;

  CalendarRenderModel({
    required DateTime date,
    double width = 375,
    this.radius = 20,
    this.primaryColor = const Color(0xFF007DFA),
    this.weekLanguage = WeekLanguage.chinese,
    int firstDay = 7,
    List<List<String?>> data = const [],
    this.range,
  }) {
    _date = date;
    _width = width;
    _daysInMonth = DateUtils.getDaysInMonth(_date.year, _date.month);
    _firstDay = firstDay;
    weekNames = getWeekNames();
    _calendar = getCalendar();
    _height = (_width - 32) / 7 * _calendar.length;
  }

  // int get year => _year;
  //
  // set year(int value) {
  //   _year = value;
  //   _daysInMonth = DateUtils.getDaysInMonth(_year, _month);
  //   data = getCalendar();
  // }
  //
  // int get month => _month;
  //
  // set month(int value) {
  //   _month = value;
  //   _daysInMonth = DateUtils.getDaysInMonth(_year, _month);
  //   data = getCalendar();
  // }

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
    _daysInMonth = DateUtils.getDaysInMonth(_date.year, _date.month);
    calendar = getCalendar();
  }

  double get width => _width;

  set width(double value) {
    _width = value;
    _height = getHeight();
  }

  double get height => _height;

  int get firstDay => _firstDay;

  set firstDay(int value) {
    _firstDay = value;
    weekNames = getWeekNames();
    calendar = getCalendar();
  }

  List<List<DateTime?>> get calendar => _calendar;

  set calendar(List<List<DateTime?>> value) {
    _calendar = value;
    _height = getHeight();
  }

  double getHeight() {
    return (_width - 32) / 7 * _calendar.length;
  }

  List<List<DateTime?>> getCalendar() {
    List<List<DateTime?>> calendar = [];
    List<DateTime?> oneWeek = [];
    for (int i = 1; i <= _daysInMonth; i++) {
      var weekday = DateTime(_date.year, _date.month, i).weekday;
      if (i == 1) {
        oneWeek.addAll(List.filled((weekday + 7 - _firstDay) % 7, null));
      }
      oneWeek.add(DateTime(_date.year, _date.month, i));
      if (weekday == (_firstDay - 1 == 0 ? 7 : _firstDay - 1) || i == _daysInMonth) {
        if (oneWeek.length < 7) {
          oneWeek.addAll(List.generate(7 - oneWeek.length, (index) => null));
        }
        calendar.add(oneWeek);
        oneWeek = [];
      }
    }
    return calendar;
  }

  List<String> getWeekNames() {
    return List.generate(7, (index) => weekString[(index + _firstDay - 1) % 7]);
  }
}
