import 'package:intl/intl.dart';

extension NumberParsing on DateTime {
  String DateString() {
    return DateFormat('dd-MM-y').format(this);
  }

  String format(String option) {
    return DateFormat(option).format(this);
  }

  String DayString(String option) {
    print(option);
    option = option.toLowerCase();
    return ['short', 'long'].contains(option)
        ? DateFormat(option == 'short' ? 'M' : 'MM').format(this)
        : "Wrong option given use 'short' or 'long'";
  }

  String DayNum(String option) {
    option = option.toLowerCase();
    return ['short', 'long'].contains(option)
        ? DateFormat(option == 'short' ? 'd' : 'dd').format(this)
        : "Wrong option given use 'short' or 'long'";
  }

  String ToTimeString(String precision) {
    precision = precision.toLowerCase();
    if (precision == 'hours' || precision == 'hour') {
      return DateFormat('HH').format(this);
    } else if (precision == 'minutes' || precision == 'minute') {
      return DateFormat('HH:mm').format(this);
    } else if (precision == 'seconds' || precision == 'second') {
      return DateFormat('HH:mm:ss').format(this);
    } else {
      return DateFormat('HH:mm:ss').format(this);
    }
  }

  String ToAppointmentDateString({String precision}) {
    precision = precision.toLowerCase();
    if (precision == 'year' || precision == 'years') {
      return DateFormat('EEEE d MMMM y HH:mm').format(this);
    } else if (precision == 'month' || precision == 'months') {
      return DateFormat('EEEE d MMMM HH:mm').format(this);
    } else if (precision == 'day' || precision == 'days') {
      return DateFormat('EEEE HH:mm').format(this);
    } else {
      return "Wrong input given use 'year', 'month' or 'day'";
    }
  }

  String ToInput(String input, [bool capitalletters = false]) {
    input = input.toLowerCase();
    while (input.contains('  ')) {
      input = input.replaceAll('  ', ' ');
    }
    var inputs = input.split(' ');

    var map = {
      'minutes': 'mm',
      'minutesshort': 'm',
      'hours': 'HH',
      'hoursshort': 'H',
      'daynum': 'dd',
      'daynumshort': 'd',
      'daystring': 'EEEE',
      'daystringshort': 'E',
      'monthnum': 'M',
      'year': 'yyyy',
      'yearshort': 'yy',
      'january': 'MMMM',
      'february': 'MMMM',
      'march': 'MMMM',
      'april': 'MMMM',
      'may': 'MMMM',
      'june': 'MMMM',
      'july': 'MMMM',
      'august': 'MMMM',
      'october': 'MMMM',
      'november': 'MMMM',
      'december': 'MMMM',
      'jan': 'MMM',
      'feb': 'MMM',
      'mar': 'MMM',
      'apr': 'MMM',
      'jun': 'MMM',
      'jul': 'MMM',
      'aug': 'MMM',
      'oct': 'MMM',
      'nov': 'MMM',
      'dec': 'MMM',
      'monday': 'EEEE',
      'tuesday': 'EEEE',
      'wednesday': 'EEEE',
      'thursday': 'EEEE',
      'friday': 'EEEE',
      'saturday': 'EEEE',
      'sunday': 'EEEE',
      'mon': 'EE',
      'tue': 'EE',
      'wed': 'EE',
      'thu': 'EE',
      'fri': 'EE',
      'sat': 'EE',
      'sun': 'EE',
    };
    var shortyear = false;
    for (var i = 0; i < inputs.length; i++) {
      //check for possible input {0}9:02:01
      if (inputs[i].contains(':') && inputs.length <= 8) {
        var times = inputs[i].split(':');

        if (double.tryParse(times[0]) != null &&
            double.tryParse(times[1]) != null) {
          if (times.length == 2) {
            inputs[i] = times[0].length == 2 ? 'HH:mm' : 'H:mm';
          } else if (times.length == 3) {
            inputs[i] = times[0].length == 2 ? 'HH:mm:ss' : 'H:mm:ss';
          }
        }
        //check for possible input {0}2-{0}1-{20}20
      } else if (inputs[i].contains('-')) {
        var temp = inputs[i].split('-');

        if (temp.length == 2) {
          if (int.tryParse(temp[0]) == null && int.tryParse(temp[1]) == null) {
            inputs[i] = map[temp[0]] + '-' + map[temp[1]];
          } else {
            var shortday = temp[0].length == 2 && int.parse(temp[0]) < 10;
            var shortmonth = temp[1].length == 2 && int.parse(temp[1]) < 10;

            inputs[i] = (shortday ? '' : '0') +
                map['daynumshort'] +
                '-' +
                (shortmonth ? '' : '0') +
                map['monthnum'];
          }
        } else if (temp.length == 3) {
          if (int.tryParse(temp[0]) == null &&
              int.tryParse(temp[1]) == null &&
              int.tryParse(temp[2]) == null) {
            inputs[i] = map[temp[0]] + '-' + map[temp[1]] + '-' + map[temp[2]];
          } else {
            var shortday = temp[0].length == 2 && int.parse(temp[0]) < 10;
            var shortmonth = temp[1].length == 2 && int.parse(temp[1]) < 10;
            shortyear = temp[2].length == 2;

            inputs[i] = (shortday ? '0' : '') +
                map['daynumshort'] +
                '-' +
                (shortmonth ? '0' : '') +
                map['monthnum'] +
                '-' +
                (shortyear ? map['yearshort'] : map['year']);
          }
        }
      }
      //check for possible input {0}2/{0}1/{20}20
      else if (inputs[i].contains('/')) {
        var temp = inputs[i].split('/');

        if (temp.length == 2) {
          if (int.tryParse(temp[0]) == null && int.tryParse(temp[1]) == null) {
            inputs[i] = map[temp[0]] + '/' + map[temp[1]];
          } else {
            var shortday = temp[0].length == 2 && int.parse(temp[0]) < 10;
            var shortmonth = temp[1].length == 2 && int.parse(temp[1]) < 10;

            inputs[i] = (shortday ? '0' : '') +
                map['daynumshort'] +
                '/' +
                (shortmonth ? '0' : '') +
                map['monthnum'];
          }
        } else if (temp.length == 3) {
          if (int.tryParse(temp[0]) == null &&
              int.tryParse(temp[1]) == null &&
              int.tryParse(temp[2]) == null) {
            inputs[i] = map[temp[0]] + '/' + map[temp[1]] + '/' + map[temp[2]];
          } else {
            var shortday = temp[0].length == 2 && int.parse(temp[0]) < 10;
            var shortmonth = temp[1].length == 2 && int.parse(temp[1]) < 10;
            shortyear = temp[2].length == 2;

            inputs[i] = (shortday ? '0' : '') +
                map['daynumshort'] +
                '/' +
                (shortmonth ? '0' : '') +
                map['monthnum'] +
                '/' +
                (shortyear ? map['yearshort'] : map['year']);
          }
        }
      } else if (inputs[i].length == 4 && int.tryParse(inputs[i]) != null) {
        inputs[i] = 'yyyy';
      } else {
        inputs[i] = map[inputs[i]];
      }
    }

    var formatstring = inputs.reduce((value, element) => value + ' ' + element);
    var formattedDate = DateFormat(formatstring).format(this);

    return capitalletters ? formattedDate : formattedDate.toLowerCase();
  }

  bool operator >(DateTime other) {
    return isAfter(other);
  }

  bool operator <(DateTime other) {
    return isBefore(other);
  }

  bool operator <=(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }

  bool operator >=(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }
}
