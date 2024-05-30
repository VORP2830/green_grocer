import 'package:flutter/material.dart';
import 'package:green_grocer/src/pages/orders/components/custom_divider_widget.dart';
import 'package:green_grocer/src/pages/orders/components/status_dot.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = {
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    super.key,
    required this.status,
    required this.isOverdue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusDot(
          isActive: true,
          title: 'Pedido confirmado',
        ),
        const CustomDividerWidget(),
        if (currentStatus == 1) ...[
          const StatusDot(
            isActive: true,
            title: 'Pix estornado',
            backgroundColor: Colors.orange,
          ),
          CustomDividerWidget()
        ] else if (isOverdue) ...[
          const StatusDot(
            isActive: true,
            title: 'Pagamento Pix vencido',
            backgroundColor: Colors.red,
          ),
          const CustomDividerWidget()
        ] else ...[
          StatusDot(
            isActive: currentStatus >= 2,
            title: 'Pagamento',
          ),
          const CustomDividerWidget(),
          StatusDot(
            isActive: currentStatus >= 3,
            title: 'Preparando',
          ),
          const CustomDividerWidget(),
          StatusDot(
            isActive: currentStatus >= 4,
            title: 'Envio',
          ),
          const CustomDividerWidget(),
          StatusDot(
            isActive: currentStatus == 5,
            title: 'Entregue',
          ),
        ],
      ],
    );
  }
}
