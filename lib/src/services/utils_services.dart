import 'package:intl/intl.dart';

class UtilsServices {
  priceToCurrency(double price) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(price);
  }
}