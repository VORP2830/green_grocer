import 'package:intl/intl.dart';

class UtilsServices {
  String priceToCurrency(double price) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(price);
  }

  String formatDateTime(DateTime datetime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(datetime);
  }
}
