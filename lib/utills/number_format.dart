import 'package:intl/intl.dart';

String numberFormat(String data) {
  if (data != '') {
    var f = NumberFormat('###,###,###,###');
    return f.format(int.parse(data));
  } else {
    return '';
  }
}
