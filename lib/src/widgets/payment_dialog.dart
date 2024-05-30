import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  PaymentDialog({
    super.key,
    required this.order,
  });

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Conteúdo
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com Pix',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //QR Code
                QrImageView(
                  data: 'https://vorp.com.br',
                  version: QrVersions.auto,
                  size: 200,
                ),
                //Vencimento
                Text(
                  'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                //Total
                Text(
                  'Total: R\$ ${utilsServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Botão de copiar
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    'Copiar código Pix',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ))
        ],
      ),
    );
  }
}