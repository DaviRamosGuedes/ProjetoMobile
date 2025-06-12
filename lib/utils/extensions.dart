extension DateTimeExtension on DateTime {
  String formatDate() {
    return '${day.toString().padLeft(2, '0')}/'
        '${month.toString().padLeft(2, '0')}/'
        '${year.toString()}';
  }
}
