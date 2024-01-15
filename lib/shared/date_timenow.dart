import 'package:intl/intl.dart';

class DateTimeNow{
  static now(){
    var now = DateTime.now();
    var formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(now);
  }
}