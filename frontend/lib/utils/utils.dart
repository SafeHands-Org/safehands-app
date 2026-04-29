import 'package:flutter/services.dart';
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

String timeToDisplay(String raw) {
  final timePart = raw.contains(' ') ? raw.split(' ').last : raw;
  final parts = timePart.split(':');

  if (parts.length < 2) return raw;

  final hour = int.tryParse(parts[0]) ?? 0;
  final minute = int.tryParse(parts[1]) ?? 0;
  final dt = DateTime(2000, 1, 1, hour, minute);

  return DateFormat('h:mm a').format(dt);
}

DateTime? parse(String first, String second){
  return DateTime.tryParse('$first $second:00');
}

String get today => DateTime.now().toIso8601String().substring(0, 10);

String formatDate(DateTime dt) => DateFormat.yMMMMd().format(dt);
String headerFormat(DateTime dt) => DateFormat('EEEE, MMMM d, y').format(DateTime.now());

String durationSince(Duration time) {
  final days = time.inDays;
  if (days < 1) return 'today';
  if (days < 30) return '$days day${days == 1 ? '' : 's'} ago';

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

class OnlyLettersFormatter extends TextInputFormatter {
  static final RegExp _allowed = RegExp(r"[a-zA-Z\s\-'.,]");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filtered = newValue.text.split('').where((c) => _allowed.hasMatch(c)).join();
    if (filtered == newValue.text) return newValue;
    return newValue.copyWith(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

class PartialCharactersFormatter extends TextInputFormatter {
  static final RegExp _allowed = RegExp(r"[a-zA-Z0-9\s\-'.,;:]");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filtered = newValue.text.split('').where((c) => _allowed.hasMatch(c)).join();
    if (filtered == newValue.text) return newValue;
    return newValue.copyWith(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}

String? lettersOnlyValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'This field is required.';
  final invalid = RegExp(r"[^a-zA-Z\s\-'.,]");
  if (invalid.hasMatch(value)) return 'Only letters and basic punctuation allowed.';
  return null;
}

String? instructionValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'This field is required.';
  final invalid = RegExp(r"[^a-zA-Z0-9\s\-'.,;:]");
  if (invalid.hasMatch(value)) return 'No special characters allowed.';
  return null;
}

String capitalized(String word){
  return word.split(' ')
    .map((word) => word.isNotEmpty
      ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
      : '')
    .join(' ');
}