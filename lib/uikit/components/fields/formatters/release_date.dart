import 'package:intl/intl.dart';

String formatReleaseDate(String dateString) {
  final date = DateTime.parse(dateString);
  final formatter = DateFormat('d MMMM yyyy');
  return formatter.format(date);
}
