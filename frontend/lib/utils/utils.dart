import 'package:intl/intl.dart';

const dayMap = {
  'monday'   : DateTime.monday,
  'tuesday'  : DateTime.tuesday,
  'wednesday': DateTime.wednesday,
  'thursday' : DateTime.thursday,
  'friday'   : DateTime.friday,
  'saturday' : DateTime.saturday,
  'sunday'   : DateTime.sunday,
};

const priorityRank = {
  'high'  : 1,
  'medium': 2,
  'low'   : 3,
};

int get weekdayToday => DateTime.now().weekday;

Duration difference(DateTime other) => DateTime.now().difference(other);

DateTime timeToDateTime(String time) {
  final parts = time.split(':');
  final now = DateTime.now();
  return DateTime(
    now.year, now.month, now.day,
    int.parse(parts[0]),
    int.parse(parts[1]),
  );
}

DateTime futureTimeToDateTime(String time, {int daysAhead = 0}) {
  final parts = time.split(':');
  final base = DateTime.now().add(Duration(days: daysAhead));
  return DateTime(
    base.year, base.month, base.day,
    int.parse(parts[0]),
    int.parse(parts[1]),
  );
}

String timeToDisplay(String time) {
  final dt = DateTime.parse("1970-01-01 $time");

  return DateFormat('h:mm a').format(dt);
}

DateTime? parse(String first, String second){
  return DateTime.tryParse('$first $second:00');
}

String get today => DateTime.now().toIso8601String().substring(0, 10);

String formatDate(DateTime dt){
  return DateFormat.yMMMMd().format(dt);
}

String durationSince(Duration time) {
  final days = time.inDays;
  if (days < 1) return 'today';
  if (days < 30) return '$days day${days == 1 ? '' : 's'} agi';

  final months = days ~/ 30;
  if (months < 12) return '$months month${months == 1 ? '' : 's'} ago';

  final years = days ~/ 365;
  return '$years year${years == 1 ? '' : 's'} ago';
}

String durationTill(Duration difference) {
  if (difference.inHours < 24) {
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    if (hours == 0) return '${minutes}m';
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  } else {
    return '${difference.inDays}d';
  }
}