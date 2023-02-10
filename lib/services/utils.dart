import 'dart:ffi';

import 'package:intl/intl.dart';

class Utils {
  static String formatDate(String strDate) {
    var dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(DateTime.parse(strDate)).toString();
  }
}
