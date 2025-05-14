extension TimeExtension on DateTime {
  String get showTime =>
      "${hour.twoDigits}:${minute.twoDigits}:${second.twoDigits}";
}

extension Digits on int {
  String get twoDigits => toString().padLeft(2, '0');
}
