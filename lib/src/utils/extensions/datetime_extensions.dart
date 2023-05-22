import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateTimextention on DateTime {
  Duration get minutesFromMidNight {
    return Duration(minutes: this.minute + this.hour * 60);
  }

  String? get dateTimeToDayOfWeek {
    String? dayOfWeek;
    switch (this.weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ 2";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ 3";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ 4";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ 5";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ 6";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ 7";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ nhật";
        break;
    }
    return dayOfWeek;
  }

  String? get dateTimeToDayOfWeekVN {
    String? dayOfWeek;
    switch (this.weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ Hai";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ Ba";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ Tư";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ Năm";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ Sáu";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ Bảy";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ Nhật";
        break;
    }
    return dayOfWeek;
  }

  String get dayOfWeekAndDate {
    return '$dateTimeToDayOfWeekVN, $dateTimeToDayOfWeekVN, $dateTimeToDDMMYYYY';
  }

  String get dayOfWeekAndDateAndTime {
    return '$dateTimeToDayOfWeekVN, $dateTimeToDDMMYYYY, $dateTimeToVnHour24h';
  }

  String get dayOfWeekAndTime {
    return '$dateTimeToDDMMYYYYHHmm';
  }

  String get dayOfDate {
    return '$dateTimeToDDMMYYYY';
  }

  String get dayOfWeek {
    return '$dateTimeToDayOfWeekVN, $dateTimeToDDMMYYYY';
  }

  String get hourAndDateTime {
    return '$dateTimeToVnHour24h, $dateTimeToDDMMYYYY';
  }

  String get dateTimeInTable {
    return '$dateTimeToDDMMYYYY - $dateTimeToVnHour';
  }

  String get dateTimeInWeather {
    return '$dateTimeToDayOfWeek, $dateTimeToDDMMYYYY';
  }

  String get dayOfWeekDateTimeVN {
    return '$dateTimeToDayOfWeekVN $dateTimeToDDMMYYYY - $dateTimeToVnHour24h';
  }

  String get dateTimeString {
    return '$dateTimeToDDMMYYYY - $dateTimeToVnHour24h';
  }

  String get dateString => dateTimeToDDMMYYYY;

  String get dateTimeToDayAndMonth {
    var formatter = new DateFormat("dd/MM");
    return formatter.format(this);
  }

  String get dateTimeToDay {
    var formatter = new DateFormat("dd");
    return formatter.format(this);
  }

  DateTime addTimeToDate(DateTime hour) {
    return DateTime(this.year, this.month, this.day, hour.hour, hour.minute);
  }

  String get dateTimeToDDMMYYYY {
    var formatter = new DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }

  String get dateTimeToDDMMYYYYHHmm {
    var formatter = new DateFormat("dd/MM/yyyy HH:mm");
    return formatter.format(this);
  }

  String get exportName {
    var formatter = new DateFormat("dd-MM-yyyy");
    return formatter.format(this);
  }

  String get monthAndYear {
    return 'T${this.month}/${this.year}';
  }

  String get dateTimeToVnHour {
    String hour = DateFormat("hh:mm a").format(this);
    return hour.replaceAll("PM", "chiều").replaceAll("AM", "sáng");
  }

  String get dateTimeToVnHour24h {
    String hour = DateFormat("HH:mm").format(this);
    return hour;
  }

  String get dateTimeToWeekdayAndDayMonth {
    return this.dateTimeToDayOfWeek! + ", " + this.dateTimeToDayAndMonth;
  }

  String get convertToString {
    var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    return formatter.format(this);
  }

  String get toUtcString {
    return this.toUtc().toIso8601String();
  }

  String get toUtcServer {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return formatter.format(this.toUtc());
  }

  String formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('yyyy-MM-dd'); // <- use skeleton here
    return format.format(timestamp.toDate());
  }

  DateTime get onlyUtcDate => DateTime.utc(this.year, this.month, this.day);

  bool isSameDate(DateTime other) {
    try {
      return this.year == other.year &&
          this.month == other.month &&
          this.day == other.day;
    } catch (ex) {
      return false;
    }
  }
}
