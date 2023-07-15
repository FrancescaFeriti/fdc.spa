import 'package:intl/intl.dart';

///Utility class that defines some custom [DateFormat].
class Formats {
  static final fullDateFormat = DateFormat('KK:mm:ss aa, yyyy/MM/dd');
  static final fullDateFormatNoSeconds = DateFormat('KK:mm aa, yyyy/MM/dd');
  static final onlyDayDateFormat = DateFormat('yyyy/MM/dd');
  static final onlyDayDateFormatTicks = DateFormat('yyyy-MM-dd');
} //Formats