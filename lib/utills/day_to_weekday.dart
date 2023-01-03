String dayToWeekday(int weekday) {
  switch (weekday) {
    case 1:
      return 'Mon';
    case 2:
      return 'The';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }
}
