dateFormat(DateTime date) {
  String month = _monthName(date.month);

  return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}, ${date.day.toString().padLeft(2, '0')} $month ${date.year}";
}

String _monthName(int month) {
  switch (month) {
    case DateTime.january:
      return 'January';
    case DateTime.february:
      return 'February';
    case DateTime.march:
      return 'March';
    case DateTime.april:
      return 'April';
    case DateTime.may:
      return 'May';
    case DateTime.june:
      return 'June';
    case DateTime.july:
      return 'July';
    case DateTime.august:
      return 'August';
    case DateTime.september:
      return 'September';
    case DateTime.october:
      return 'October';
    case DateTime.november:
      return 'November';
    case DateTime.december:
      return 'December';

    default:
      return "";
  }
}
