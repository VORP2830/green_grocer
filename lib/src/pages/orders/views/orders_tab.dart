import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:green_grocer/src/pages/orders/controllers/orders_controller.dart';
import 'package:green_grocer/src/pages/orders/views/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Pedidos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemCount: controller.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(
                  order: controller.orders[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
